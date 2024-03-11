/// This library contains the authentication feature's data fetchers.
library;

import "dart:typed_data";

import "package:appwrite/appwrite.dart";
import "package:appwrite/models.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../utils/api.dart";
import "../../../utils/log.dart";
import "../../utils/data/device_repository.dart";
import "../../utils/domain/device_model.dart";
import "../domain/account_type.dart";
import "../domain/pirate_user_entity.dart";
import "avatar_repository.dart";

part "auth_repository.g.dart";

/// A repository for authentication.
abstract interface class AuthRepository {
  /// Authenticate the user.
  Future<void> authenticate({required bool anonymous});

  /// Get data about the current user.
  Future<PirateUserEntity> getData();
}

/// The default implementation of [AuthRepository].
base class _AppwriteAuthRepository implements AuthRepository {
  /// Create a new instance of [_AppwriteAuthRepository].
  const _AppwriteAuthRepository(this.account, this.platform, this.avatarRepo);

  /// The Appwrite [Account].
  final Account account;

  /// The [currentPlatform].
  final Device platform;

  /// The current user's avatar.
  final AvatarRepository avatarRepo;

  /// Get a user from Appwrite.
  Future<User> getUser() => account.get();

  @override
  Future<PirateUserEntity> getData() async {
    final user = await getUser();

    return getUserData(user);
  }

  Future<PirateUserEntity> getUserData(User user) async {
    final accountType = AccountType.fromEmail(user.email);
    final avatar = await avatarRepo.getAvatar();

    return PirateUserEntity(
      name: user.name,
      email: user.email,
      accountType: accountType,
      avatar: avatar,
      isLoggedIn: true,
    );
  }

  @override
  Future<void> authenticate({bool anonymous = false}) async {
    try {
      await getUser();
    } catch (e, s) {
      log.warning("Failed to fetch session.", e, s);
      await _createAccount(anonymous);

      await getUser();
    }
  }

  Future<void> _createAccount(bool anonymous) async {
    if (anonymous) {
      try {
        await account.createAnonymousSession();
      } catch (e, s) {
        log.warning("Failed to create anonymous session.", e, s);
      }
    } else {
      try {
        // Go to the Google account login page.
        switch (platform) {
          // Both Android and iOS need the same behavior, so it reuses it.
          case Device.android || Device.ios:
            await account.createOAuth2Session(
              provider: "google",
            );

          // TODO(lishaduck): The web needs different behavior than that of linux/mac/windows/fuchsia.
          case Device.web ||
                Device.linux ||
                Device.macos ||
                Device.windows ||
                Device.other:
            await account.createOAuth2Session(
              provider: "google",
              success: "${Uri.base.origin}/auth.html",
              failure: "${Uri.base}",
            );
        }
      } catch (e, s) {
        log.warning("Failed to create OAuth2 session.", e, s);
      }
    }
  }
}

/// The email address used in case things go wrong.
const redactedEmail = "redacted@example.com";

/// The name used in case things go wrong.
const redactedName = "Anonymous";

/// The avatar used in case things go wrong.
final redactedAvatar = Uint8List(1);

/// Get the authentication data provider.
@Riverpod(keepAlive: true)
AuthRepository auth(AuthRef ref) {
  final account = ref.watch(accountsProvider);
  final platform = ref.watch(currentPlatformProvider);
  final avatar = ref.watch(avatarProvider);

  return _AppwriteAuthRepository(account, platform, avatar);
}
