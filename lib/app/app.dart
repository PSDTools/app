/// This library contains the [App] [Widget].
library;

import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../l10n/l10n.dart";
import "../features/auth/application/auth_service.dart";
import "../utils/design.dart";
import "../utils/log.dart";
import "../utils/router.dart";
import "boostrap.dart";

/// The default locale for the app.
const flutterLocale = Locale("en", "US");

/// The app widget, with bootstrapping capabilities.

class App extends ConsumerWidget with Bootstrap {
  /// Create a new instance of [App].
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _EagerInitialization(
      child: MaterialApp.router(
        routerConfig: ref.read(routerProvider).config(
              navigatorObservers: () => [
                RouterLogger(),
              ],
            ),
        onGenerateTitle: (context) => context.l10n.appTitle,
        theme: theme,
        locale: flutterLocale,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    );
  }
}

class _EagerInitialization extends ConsumerWidget {
  const _EagerInitialization({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Eagerly initialize providers by watching them.
    // By using "watch", the provider will stay alive and not be disposed.
    final user = ref.watch(userProvider);

    return _MainArea(
      child: switch (user) {
        AsyncData() => child,
        AsyncError() => child,
        AsyncLoading() => const CircularProgressIndicator(),
      },
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

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: theme.colorScheme.surfaceVariant,
      child: child,
    );
  }
}
