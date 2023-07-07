/// Extension method for configuring [WidgetTester].
library pirate_code.test.helpers.pump_app;

import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter_test/flutter_test.dart";
import "package:pirate_code/l10n/l10n.dart";

/// Extension method for [WidgetTester.pumpWidget].
extension PumpApp on WidgetTester {
  /// Pump a [Widget] in a [ProviderScope].
  Future<void> pumpApp(
    Widget widget, {
    List<Override> overrides = const [],
  }) async {
    return pumpWidget(
      _Widget(
        overrides: overrides,
        child: widget,
      ),
    );
  }
}

class _Widget extends ConsumerWidget {
  const _Widget({
    required this.child,
    required this.overrides,
    // Temporary ignore, see <dart-lang/sdk#49025>.
    // ignore: unused_element
    super.key,
  });

  final Widget child;
  final List<Override> overrides;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ProviderScope(
      overrides: [
        ...overrides,
      ],
      child: MaterialApp(
        home: child,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    );
  }
}
