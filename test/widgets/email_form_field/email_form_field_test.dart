import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:pirate_code/features/auth/application/auth_service.dart";
import "package:pirate_code/widgets/email_form_field/email_form_field.dart";

import "../../helpers/pump_app.dart";

void main() {
  group("Email form field is accessible...", () {
    late TextEditingController controller;

    setUp(() {
      controller = TextEditingController();
    });

    testWidgets("on Android.", (tester) async {
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

  group("Email validation...", () {
    group("nothing..", () {
      test("empty...", () {
        expect(validate(""), isNotNull);
      });
      test("null...", () {
        expect(validate(null), isNotNull);
      });
    });

    group("@ symbol...", () {
      test("too many '@'s", () {
        expect(validate("person@subdomain@example.com"), isNotNull);
      });
      test("missing '@' symbol", () {
        expect(validate("person.com"), isNotNull);
      });
      test("missing content before '@' symbol", () {
        expect(validate("@example.com"), isNotNull);
      });
      test("missing content after '@' symbol", () {
        expect(validate("person@"), isNotNull);
      });
    });

    group("spaces...", () {
      test("infixed spaces", () {
        expect(validate("s p a c e s @ e x a m p l e . c o m"), isNotNull);
      });
      test("leading space", () {
        expect(validate(" spaces+leading@example.com"), isNotNull);
      });
      test("trailing space", () {
        expect(validate("spaces+trailing@example.com "), isNotNull);
      });
    });

    group("bad domain...", () {
      test("fake domain", () {
        expect(validate(redactedEmail), isNotNull);
      });
      test("TLD", () {
        expect(validate("me@com"), isNotNull);
      });
    });

    group("valid emails...", () {
      test("fake email", () {
        expect(validate("name@website.com"), isNotNull);
      });
      test("Parker", () {
        expect(validate("91337218+ParkerH27@users.noreply.github.com"), isNull);
      });
      test("Eli", () {
        expect(validate("88557639+lishaduck@users.noreply.github.com"), isNull);
      });
    });
  });
}
