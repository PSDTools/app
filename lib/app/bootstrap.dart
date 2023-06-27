/// The app's initiation code.
library pirate_code.app.bootstrap;

import "dart:async";
import "dart:developer";

import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter_web_plugins/url_strategy.dart";

/// Bootstrap capabilities for the app.
/// This mixin should be used on the [ConsumerWidget] that is the root of the app in the `main` [Function].
/// It will handle setting up the app for use.
mixin Bootstrap on ConsumerWidget {
  /// Bootstrap the app.
  ///
  /// This function will handle the following:
  /// - [FlutterError.onError] will be set to log errors to the console.
  /// - [usePathUrlStrategy] will be called to use path-style URLs.
  /// - [runZonedGuarded] will be used to catch errors and log them to the console.
  /// - [runApp] will be called to run the app.
  /// - [ProviderScope] will be used to wrap the app.
  Future<void> bootstrap() async {
    FlutterError.onError = (details) {
      log(details.exceptionAsString(), stackTrace: details.stack);
    };

    // Don't use hash style routes.
    usePathUrlStrategy();

    await runZonedGuarded(
      () async => runApp(
        ProviderScope(
          child: this,
        ),
      ),
      (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
    );
  }
}
