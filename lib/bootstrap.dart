import "dart:async";
import "dart:developer";

import "package:flutter/widgets.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter_web_plugins/flutter_web_plugins.dart";

Future<void> bootstrap(FutureOr<ConsumerWidget> Function() builder) async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  usePathUrlStrategy();

  await runZonedGuarded(
    () async => runApp(
      ProviderScope(
        child: await builder(),
      ),
    ),
    (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
  );
}
