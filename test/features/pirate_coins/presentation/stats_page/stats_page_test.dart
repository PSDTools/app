import "package:flutter_test/flutter_test.dart";
import "package:mocktail/mocktail.dart";
import "package:pirate_code/features/auth/data/auth_repository.dart";
import "package:pirate_code/features/pirate_coins/presentation/stats_page/stats_page.dart";

import "../../../../helpers/pump_app.dart";

void main() {
  group("Stats page", () {
    group("is accessible", () {
      testWidgets("on Android.", (tester) async {
        final mockAuthRepository = _MockAuthRepository();
        verifyZeroInteractions(mockAuthRepository);

        await tester.pumpApp(
          overrides: [
            authProvider.overrideWithValue(mockAuthRepository),
          ],
          const StatsPage(),
        );

        verify(() => mockAuthRepository.authenticate(anonymous: true))
            .called(1);

        final handle = tester.ensureSemantics();
        await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
        handle.dispose();
      });
      testWidgets("on iOS.", (tester) async {
        final mockAuthRepository = _MockAuthRepository();
        verifyZeroInteractions(mockAuthRepository);

        await tester.pumpApp(
          overrides: [
            authProvider.overrideWithValue(mockAuthRepository),
          ],
          const StatsPage(),
        );

        verify(() => mockAuthRepository.authenticate(anonymous: true))
            .called(1);

        final handle = tester.ensureSemantics();
        await expectLater(tester, meetsGuideline(iOSTapTargetGuideline));
        handle.dispose();
      });
      testWidgets("according to the WCAG.", (tester) async {
        final mockAuthRepository = _MockAuthRepository();
        verifyZeroInteractions(mockAuthRepository);

        await tester.pumpApp(
          overrides: [
            authProvider.overrideWithValue(mockAuthRepository),
          ],
          const StatsPage(),
        );

        verify(() => mockAuthRepository.authenticate(anonymous: true))
            .called(1);

        final handle = tester.ensureSemantics();
        await expectLater(tester, meetsGuideline(textContrastGuideline));
        handle.dispose();
      });
      testWidgets("with regard to labeling buttons.", (tester) async {
        final mockAuthRepository = _MockAuthRepository();
        verifyZeroInteractions(mockAuthRepository);

        await tester.pumpApp(
          overrides: [
            authProvider.overrideWithValue(mockAuthRepository),
          ],
          const StatsPage(),
        );

        verify(() => mockAuthRepository.authenticate(anonymous: true))
            .called(1);

        final handle = tester.ensureSemantics();
        await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
        handle.dispose();
      });
    });
  });
}

class _MockAuthRepository extends Mock implements AuthRepository {}
