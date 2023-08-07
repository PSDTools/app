/// The controller for the auth page, part of the presentation layer.
library;

import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../domain/auth_domain.dart";
import "../../domain/auth_model.dart";

part "auth_page_controller.g.dart";

/// Like [PirateAuthModel], but just for [AuthPageController].
typedef Auth = Future<void> Function();

/// The controller for the auth page.
@riverpod
class AuthPageController extends _$AuthPageController {
  @override
  Auth build() {
    final auth = ref.watch(
      pirateAuthProvider.notifier.select(
        (value) => value,
      ),
    );

    return auth.authenticate;
  }
}
