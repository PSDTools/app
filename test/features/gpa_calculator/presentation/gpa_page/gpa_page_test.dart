import "package:flutter_test/flutter_test.dart";
import "package:pirate_code/features/gpa_calculator/presentation/gpa_page/gpa_page.dart";

import "../../../../helpers/pump_app.dart";

void main() {
  group("GPA Calculator page", () {
    group("is accessible", () {
      testWidgets("on Android.", (tester) async {
        await tester.pumpApp(const GpaPage());

        final handle = tester.ensureSemantics();
        await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
        handle.dispose();
      });
      testWidgets("on iOS.", (tester) async {
        await tester.pumpApp(const GpaPage());

        final handle = tester.ensureSemantics();
        await expectLater(tester, meetsGuideline(iOSTapTargetGuideline));
        handle.dispose();
      });
      testWidgets("according to the WCAG.", (tester) async {
        await tester.pumpApp(const GpaPage());

        final handle = tester.ensureSemantics();
        await expectLater(tester, meetsGuideline(textContrastGuideline));
        handle.dispose();
      });
      testWidgets("with regard to labeling buttons.", (tester) async {
        await tester.pumpApp(const GpaPage());

        final handle = tester.ensureSemantics();
        await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
        handle.dispose();
      });
    });
  });
}
