import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:pirate_code/widgets/email_form_field/email_form_field.dart";

import "../../helpers/pump_app.dart";

void main() {
  group("Email form field is accessible...", () {
    testWidgets("on Android.", (tester) async {
      final controller = TextEditingController();
      await tester.pumpApp(EmailFormField(controller));

      final handle = tester.ensureSemantics();
      await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
      handle.dispose();
    });
    testWidgets("on iOS.", (tester) async {
      final controller = TextEditingController();
      await tester.pumpApp(EmailFormField(controller));

      final handle = tester.ensureSemantics();
      await expectLater(tester, meetsGuideline(iOSTapTargetGuideline));
      handle.dispose();
    });
    testWidgets("according to the WCAG.", (tester) async {
      final controller = TextEditingController();
      await tester.pumpApp(EmailFormField(controller));

      final handle = tester.ensureSemantics();
      await expectLater(tester, meetsGuideline(textContrastGuideline));
      handle.dispose();
    });
    testWidgets("with regard to labeling buttons.", (tester) async {
      final controller = TextEditingController();
      await tester.pumpApp(EmailFormField(controller));

      final handle = tester.ensureSemantics();
      await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
      handle.dispose();
    });
  });
}
