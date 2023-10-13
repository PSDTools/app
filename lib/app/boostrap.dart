/// Including the app's initiation code.
library;

import "dart:async";
import "package:flutter/foundation.dart";
import "package:flutter/services.dart";
import "package:flutter/widgets.dart";
import "package:flutter_web_plugins/url_strategy.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../utils/log.dart";

/// Turn any widget into a flow-blown app.
mixin Bootstrap on Widget {
  /// Bootstrap the app.
  ///
  /// This function will handle the following:
  /// - [FlutterError.onError] will be set to log errors to the console.
  /// - [usePathUrlStrategy] will be called to use path-style URLs.
  /// - [runApp] will be called to run the app.
  /// - [ProviderScope] will be used to wrap the app.
  Future<void> bootstrap() async {
    await initLogging();

    FlutterError.onError = (details) {
      log.shout(
        "Uncaught Flutter error:",
        details.exceptionAsString(),
        details.stack,
      );
    };

    LicenseRegistry.addLicense(() async* {
      final license = await rootBundle.loadString(
        "google_fonts/mr_dafoe/OFL.txt",
      );

      yield LicenseEntryWithLineBreaks(["mr_dafoe"], license);
    });

    // Don't use hash style routes.
    usePathUrlStrategy();

    // Reset notification bar on Android.
    WidgetsFlutterBinding.ensureInitialized();
    await SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top],
    );

    // Run the App using Riverpod.
    runApp(
      ProviderScope(
        observers: const [
          ProviderLogger(),
        ],
        child: this,
      ),
    );
  }
}
