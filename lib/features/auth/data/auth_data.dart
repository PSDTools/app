/// The auth feature's data.
library pirate_code.features.auth.data;

import "package:appwrite/appwrite.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../utils/api.dart";
import "../domain/auth_domain.dart";

part "auth_data.g.dart";

/// A repository for authentication.
// Too bad, so sad.
// ignore: one_member_abstracts
abstract interface class AuthRepository {
  /// Authenticate the user.
  Future<PirateUser> authenticate();
}

/// The default implementation of [AuthRepository].
class AppwriteAuthRepository implements AuthRepository {
  /// Create a new instance of [AppwriteAuthRepository].
  AppwriteAuthRepository(this.client);

  /// The Appwrite client.
  final Client client;

  @override
  Future<PirateUser> authenticate() async {
    final session = Account(client);

    // Go to the Google account login page.
    await session.createOAuth2Session(
      provider: "google",
      success: "${Uri.base.origin}/auth.html",
      failure: "${Uri.base}",
    );
    final account = await session.get();
    return PirateUser(
      name: account.name,
    );
  }
}

/// Auth data provider
@riverpod
AuthRepository auth(AuthRef ref) {
  final client = ref.watch(clientProvider);

  return AppwriteAuthRepository(client);
}
