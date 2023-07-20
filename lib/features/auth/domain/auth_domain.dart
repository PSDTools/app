/// The auth feature's domain.
library pirate_code.features.auth.domain;

import "package:auto_route/auto_route.dart";
import "package:flutter/foundation.dart";
import "package:freezed_annotation/freezed_annotation.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../app/app_router.dart";
import "../data/auth_data.dart";

part "auth_domain.freezed.dart";
part "auth_domain.g.dart";

/// A pirate user.
@freezed
@immutable
class PirateUser with _$PirateUser {
  /// Create a new, immutable instance of [PirateUser].
  const factory PirateUser({
    /// The user's name.
    required String name,
  }) = _PirateUser;
}

///
@riverpod
class Auth extends _$Auth {
  @override
  PirateUser? build() {
    return null;
  }

  /// Authenticate the current user.
  Future<void> authenticate(StackRouter router) async {
    final auth = ref.watch(oauthProvider);
    final user = await auth.authenticate();
    state = user;
    await router.push(const WrapperRoute());
  }
}
