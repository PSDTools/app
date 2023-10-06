import "package:auto_route/auto_route.dart";
import "package:flutter_test/flutter_test.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "package:pirate_code/app/app_router.dart";
import "package:pirate_code/utils/router.dart";

void main() {
  group("Router...", () {
    late AppRouter appRouter;

    setUp(() {
      final container = ProviderContainer();
      appRouter = container.read(routerProvider);
    });

    group("config...", () {
      test("defaultRouteType should be material.", () {
        expect(appRouter.defaultRouteType, isInstanceOf<MaterialRouteType>());
      });
      test("routes should contain the correct number of routes.", () {
        expect(appRouter.routes.length, equals(3));
      });
    });

    group("path...", () {
      test("should be correct for WrapperRoute.", () {
        final wrapperRoute = appRouter.routes[0];
        expect(wrapperRoute.path, equals("/"));
      });
      test("should be correct for PirateCoinsRoute.", () {
        final pirateCoinsRoute =
            appRouter.routes[0].children?.routes.toList()[0];
        expect(pirateCoinsRoute?.path, equals("pirate-coins"));
      });
      test("should be correct for StatsRoute.", () {
        final statsRoute = appRouter.routes[0].children?.routes
            .toList()[0]
            .children
            ?.routes
            .toList()[0];
        expect(statsRoute?.path, equals("stats"));
      });
      test("should be correct for DashboardRoute.", () {
        final dashboardRoute = appRouter.routes[0].children?.routes.toList()[1];
        expect(dashboardRoute?.path, equals(""));
      });
      test("should be correct for GpaRoute.", () {
        final gpaRoute = appRouter.routes[0].children?.routes.toList()[2];
        expect(gpaRoute?.path, equals("gpa-calculator"));
      });
      test("should be correct for AuthRoute.", () {
        final authRoute = appRouter.routes[1];
        expect(authRoute.path, equals("/login"));
      });

      test("should be correct for RedirectRoute.", () {
        final redirectRoute = appRouter.routes[2];
        expect(redirectRoute.path, equals("/*"));
      });
    });
  });
}
