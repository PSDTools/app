import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:mocktail/mocktail.dart";
import "package:pirate_code/features/auth/data/auth_repository.dart";
import "package:pirate_code/l10n/app_localizations.dart";
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
        final appLocalizations = _MockAppLocalizations();
        when(() => appLocalizations.email_validate_failed_empty).thenReturn("");
        verifyNever(() => appLocalizations.email_validate_failed_empty);
        expect(validate("", appLocalizations), isNotNull);
        verify(() => appLocalizations.email_validate_failed_empty).called(1);
      });
      test("null...", () {
        final appLocalizations = _MockAppLocalizations();
        when(() => appLocalizations.email_validate_failed_empty).thenReturn("");
        verifyNever(() => appLocalizations.email_validate_failed_empty);
        expect(validate(null, appLocalizations), isNotNull);
        verify(() => appLocalizations.email_validate_failed_empty).called(1);
      });
    });

    group("@ symbol...", () {
      test("too many '@'s", () {
        final appLocalizations = _MockAppLocalizations();
        when(() => appLocalizations.email_validate_failed_tooManyAtSymbols)
            .thenReturn("");
        verifyNever(
          () => appLocalizations.email_validate_failed_tooManyAtSymbols,
        );
        expect(
          validate("person@subdomain@example.com", appLocalizations),
          isNotNull,
        );
        verify(() => appLocalizations.email_validate_failed_tooManyAtSymbols)
            .called(1);
      });
      test("missing '@' symbol", () {
        final appLocalizations = _MockAppLocalizations();
        when(() => appLocalizations.email_validate_failed_missingAtSymbol)
            .thenReturn("");
        verifyNever(
          () => appLocalizations.email_validate_failed_missingAtSymbol,
        );
        expect(validate("person.com", appLocalizations), isNotNull);
        verify(() => appLocalizations.email_validate_failed_missingAtSymbol)
            .called(1);
      });
      test("missing content before '@' symbol", () {
        final appLocalizations = _MockAppLocalizations();
        when(() => appLocalizations.email_validate_failed_missingBeforeAtSymbol)
            .thenReturn("");
        verifyNever(
          () => appLocalizations.email_validate_failed_missingBeforeAtSymbol,
        );
        expect(validate("@example.com", appLocalizations), isNotNull);
        verify(
          () => appLocalizations.email_validate_failed_missingBeforeAtSymbol,
        ).called(1);
      });
      test("missing content after '@' symbol", () {
        final appLocalizations = _MockAppLocalizations();
        when(() => appLocalizations.email_validate_failed_missingAfterAtSymbol)
            .thenReturn("");
        verifyNever(
          () => appLocalizations.email_validate_failed_missingAfterAtSymbol,
        );
        expect(validate("person@", appLocalizations), isNotNull);
        verify(
          () => appLocalizations.email_validate_failed_missingAfterAtSymbol,
        ).called(1);
      });
    });

    group("spaces...", () {
      test("infixed spaces", () {
        final appLocalizations = _MockAppLocalizations();
        when(() => appLocalizations.email_validate_failed_containsSpaces)
            .thenReturn("");
        verifyNever(
          () => appLocalizations.email_validate_failed_containsSpaces,
        );
        expect(
          validate("s p a c e s @ e x a m p l e . c o m", appLocalizations),
          isNotNull,
        );
        verify(() => appLocalizations.email_validate_failed_containsSpaces)
            .called(1);
      });
      test("leading space", () {
        final appLocalizations = _MockAppLocalizations();
        when(() => appLocalizations.email_validate_failed_containsSpaces)
            .thenReturn("");
        verifyNever(
          () => appLocalizations.email_validate_failed_containsSpaces,
        );
        expect(
          validate(" spaces+leading@example.com", appLocalizations),
          isNotNull,
        );
        verify(() => appLocalizations.email_validate_failed_containsSpaces)
            .called(1);
      });
      test("trailing space", () {
        final appLocalizations = _MockAppLocalizations();
        when(() => appLocalizations.email_validate_failed_containsSpaces)
            .thenReturn("");
        verifyNever(
          () => appLocalizations.email_validate_failed_containsSpaces,
        );
        expect(
          validate("spaces+trailing@example.com ", appLocalizations),
          isNotNull,
        );
        verify(() => appLocalizations.email_validate_failed_containsSpaces)
            .called(1);
      });
    });

    group("bad domain...", () {
      test("fake domain", () {
        final appLocalizations = _MockAppLocalizations();
        when(() => appLocalizations.email_validate_failed_exampleEmail)
            .thenReturn("");
        verifyNever(() => appLocalizations.email_validate_failed_exampleEmail);
        expect(validate(redactedEmail, appLocalizations), isNotNull);
        verify(() => appLocalizations.email_validate_failed_exampleEmail)
            .called(1);
      });
      test("TLD", () {
        final appLocalizations = _MockAppLocalizations();
        when(() => appLocalizations.email_validate_failed_topLevelDomain)
            .thenReturn("");
        verifyNever(
          () => appLocalizations.email_validate_failed_topLevelDomain,
        );
        expect(validate("me@com", appLocalizations), isNotNull);
        verify(() => appLocalizations.email_validate_failed_topLevelDomain)
            .called(1);
      });
    });

    group("valid emails...", () {
      test("fake email", () {
        final appLocalizations = _MockAppLocalizations();
        when(() => appLocalizations.email_validate_failed_exampleEmail)
            .thenReturn("");
        verifyNever(() => appLocalizations.email_validate_failed_exampleEmail);
        expect(validate("name@website.com", appLocalizations), isNotNull);
        verify(() => appLocalizations.email_validate_failed_exampleEmail)
            .called(1);
      });
      test("Parker", () {
        final appLocalizations = _MockAppLocalizations();
        const parkerH27 = "91337218+ParkerH27@users.noreply.github.com";

        expect(
          validate(
            parkerH27,
            appLocalizations,
          ),
          isNull,
        );
      });
      test("Eli", () {
        final appLocalizations = _MockAppLocalizations();
        const lishaduck = "88557639+lishaduck@users.noreply.github.com";

        expect(
          validate(
            lishaduck,
            appLocalizations,
          ),
          isNull,
        );
      });
    });
  });
}

class _MockAppLocalizations extends Mock implements AppLocalizations {}
