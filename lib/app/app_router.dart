import "package:auto_route/auto_route.dart";

import "../widgets/pirate_coins/pirate_coins.dart";
import "../widgets/wrapper/wrapper.dart";

part "app_router.gr.dart";

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
          ],
        ),
        RedirectRoute(path: "*", redirectTo: "/"),
      ];
}
