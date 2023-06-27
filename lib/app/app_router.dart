/// The app's routing.
library pirate_code.app.router;

import "package:auto_route/auto_route.dart";

import "../features/pirate_coins/presentation/pirate_coins.dart";
import "../features/stats/presentation/stats.dart";
import "../features/wrapper/presentation/wrapper.dart";

part "app_router.gr.dart";

/// The router for the application.
@AutoRouterConfig(replaceInRouteName: "Page,Route")
class AppRouter extends _$AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: WrapperRoute.page,
          path: "/",
          initial: true,
          children: [
            AutoRoute(page: PirateCoinsRoute.page, path: ""),
            AutoRoute(page: StatsRoute.page, path: "stats"),
          ],
        ),
        RedirectRoute(path: "*", redirectTo: "/"),
      ];
}
