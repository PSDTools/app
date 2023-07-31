/// The app widget.
///
/// Including the app's initiation code.
library pirate_code.app;

import "dart:async";
import "dart:developer";

import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter_web_plugins/url_strategy.dart";
import "package:meta/meta.dart";

import "../../l10n/l10n.dart";
import "app_router.dart";

// Make sure you don't initiate your router inside of the build function.
@internal
@visibleForTesting
// Waiting on the next dart minor.
// ignore: public_member_api_docs
AppRouter? appRouter;

/// The app widget, with bootstrappin' capabilities.
class App extends StatelessWidget {
  /// Create a new instance of [App].
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    const flutterLocale = Locale("en", "US");
    final theme = ColorScheme.fromSeed(seedColor: Colors.green);

    return MaterialApp.router(
      routerConfig: appRouter?.config(),
      builder: (context, child) {
        return _MainArea(child: child);
      },
      onGenerateTitle: (context) {
        final l10n = context.l10n;

        return l10n.appTitle;
      },
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: theme,
        appBarTheme: AppBarTheme(color: theme.primary),
      ),
      locale: flutterLocale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }

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

    /// The app's container.
    final container = ProviderContainer();

    appRouter = AppRouter(container: container);

    await runZonedGuarded(
      () async => runApp(
        UncontrolledProviderScope(
          container: container,
          child: this,
        ),
      ),
      (error, stackTrace) => log(error.toString(), stackTrace: stackTrace),
    );
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
    final colorScheme = Theme.of(context).colorScheme;

    return ColoredBox(
      color: colorScheme.surfaceVariant,
      child: child,
    );
  }
}
