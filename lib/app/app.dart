import "dart:async";
import "dart:developer";

import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter_web_plugins/flutter_web_plugins.dart";

import "view/app.dart";

export "app_router.dart";

class App extends ConsumerWidget with AppView {
  App({super.key});

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
