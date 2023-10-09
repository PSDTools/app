import "package:flutter_test/flutter_test.dart";
import "package:pirate_code/widgets/big_card/big_card.dart";

import "../../helpers/pump_app.dart";

void main() {
  group("Big card is accessible...", () {
    const text = "Dummy text";

    testWidgets("on Android.", (tester) async {
      await tester.pumpApp(const BigCard(text));

      final handle = tester.ensureSemantics();
      await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
      handle.dispose();
    });
    testWidgets("on iOS.", (tester) async {
      await tester.pumpApp(const BigCard(text));

      final handle = tester.ensureSemantics();
      await expectLater(tester, meetsGuideline(iOSTapTargetGuideline));
      handle.dispose();
    });
    testWidgets("according to the WCAG.", (tester) async {
      await tester.pumpApp(const BigCard(text));

      final handle = tester.ensureSemantics();
      await expectLater(tester, meetsGuideline(textContrastGuideline));
      handle.dispose();
    });
    testWidgets("with regard to labeling buttons.", (tester) async {
      await tester.pumpApp(const BigCard(text));

      final handle = tester.ensureSemantics();
      await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
      handle.dispose();
    });
  });
}
