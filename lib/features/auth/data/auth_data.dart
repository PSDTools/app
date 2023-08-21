/// The auth feature's main presentation.
library;

import "package:appwrite/appwrite.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../utils/api.dart";
import "../../utils/data/device_data.dart";
import "../../utils/domain/device_model.dart";
import "../domain/auth_model.dart";
import "avatar_data.dart";

part "auth_data.g.dart";

/// A repository for authentication.
abstract interface class AuthRepository {
  /// Authenticate the user.
  Future<PirateUser> authenticate();
}

/// The default implementation of [AuthRepository].
class AppwriteAuthRepository implements AuthRepository {
  /// Create a new instance of [AppwriteAuthRepository].
  const AppwriteAuthRepository(
    Account session,
    Device platform,
    AvatarRepository avatar,
  )   : _session = session,
        _platform = platform,
        _avatarRepo = avatar;

  /// The Appwrite [Account].
  final Account _session;

  /// The [currentPlatform].
  final Device _platform;

  /// The current user's avatar.
  final AvatarRepository _avatarRepo;

  @override
  Future<PirateUser> authenticate() async {
    // Go to the Google account login page.
    switch (_platform) {
      // Both Android and iOS need the same behavior, so it reuses it.
      case Device.android:
      case Device.ios:
        await _session.createOAuth2Session(
          provider: "google",
        );
      // TODO(ParkerH27): The web needs different behavior than that of linux/mac/windows.
      case Device.other:
        await _session.createOAuth2Session(
          provider: "google",
          success: "${Uri.base.origin}/auth.html",
          failure: "${Uri.base}",
        );
    }

    final account = await _session.get();
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

/// Auth data provider
@riverpod
AuthRepository auth(AuthRef ref) {
  final account = ref.watch(accountsProvider);
  final platform = ref.watch(currentPlatformProvider);
  final avatar = ref.watch(avatarProvider.select((value) => value));

  return AppwriteAuthRepository(account, platform, avatar);
}
