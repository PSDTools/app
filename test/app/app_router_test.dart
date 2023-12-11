import "package:auto_route/auto_route.dart";
import "package:flutter_test/flutter_test.dart";

import "package:pirate_code/app/app_router.dart";
import "package:pirate_code/utils/router.dart";

import "../helpers/riverpod.dart";

void main() {
  group("Router", () {
    late AppRouter tested;

    setUp(() {
      final container = createContainer();
      final subscription = container.listen(routerProvider, (_, __) {});
      tested = subscription.read();
    });

    group("config", () {
      test("defaultRouteType should be custom, for our transitions.", () {
        expect(tested.defaultRouteType, isInstanceOf<CustomRouteType>());
      });
      test("routes should contain the correct number of routes.", () {
        expect(tested.routes.length, equals(3));
      });
    });

    group("path", () {
      test("should be correct for WrapperRoute.", () {
        final wrapperRoute = tested.routes[0];
        expect(wrapperRoute.path, equals("/"));
      });
      test("should be correct for PirateCoinsRoute.", () {
        final pirateCoinsRoute = tested.routes[0].children?.routes.toList()[0];
        expect(pirateCoinsRoute?.path, equals("pirate-coins"));
      });
      test("should be correct for StatsRoute.", () {
        final statsRoute = tested.routes[0].children?.routes
            .toList()[0]
            .children
            ?.routes
            .toList()[0];
        expect(statsRoute?.path, equals("stats"));
      });
      test("should be correct for DashboardRoute.", () {
        final dashboardRoute = tested.routes[0].children?.routes.toList()[1];
        expect(dashboardRoute?.path, equals(""));
      });
      test("should be correct for GpaRoute.", () {
        final gpaRoute = tested.routes[0].children?.routes.toList()[2];
        expect(gpaRoute?.path, equals("gpa-calculator"));
      });
      test("should be correct for AuthRoute.", () {
        final authRoute = tested.routes[1];
        expect(authRoute.path, equals("/login"));
      });

      test("should be correct for RedirectRoute.", () {
        final redirectRoute = tested.routes[2];
        expect(redirectRoute.path, equals("/*"));
      });
    });
  });
}
