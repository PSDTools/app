/// This library contains the authentication feature's business logic.
library;

import "package:riverpod_annotation/riverpod_annotation.dart";

import "../data/auth_repository.dart";
import "../domain/pirate_auth_model.dart";
import "../domain/pirate_user.dart";

part "auth_service.g.dart";

/// Get the current user.
@Riverpod(keepAlive: true)
class PirateAuth extends _$PirateAuth {
  @override
  FutureOr<PirateAuthModel> build() async {
    _auth = ref.watch(authProvider);

    return _createSession(anonymous: true);
  }

  AuthRepository? _auth;

  /// Authenticate the current user.
  Future<void> authenticate() async {
    state = await AsyncValue.guard(_createSession);
  }

  Future<PirateAuthModel> _createSession({bool anonymous = false}) async {
    final account = await _auth?.authenticate(anonymous: anonymous);

    return PirateAuthModel(
      user: account,
    );
  }

  /// Create a new anonymous session for the user.
  Future<void> anonymous() async {
    state = await AsyncValue.guard(() => _createSession(anonymous: true));
  }
}

/// Get the current user with minimal fuss.
///
/// Use [pirateAuthProvider] for more granular output.
@Riverpod(keepAlive: true)
PirateUser? user(UserRef ref) => ref.watch(
      pirateAuthProvider.select((value) => value.asData?.value.user),
    );

/// The email address used in case things go wrong.
const redactedEmail = "redacted@example.com";
