import "package:flutter_test/flutter_test.dart";
import "package:pirate_code/features/utils/presentation/device_info/device_info_dialog.dart";

import "../../../helpers/pump_app.dart";

void main() {
  group("Device info dialog", () {
    group("is accessible", () {
      testWidgets("on Android.", (tester) async {
        await tester.pumpApp(const DeviceInfoDialog());

        final handle = tester.ensureSemantics();
        await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
        handle.dispose();
      });
      testWidgets("on iOS.", (tester) async {
        await tester.pumpApp(const DeviceInfoDialog());

        final handle = tester.ensureSemantics();
        await expectLater(tester, meetsGuideline(iOSTapTargetGuideline));
        handle.dispose();
      });
      testWidgets("according to the WCAG.", (tester) async {
        await tester.pumpApp(const DeviceInfoDialog());

        final handle = tester.ensureSemantics();
        await expectLater(tester, meetsGuideline(textContrastGuideline));
        handle.dispose();
      });
      testWidgets("with regard to labeling buttons.", (tester) async {
        await tester.pumpApp(const DeviceInfoDialog());

        final handle = tester.ensureSemantics();
        await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
        handle.dispose();
      });
    });
  });
}
