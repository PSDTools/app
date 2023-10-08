/// This library contains the [App] [Widget].
///
/// Including the app's initiation code.
library;

import "dart:async";

import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_web_plugins/url_strategy.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../l10n/l10n.dart";
import "../../utils/log.dart";
import "../utils/design.dart";
import "../utils/router.dart";

/// The default locale for the app.
const flutterLocale = Locale("en", "US");

/// The app widget, with bootstrapping capabilities.

class App extends ConsumerWidget {
  /// Create a new instance of [App].
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _MainArea(
      child: MaterialApp.router(
        routerConfig: ref.read(routerProvider).config(),
        onGenerateTitle: (context) => context.l10n.appTitle,
        theme: theme,
        locale: flutterLocale,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    );
  }

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

/// Log provider updates to the console.
class ProviderLogger extends ProviderObserver {
  /// Create a new instance of [ProviderLogger].
  const ProviderLogger();

  @override
  void didUpdateProvider(
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    log.finer("[${provider.name}] value: $newValue");
  }
}

// The container for the current page, with its background color and subtle switching animation.
class _MainArea extends StatelessWidget {
  const _MainArea({
    required this.child,
    // Temporary ignore, see <dart-lang/sdk#49025>.
    // ignore: unused_element
    super.key,
  });

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: theme.colorScheme.surfaceVariant,
      child: child,
    );
  }
}
