import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:pirate_code/l10n/l10n.dart";

// This isn't a test.
// ignore: avoid-top-level-members-in-tests
extension PumpApp on WidgetTester {
  Future<void> pumpApp(Widget widget) {
    return pumpWidget(
      MaterialApp(
        home: widget,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    );
  }
}
