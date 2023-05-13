import "package:auto_route/auto_route.dart";

import "pages/favorites.dart";
import "pages/home.dart";
import "wrapper.dart";

part "app_router.gr.dart";

@AutoRouterConfig(replaceInRouteName: "Page,Route")
class AppRouter extends _$AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
        MaterialRoute(
          path: "/",
          page: MyHomeRoute.page,
          initial: true,
          children: [
            MaterialRoute(page: GeneratorRoute.page, path: ""),
            MaterialRoute(page: FavoritesRoute.page, path: "favorites"),
          ],
        ),
        RedirectRoute(path: "*", redirectTo: "/"),
      ];
}
