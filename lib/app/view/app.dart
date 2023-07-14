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
      builder: (context, child) {
        return _MainArea(child: child);
      },
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

// The container for the current page, with its background color and subtle switching animation.
class _MainArea extends ConsumerWidget {
  const _MainArea({
    required this.child,
    // Temporary ignore, see <dart-lang/sdk#49025>.
    // ignore: unused_element
    super.key,
  });

  final Widget? child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;

    return ColoredBox(
      color: colorScheme.surfaceVariant,
      child: child,
    );
  }
}
