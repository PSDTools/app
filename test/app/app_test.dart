// ignore_for_file: scoped_providers_should_specify_dependencies

import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:pirate_code/app/app.dart";
import "package:pirate_code/features/auth/application/auth_service.dart";

import "../helpers/riverpod.dart";

void main() {
  group("App...", () {
    group("renders...", () {
      testWidgets("a Material app.", (tester) async {
        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              ...defaultOverrides,
              userProvider.overrideWith((_) => fakeUser),
            ],
            child: const App(),
          ),
        );
        expect(find.byType(MaterialApp), findsOneWidget);
      });
    });

    group("is accessible...", () {
      testWidgets("on Android.", (tester) async {
        await tester.pumpWidget(
          ProviderScope(
            overrides: defaultOverrides,
            child: const App(),
          ),
        );

        final handle = tester.ensureSemantics();
        await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
        handle.dispose();
      });
      testWidgets("on iOS.", (tester) async {
        await tester.pumpWidget(
          ProviderScope(
            overrides: defaultOverrides,
            child: const App(),
          ),
        );

        final handle = tester.ensureSemantics();
        await expectLater(tester, meetsGuideline(iOSTapTargetGuideline));
        handle.dispose();
      });
      testWidgets("according to the WCAG.", (tester) async {
        await tester.pumpWidget(
          ProviderScope(
            overrides: defaultOverrides,
            child: const App(),
          ),
        );

        final handle = tester.ensureSemantics();
        await expectLater(tester, meetsGuideline(textContrastGuideline));
        handle.dispose();
      });
      testWidgets("with regard to labeling buttons.", (tester) async {
        await tester.pumpWidget(
          ProviderScope(
            overrides: defaultOverrides,
            child: const App(),
          ),
        );

        final handle = tester.ensureSemantics();
        await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
        handle.dispose();
      });
    });
  });

  group("Bootstrapping...", () {
    group("completes successfully:", () {
      late void Function(FlutterErrorDetails)? originalOnError;
      late App tested;

      setUp(() {
        originalOnError = FlutterError.onError;
        tested = const App();
      });

      test("Test them boots...", () {
        expect(() => tested.bootstrap, returnsNormally);
      });

      tearDown(() {
        FlutterError.onError = originalOnError;
      });
    });
  });
}
