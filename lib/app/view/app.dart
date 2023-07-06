/// The app widget view.
library pirate_code.app.view;

import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../l10n/l10n.dart";
import "../app_router.dart";

/// The app widget (as a mixin).
mixin AppView on ConsumerWidget {
  // Make sure you don't initiate your router inside of the build function.
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const flutterLocale = Locale("en", "US");
    final theme = ColorScheme.fromSeed(seedColor: Colors.green);

    return MaterialApp.router(
      routerConfig: _appRouter.config(),
      title: "PSD Wallet",
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
}
