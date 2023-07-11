/// The auth feature's data.
library pirate_code.features.auth.data;

import "package:appwrite/appwrite.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../utils/data/api.dart";

part "auth_data.g.dart";

/// A repository for authentication.
// Too bad, so sad.
// ignore: one_member_abstracts
abstract interface class AuthRepository {
  /// Authenticate the user.
  Future<void> authenticate();
}

/// The default implementation of [AuthRepository]
class AppwriteAuthRepository implements AuthRepository {
  /// Create a new instance of [AppwriteAuthRepository].
  AppwriteAuthRepository(this.client);

  /// The Appwrite client.
  final Client client;

  @override
  Future<void> authenticate() async {
    final account = Account(client);

    // Go to Google account login page
    await account.createOAuth2Session(
      provider: "google",
      success: "http://localhost:65084/auth.html",
      failure: "http://localhost:65084/login",
    );
  }
}

/// Auth data provider
@riverpod
AuthRepository oauth(OauthRef ref) {
  final client = ref.watch(clientProvider);

  return AppwriteAuthRepository(client);
}
