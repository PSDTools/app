import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:pirate_code/app/app.dart";
import "package:pirate_code/app/app_router.dart";

import "../helpers/riverpod.dart";

void main() {
  group("App...", () {
    group("renders...", () {
      testWidgets("a Material app.", (tester) async {
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
    });

    group("is accessible...", () {
      testWidgets("on Android.", (tester) async {
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
      testWidgets("on iOS.", (tester) async {
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
      testWidgets("according to the WCAG.", (tester) async {
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
      testWidgets("with regard to labeling buttons.", (tester) async {
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
    test("Test them boots...", () {
      final originalOnError = FlutterError.onError;
      const tested = App();
      expect(() => tested.bootstrap, returnsNormally);
      FlutterError.onError = originalOnError;
    });
  });
}
