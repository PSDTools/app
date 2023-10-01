/// This library contains the authentication feature's data fetchers.
library;

import "package:appwrite/appwrite.dart";
import "package:appwrite/models.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../utils/api.dart";
import "../../../utils/log.dart";
import "../../utils/data/device_data.dart";
import "../../utils/domain/device_model.dart";
import "../domain/auth_model.dart";
import "avatar_data.dart";

part "auth_data.g.dart";

/// A repository for authentication.
abstract interface class AuthRepository {
  /// Authenticate the user.
  Future<PirateUser> authenticate({required bool anonymous});
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
  Future<PirateUser> authenticate({bool anonymous = false}) async {
    User account;
    try {
      account = await _account.get();
    } catch (e, s) {
      log.warning("Failed to fetch session.", e, s);
      if (anonymous) {
        try {
          await _account.createAnonymousSession();
        } catch (e, s) {
          log.warning("Failed to create anonymous session.", e, s);
        }
      } else {
        try {
          // Go to the Google account login page.
          switch (_platform) {
            // Both Android and iOS need the same behavior, so it reuses it.
            case Device.android:
            case Device.ios:
              await _account.createOAuth2Session(
                provider: "google",
              );
            // TODO(lishaduck): The web needs different behavior than that of linux/mac/windows.
            case Device.web:
            case Device.linux:
            case Device.macos:
            case Device.windows:
            case Device.other:
              await _account.createOAuth2Session(
                provider: "google",
                success: "${Uri.base.origin}/auth.html",
                failure: "${Uri.base}",
              );
          }
        } catch (e, s) {
          log.warning("Failed to create OAuth2 session.", e, s);
        }
      }

      account = await _account.get();
    }
    final accountType = AccountType.fromEmail(account.email);
    final avatar = await _avatarRepo.getAvatar();

    return PirateUser(
      name: account.name,
      email: account.email,
      accountType: accountType,
      avatar: avatar,
    );
  }
}

/// Get the authentication data provider.
@Riverpod(keepAlive: true)
AuthRepository auth(AuthRef ref) {
  final account = ref.watch(accountsProvider);
  final platform = ref.watch(currentPlatformProvider);
  final avatar = ref.watch(avatarProvider.select((value) => value));

  return _AppwriteAuthRepository(account, platform, avatar);
}
