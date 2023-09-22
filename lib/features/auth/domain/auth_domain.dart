/// The auth feature's domain.
library;

import "package:riverpod_annotation/riverpod_annotation.dart";

import "../data/auth_data.dart";
import "auth_model.dart";

part "auth_domain.g.dart";

/// Get the current user.
@Riverpod(keepAlive: true)
class PirateAuth extends _$PirateAuth {
  @override
  Future<PirateUser> build() async {
    return _createSession(anonymous: true);
  }

  /// Authenticate the current user.
  Future<void> authenticate() async {
    state = await AsyncValue.guard(_createSession);
  }

  Future<PirateUser> _createSession({bool anonymous = false}) async {
    final auth = ref.watch(authProvider);
    return auth.authenticate(anonymous: anonymous);
  }

  /// Create a new anonymous session for the user.
  Future<void> anonymous() async {
    state = await AsyncValue.guard(() => _createSession(anonymous: true));
  }
}
