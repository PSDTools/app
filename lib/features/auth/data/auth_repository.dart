/// This library contains the authentication feature's data fetchers.
library;

import "dart:developer";
import "dart:typed_data";

import "package:appwrite/appwrite.dart";
import "package:appwrite/models.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../utils/api.dart";
import "../../../utils/device_repository.dart";
import "../domain/account_type.dart";
import "../domain/pirate_user_entity.dart";
import "avatar_repository.dart";

part "auth_repository.g.dart";

/// A repository for authentication.
abstract interface class AuthRepository {
  /// Authenticate the user.
  Future<PirateUserEntity> authenticate({required bool anonymous});
}

/// The default implementation of [AuthRepository].
base class _AppwriteAuthRepository implements AuthRepository {
  /// Create a new instance of [_AppwriteAuthRepository].
  const _AppwriteAuthRepository(
    Account account,
    Device platform,
    AvatarRepository avatar,
  )   : _account = account,
        _platform = platform,
        _avatarRepo = avatar;

  /// The Appwrite [Account].
  final Account _account;

  /// The [currentPlatform].
  final Device _platform;

  /// The current user's avatar.
  final AvatarRepository _avatarRepo;

  @override
  Future<PirateUserEntity> authenticate({bool anonymous = false}) async {
    User account;
    try {
      account = await _account.get();
    } catch (e, s) {
      log("Failed to fetch session.", error: e, stackTrace: s);
      if (anonymous) {
        try {
          await _account.createAnonymousSession();
        } catch (e, s) {
          log("Failed to create anonymous session.", error: e, stackTrace: s);
        }
      } else {
        try {
          // Go to the Google account login page.
          switch (_platform) {
            // Both Android and iOS need the same behavior, so it reuses it.
            case Device.android || Device.ios:
              await _account.createOAuth2Session(
                provider: "google",
              );

            // TODO(lishaduck): The web needs different behavior than that of linux/mac/windows/fuchsia.
            case Device.web ||
                  Device.linux ||
                  Device.macOS ||
                  Device.windows ||
                  Device.other:
              await _account.createOAuth2Session(
                provider: "google",
                success: "${Uri.base.origin}/auth.html",
                failure: "${Uri.base}",
              );
          }
        } catch (e, s) {
          log("Failed to create OAuth2 session.", error: e, stackTrace: s);
        }
      }

      account = await _account.get();
    }

    try {
      final accountType = AccountType.fromEmail(account.email);
      final avatar = await _avatarRepo.getAvatar();

      return PirateUserEntity(
        name: account.name,
        email: account.email,
        accountType: accountType,
        avatar: avatar,
      );
    } catch (e, s) {
      log("Failed to fetch user data.", error: e, stackTrace: s);

      return fakeUser;
    }
  }
}

/// The email address used in case things go wrong.
const redactedEmail = "redacted@example.com";

/// The name used in case things go wrong.
const redactedName = "Anonymous";

/// The avatar used in case things go wrong.
final redactedAvatar = Uint8List(1);

/// A fake user, for use when all else fails.
final fakeUser = PirateUserEntity(
  name: redactedName,
  email: redactedEmail,
  accountType: AccountType.student,
  avatar: redactedAvatar,
);

/// Get the authentication data provider.
@Riverpod(keepAlive: true)
AuthRepository auth(AuthRef ref) {
  final account = ref.watch(accountsProvider);
  final platform = ref.watch(currentPlatformProvider);
  final avatar = ref.watch(avatarProvider);

  return _AppwriteAuthRepository(account, platform, avatar);
}
