import "package:auto_route/auto_route.dart";

import "../widgets/favorites/favorites.dart";
import "../widgets/generator/generator.dart";
import "../widgets/jimmy/jimmy.dart";
import "../wrapper.dart";

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
            AutoRoute(page: GeneratorRoute.page, path: ""),
            AutoRoute(page: FavoritesRoute.page, path: "favorites"),
            AutoRoute(page: JimmyRoute.page, path: "jimmy"),
          ],
        ),
        RedirectRoute(path: "*", redirectTo: "/"),
      ];
}
