import "dart:async";
import "dart:developer";

import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter_web_plugins/url_strategy.dart";

mixin Bootstrap on ConsumerWidget {
  Future<void> bootstrap() async {
    FlutterError.onError = (details) {
      log(details.exceptionAsString(), stackTrace: details.stack);
    };

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
