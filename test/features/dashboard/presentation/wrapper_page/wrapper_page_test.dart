import "dart:typed_data";

import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:pirate_code/app/app.dart";
import "package:pirate_code/app/app_router.dart";
import "package:pirate_code/features/auth/application/auth_service.dart";
import "package:pirate_code/features/auth/domain/account_type.dart";
import "package:pirate_code/features/auth/domain/pirate_user.dart";
import "package:pirate_code/features/dashboard/presentation/wrapper_page/wrapper_page.dart";
import "package:pirate_code/l10n/l10n.dart";
import "package:pirate_code/utils/design.dart";
import "package:pirate_code/utils/router.dart";

import "../../../../helpers/riverpod.dart";

void main() {
  group("Wrapper page is accessible...", () {
    testWidgets("on Android.", (tester) async {
      final container = ProviderContainer(
        overrides: [
          userProvider.overrideWithValue(
            PirateUser(
              name: "",
              email: "",
              accountType: AccountType.student,
              avatar: Uint8List(1),
            ),
          ),
          ...defaultOverrides,
        ],
      );
      addTearDown(container.dispose);
      final router = container.read(routerProvider);

      await tester.pumpWidget(
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
      await tester.pumpAndSettle();
      expect(router.urlState.url, equals("/"));
      expect(find.byType(WrapperPage), findsOneWidget);

      final handle = tester.ensureSemantics();
      await expectLater(tester, meetsGuideline(androidTapTargetGuideline));
      handle.dispose();
    });
    testWidgets("on iOS.", (tester) async {
      final container = ProviderContainer(
        overrides: [
          userProvider.overrideWithValue(
            PirateUser(
              name: "",
              email: "",
              accountType: AccountType.student,
              avatar: Uint8List(1),
            ),
          ),
          ...defaultOverrides,
        ],
      );
      addTearDown(container.dispose);
      final router = container.read(routerProvider);

      await tester.pumpWidget(
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
      await tester.pumpAndSettle();
      expect(router.urlState.url, equals("/"));
      expect(find.byType(WrapperPage), findsOneWidget);

      final handle = tester.ensureSemantics();
      await expectLater(tester, meetsGuideline(iOSTapTargetGuideline));
      handle.dispose();
    });
    testWidgets("according to the WCAG.", (tester) async {
      final container = ProviderContainer(
        overrides: [
          userProvider.overrideWithValue(
            PirateUser(
              name: "",
              email: "",
              accountType: AccountType.student,
              avatar: Uint8List(1),
            ),
          ),
          ...defaultOverrides,
        ],
      );
      addTearDown(container.dispose);
      final router = container.read(routerProvider);

      await tester.pumpWidget(
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
      await tester.pumpAndSettle();
      expect(router.urlState.url, equals("/"));
      expect(find.byType(WrapperPage), findsOneWidget);

      final handle = tester.ensureSemantics();
      await expectLater(tester, meetsGuideline(textContrastGuideline));
      handle.dispose();
    });
    testWidgets("with regard to labeling buttons.", (tester) async {
      final container = ProviderContainer(
        overrides: [
          userProvider.overrideWithValue(
            PirateUser(
              name: "",
              email: "",
              accountType: AccountType.student,
              avatar: Uint8List(1),
            ),
          ),
          ...defaultOverrides,
        ],
      );
      addTearDown(container.dispose);
      final router = container.read(routerProvider);

      await tester.pumpWidget(
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
      await tester.pumpAndSettle();
      expect(router.urlState.url, equals("/"));
      expect(find.byType(WrapperPage), findsOneWidget);

      final handle = tester.ensureSemantics();
      await expectLater(tester, meetsGuideline(labeledTapTargetGuideline));
      handle.dispose();
    });
  });
}
