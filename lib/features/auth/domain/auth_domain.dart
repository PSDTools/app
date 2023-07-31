/// The auth feature's domain.
library pirate_code.features.auth.domain;

import "package:flutter/foundation.dart";
import "package:freezed_annotation/freezed_annotation.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../data/auth_data.dart";

part "auth_domain.freezed.dart";
part "auth_domain.g.dart";

/// A pirate user.
@freezed
@immutable
sealed class PirateUser with _$PirateUser {
  /// Create a new, immutable instance of [PirateUser].
  const factory PirateUser({
    /// The user's name.
    required String name,
  }) = _PirateUser;
}

/// Get the current user.
@riverpod
class PirateAuth extends _$PirateAuth {
  @override
  PirateUser? build() {
    return null;
  }

  /// Authenticate the current user.
  Future<void> authenticate() async {
    final auth = ref.watch(authProvider);
    final user = await auth.authenticate();
    state = user;
  }
}
