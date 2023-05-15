import "package:auto_route/auto_route.dart";

import '../pages/favorites.dart';
import '../pages/home.dart';
import '../wrapper.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: "Page,Route")
class AppRouter extends _$AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          path: "/",
          page: MyHomeRoute.page,
          initial: true,
          children: [
            AutoRoute(path: "", page: GeneratorRoute.page),
            AutoRoute(path: "favorites", page: FavoritesRoute.page),
          ],
        ),
        RedirectRoute(path: "*", redirectTo: "/"),
      ];
}
