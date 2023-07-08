// import "package:flutter/foundation.dart";
// import "package:freezed_annotation/freezed_annotation.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../data/auth_data.dart";

// part "coins_domain.freezed.dart";
part "auth_domain.g.dart";

///
@riverpod
class Auth extends _$Auth {
  @override
  bool build() {
    return false;
  }

  /// Authenticate the current user.
  Future<void> authenticate() async {
    final auth = ref.watch(oauthProvider);

    await auth.authenticate();
  }
}
