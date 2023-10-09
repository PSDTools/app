import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:pirate_code/features/utils/presentation/device_info/device_banner.dart";

import "../../../helpers/pump_app.dart";

void main() {
  group("Device Banner is accessible...", () {
    testWidgets("on Android.", (tester) async {
      await tester.pumpApp(const DeviceBanner(child: Text("")));

      final handle = tester.ensureSemantics();
      await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
      handle.dispose();
    });
    testWidgets("on iOS.", (tester) async {
      await tester.pumpApp(const DeviceBanner(child: Text("")));

      final handle = tester.ensureSemantics();
      await expectLater(tester, meetsGuideline(iOSTapTargetGuideline));
      handle.dispose();
    });
    testWidgets("according to the WCAG.", (tester) async {
      await tester.pumpApp(const DeviceBanner(child: Text("")));

      final handle = tester.ensureSemantics();
      await expectLater(tester, meetsGuideline(textContrastGuideline));
      handle.dispose();
    });
    testWidgets("with regard to labeling buttons.", skip: true, (tester) async {
      await tester.pumpApp(const DeviceBanner(child: Text("")));

      final handle = tester.ensureSemantics();
      await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
      handle.dispose();
    });
  });
}
