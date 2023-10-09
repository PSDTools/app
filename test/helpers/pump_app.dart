/// This library contains utilities for configuring a [WidgetTester].
///
/// {@category Testing}
library;

import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:pirate_code/app/app.dart";
import "package:pirate_code/l10n/l10n.dart";
import "package:pirate_code/utils/design.dart";

import "riverpod.dart";

/// Extension method for [WidgetTester.pumpWidget].
extension PumpApp on WidgetTester {
  /// Pump a [Widget] in a [ProviderScope].
  Future<void> pumpApp(
    Widget widget, {
    List<Override> overrides = const [],
  }) async {
    return pumpWidget(
      ProviderScope(
        overrides: [
          ...overrides,
          ...defaultOverrides,
        ],
        child: _Widget(
          child: widget,
        ),
      ),
    );
  }
}

class _Widget extends StatelessWidget {
  const _Widget({
    required this.child,
    // Temporary ignore, see <dart-lang/sdk#49025>.
    // ignore: unused_element
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Material(
        child: child,
      ),
      onGenerateTitle: (context) => context.l10n.appTitle,
      theme: theme,
      locale: flutterLocale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
