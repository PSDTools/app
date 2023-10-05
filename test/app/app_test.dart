import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:pirate_code/app/app.dart";
import "package:pirate_code/app/app_router.dart";

import "../helpers/riverpod.dart";

void main() {
  group("App", () {
    testWidgets("Renders a Material App.", (tester) async {
      final container = ProviderContainer(overrides: defaultOverrides);
      setAppRouter(container);

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: const App(),
        ),
      );
      expect(find.byType(MaterialApp), findsOneWidget);
    });

    group("App is accessible...", () {
      testWidgets("On Android.", (tester) async {
        final container = ProviderContainer(overrides: defaultOverrides);
        setAppRouter(container);

        await tester.pumpWidget(
          UncontrolledProviderScope(
            container: container,
            child: const App(),
          ),
        );

        final handle = tester.ensureSemantics();
        await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
        handle.dispose();
      });
      testWidgets("On iOS.", (tester) async {
        final container = ProviderContainer(overrides: defaultOverrides);
        setAppRouter(container);

        await tester.pumpWidget(
          UncontrolledProviderScope(
            container: container,
            child: const App(),
          ),
        );

        final handle = tester.ensureSemantics();
        await expectLater(tester, meetsGuideline(iOSTapTargetGuideline));
        handle.dispose();
      });
      testWidgets("According to the WCAG.", (tester) async {
        final container = ProviderContainer(overrides: defaultOverrides);
        setAppRouter(container);

        await tester.pumpWidget(
          UncontrolledProviderScope(
            container: container,
            child: const App(),
          ),
        );

        final handle = tester.ensureSemantics();
        await expectLater(tester, meetsGuideline(textContrastGuideline));
        handle.dispose();
      });
      testWidgets("With regards to labeling buttons.", (tester) async {
        final container = ProviderContainer(overrides: defaultOverrides);
        setAppRouter(container);

        await tester.pumpWidget(
          UncontrolledProviderScope(
            container: container,
            child: const App(),
          ),
        );

        final handle = tester.ensureSemantics();
        await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
        handle.dispose();
      });
    });
  });

  group("Bootstrapping Tests!", () {
    test("Test the boots...", () {
      final originalOnError = FlutterError.onError;
      const tested = App();
      expect(() => tested.bootstrap, returnsNormally);
      FlutterError.onError = originalOnError;
    });
  });
}
