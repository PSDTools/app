/// The auth feature's main presentation.
library;

import "package:appwrite/appwrite.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../utils/api.dart";
import "../domain/auth_model.dart";

part "auth_data.g.dart";

/// A repository for authentication.
abstract interface class AuthRepository {
  /// Authenticate the user.
  Future<PirateUser> authenticate();
}

/// The default implementation of [AuthRepository].
class AppwriteAuthRepository implements AuthRepository {
  /// Create a new instance of [AppwriteAuthRepository].
  const AppwriteAuthRepository(this.session);

  /// The Appwrite account.
  final Account session;

  @override
  Future<PirateUser> authenticate() async {
    // Go to the Google account login page.
    await session.createOAuth2Session(
      provider: "google",
      success: "${Uri.base.origin}/auth.html",
      failure: "${Uri.base}",
    );
    final account = await session.get();
    return PirateUser(
      name: account.name,
      email: account.email,
      accountType: account.email.endsWith("@student.psdr3.org")
          ? AccountType.student
          : account.email.endsWith("@psdr3.org")
              ? AccountType.teacher
              : AccountType.dev,
    );
  }
}

/// Auth data provider
@riverpod
AuthRepository auth(AuthRef ref) {
  final account = ref.watch(accountsProvider);

  return AppwriteAuthRepository(account);
}
