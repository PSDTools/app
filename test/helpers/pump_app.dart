/// Extension method for configuring [WidgetTester].
///
/// {@category Testing}
library;

import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter_test/flutter_test.dart";
import "package:pirate_code/app/app_router.dart";
import "package:pirate_code/l10n/l10n.dart";

import "riverpod.dart";

/// Extension method for [WidgetTester.pumpWidget].
extension PumpApp on WidgetTester {
  /// Pump a [Widget] in a [ProviderScope].
  Future<void> pumpApp(
    Widget widget, {
    List<Override> overrides = const [],
  }) async {
    final container = createContainer(overrides);
    setAppRouter(container);

    return pumpWidget(
      _Widget(
        container: container,
        child: widget,
      ),
    );
  }
}

class _Widget extends StatelessWidget {
  const _Widget({
    required this.child,
    required this.container,
    // Temporary ignore, see <dart-lang/sdk#49025>.
    // ignore: unused_element
    super.key,
  });

  final Widget child;
  final ProviderContainer container;

  @override
  Widget build(BuildContext context) {
    return UncontrolledProviderScope(
      container: container,
      child: MaterialApp.router(
        routerConfig: appRouter?.config(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    );
  }
}
