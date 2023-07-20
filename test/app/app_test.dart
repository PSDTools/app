// ignore_for_file: scoped_providers_should_specify_dependencies
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter_test/flutter_test.dart";
import "package:pirate_code/app/app.dart";
import "package:pirate_code/dart_define.gen.dart";
import "package:pirate_code/utils/data/secrets.dart";

import "../helpers/helpers.dart";

void main() {
  group("App", () {
    testWidgets("renders a Material App", (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            flavorProvider.overrideWithValue(Flavor.development),
            projectIdProvider.overrideWithValue("648b3836d14e06cddc4e"),
            apiUrlProvider.overrideWithValue("https://cloud.appwrite.io/v1"),
          ],
          child: App(),
        ),
      );
      expect(find.byType(MaterialApp), findsOneWidget);
    });
  });
  group("Bootstrappin' Tests!", () {
    testWidgets("Test the boots...", (tester) async {
      final tested = App();
      await tested.bootstrap(); // No exception, we hope.
      await tester.pumpApp(App());
      expect(find.byType(MaterialApp), findsOneWidget);
      expect(find.byType(ProviderScope), findsOneWidget);
    });
  });
}
