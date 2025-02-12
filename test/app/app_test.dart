// False positive.
// ignore_for_file: scoped_providers_should_specify_dependencies
import "package:appwrite/appwrite.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:mocktail/mocktail.dart";
import "package:pirate_code/app/app.dart";
import "package:pirate_code/features/auth/application/auth_service.dart";
import "package:pirate_code/features/auth/data/auth_repository.dart";
import "package:pirate_code/utils/api.dart";

void main() {
  group("App", () {
    group("renders", () {
      testWidgets("a Material app.", (tester) async {
        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              clientProvider.overrideWithValue(_MockClient()),
              userProvider.overrideWith((_) => fakeUser),
            ],
            child: const App(),
          ),
        );
        expect(find.byType(MaterialApp), findsOneWidget);
      });
    });

    group("is accessible", () {
      testWidgets("on Android.", (tester) async {
        final mockAuthRepository = _MockAuthRepository();
        verifyZeroInteractions(mockAuthRepository);

        await tester.pumpWidget(
          ProviderScope(
            overrides: [authProvider.overrideWithValue(mockAuthRepository)],
            child: const App(),
          ),
        );

        verify(
          () => mockAuthRepository.authenticate(anonymous: true),
        ).called(1);

        final handle = tester.ensureSemantics();
        await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
        handle.dispose();
      });
      testWidgets("on iOS.", (tester) async {
        final mockAuthRepository = _MockAuthRepository();
        verifyZeroInteractions(mockAuthRepository);

        await tester.pumpWidget(
          ProviderScope(
            overrides: [authProvider.overrideWithValue(mockAuthRepository)],
            child: const App(),
          ),
        );

        verify(
          () => mockAuthRepository.authenticate(anonymous: true),
        ).called(1);

        final handle = tester.ensureSemantics();
        await expectLater(tester, meetsGuideline(iOSTapTargetGuideline));
        handle.dispose();
      });
      testWidgets("according to the WCAG.", (tester) async {
        final mockAuthRepository = _MockAuthRepository();
        verifyZeroInteractions(mockAuthRepository);

        await tester.pumpWidget(
          ProviderScope(
            overrides: [authProvider.overrideWithValue(mockAuthRepository)],
            child: const App(),
          ),
        );

        verify(
          () => mockAuthRepository.authenticate(anonymous: true),
        ).called(1);

        final handle = tester.ensureSemantics();
        await expectLater(tester, meetsGuideline(textContrastGuideline));
        handle.dispose();
      });
      testWidgets("with regard to labeling buttons.", (tester) async {
        final mockAuthRepository = _MockAuthRepository();
        verifyZeroInteractions(mockAuthRepository);

        await tester.pumpWidget(
          ProviderScope(
            overrides: [authProvider.overrideWithValue(mockAuthRepository)],
            child: const App(),
          ),
        );

        verify(
          () => mockAuthRepository.authenticate(anonymous: true),
        ).called(1);

        final handle = tester.ensureSemantics();
        await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
        handle.dispose();
      });
    });
  });
}

class _MockAuthRepository extends Mock implements AuthRepository {}

class _MockClient extends Mock implements Client {}
