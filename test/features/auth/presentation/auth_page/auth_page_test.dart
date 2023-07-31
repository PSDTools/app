import "package:flutter_test/flutter_test.dart";
import "package:pirate_code/features/auth/presentation/auth_page/auth_page.dart";

import "../../../../helpers/helpers.dart";

void main() {
  group("Auth page is accessible...", () {
    testWidgets("On Android.", (tester) async {
      await tester.pumpApp(const AuthPage());

      final handle = tester.ensureSemantics();
      await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
      handle.dispose();
    });
    testWidgets("On iOS.", (tester) async {
      await tester.pumpApp(const AuthPage());

      final handle = tester.ensureSemantics();
      await expectLater(tester, meetsGuideline(iOSTapTargetGuideline));
      handle.dispose();
    });
    testWidgets("According to the WCAG.", (tester) async {
      await tester.pumpApp(const AuthPage());

      final handle = tester.ensureSemantics();
      await expectLater(tester, meetsGuideline(textContrastGuideline));
      handle.dispose();
    });
    testWidgets("With regards to labeling buttons.", (tester) async {
      await tester.pumpApp(const AuthPage());

      final handle = tester.ensureSemantics();
      await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
      handle.dispose();
    });
  });
}
