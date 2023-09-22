import "package:flutter_test/flutter_test.dart";
import "package:pirate_code/features/dashboard/presentation/wrapper_page/wrapper_page.dart";

import "../../../../../helpers/pump_app.dart";

void main() {
  group("Device Info is accessible...", () {
    testWidgets("On Android.", (tester) async {
      await tester.pumpApp(const WrapperPage());

      final handle = tester.ensureSemantics();
      await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
      handle.dispose();
    });
    testWidgets("On iOS.", (tester) async {
      await tester.pumpApp(const WrapperPage());

      final handle = tester.ensureSemantics();
      await expectLater(tester, meetsGuideline(iOSTapTargetGuideline));
      handle.dispose();
    });
    testWidgets("According to the WCAG.", (tester) async {
      await tester.pumpApp(const WrapperPage());

      final handle = tester.ensureSemantics();
      await expectLater(tester, meetsGuideline(textContrastGuideline));
      handle.dispose();
    });
    testWidgets("With regards to labeling buttons.", (tester) async {
      await tester.pumpApp(const WrapperPage());

      final handle = tester.ensureSemantics();
      await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
      handle.dispose();
    });
  });
}
