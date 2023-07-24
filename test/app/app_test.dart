// ignore_for_file: scoped_providers_should_specify_dependencies
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter_test/flutter_test.dart";
import "package:pirate_code/app/app.dart";
import "package:pirate_code/app/app_router.dart";
import "package:pirate_code/dart_define.gen.dart";
import "package:pirate_code/utils/data/secrets.dart";

void main() {
  group("App", () {
    testWidgets("renders a Material App", (tester) async {
      final container = ProviderContainer(
        overrides: [
          flavorProvider.overrideWithValue(Flavor.development),
          projectIdProvider.overrideWithValue("648b3836d14e06cddc4e"),
          apiUrlProvider.overrideWithValue("https://cloud.appwrite.io/v1"),
        ],
      );

      appRouter = AppRouter(container: container);

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: const App(),
        ),
      );
      expect(find.byType(MaterialApp), findsOneWidget);
    });
  });
  group("Bootstrappin' Tests!", () {
    test("Test the boots...", () async {
      const tested = App();
      await expectLater(
        () async {
          await tested.bootstrap();
        },
        returnsNormally,
      );
    });
  });
}
