import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:google_fonts/google_fonts.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:pirate_code/app/app.dart";
import "package:pirate_code/app/app_router.dart";
import "package:pirate_code/features/auth/application/auth_service.dart";
import "package:pirate_code/features/dashboard/presentation/wrapper_page/wrapper_page.dart";
import "package:pirate_code/l10n/l10n.dart";
import "package:pirate_code/utils/design.dart";
import "package:pirate_code/utils/router.dart";

import "../../../../helpers/riverpod.dart";

extension _WidgetTesterX on WidgetTester {
  Future<void> pumpWidgetPage() async {
    final container = createContainer(
      overrides: [
        userProvider.overrideWith((_) => fakeUser),
      ],
    );
    final routerSubscription = container.listen(routerProvider, (_, __) {});
    final router = routerSubscription.read();

    await pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp.router(
          routerConfig: router.config(),
          onGenerateTitle: (context) => context.l10n.appTitle,
          theme: theme,
          locale: flutterLocale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      ),
    );

    await router.pushAll([
      const WrapperRoute(children: [DashboardRoute()]),
    ]);
    await pumpAndSettle();
    expect(router.urlState.url, equals("/"));
    expect(find.byType(WrapperPage), findsOneWidget);
  }

  Future<void> testAcessabilityGuideline(
    AccessibilityGuideline guideline, {
    bool expectFail = false,
  }) async {
    final handle = ensureSemantics();
    if (expectFail) {
      await expectLater(this, doesNotMeetGuideline(guideline));
    } else {
      await expectLater(this, meetsGuideline(guideline));
    }
    handle.dispose();
  }
}

void main() {
  group("Wrapper page", () {
    group("is accessible", () {
      setUp(() {
        GoogleFonts.config.allowRuntimeFetching = false;
      });

      testWidgets("on Android.", (tester) async {
        await tester.pumpWidgetPage();
        await tester.testAcessabilityGuideline(androidTapTargetGuideline);
      });
      testWidgets("on iOS.", (tester) async {
        await tester.pumpWidgetPage();
        await tester.testAcessabilityGuideline(iOSTapTargetGuideline);
      });
      testWidgets("according to the WCAG.", (tester) async {
        await tester.pumpWidgetPage();
        await tester.testAcessabilityGuideline(
          textContrastGuideline,
          expectFail: true,
        );
      });
      testWidgets("with regard to labeling buttons.", (tester) async {
        await tester.pumpWidgetPage();
        await tester.testAcessabilityGuideline(
          labeledTapTargetGuideline,
          expectFail: true,
        );
      });
    });
  });
}
