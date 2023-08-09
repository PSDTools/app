/// The auth feature's domain.
library;

import "package:riverpod_annotation/riverpod_annotation.dart";

import "../data/auth_data.dart";
import "auth_model.dart";

part "auth_domain.g.dart";

/// Get the current user.
@riverpod
class PirateAuth extends _$PirateAuth {
  @override
  PirateAuthModel build() {
    return const PirateAuthModel();
  }

  /// Authenticate the current user.
  Future<void> authenticate() async {
    final auth = ref.watch(authProvider);
    final user = await auth.authenticate();
    state = state.copyWith(user: user);
  }
}
