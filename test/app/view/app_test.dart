import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter_test/flutter_test.dart";
import "package:pirate_code/app/app.dart";

void main() {
  group("App", () {
    testWidgets("renders a Material App", (tester) async {
      await tester.pumpWidget(ProviderScope(child: App()));
      expect(find.byType(MaterialApp), findsOneWidget);
    });
  });
}
