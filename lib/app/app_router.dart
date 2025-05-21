/// This library contains the app's routing.
library;

import "package:auto_route/auto_route.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../features/auth/application/auth_service.dart";
import "app_router.gr.dart";

/// The router for the application.
@AutoRouterConfig(
  replaceInRouteName: "Page,Route",
  deferredLoading: true,
  argsEquality: true,
)
class AppRouter extends RootStackRouter {
  /// Create a new instance of [AppRouter].
  AppRouter({required this.ref});

  /// Gain access to the needed providers.
  final Ref ref;

  @override
  final defaultRouteType = RouteType.custom(
    transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
  );

  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: WrapperRoute.page,
      path: "/",
      guards: [
        AutoRouteGuard.redirect((resolver) {
          final authState = ref.read(userProvider).valueOrNull;

          return (authState != null) ? null : const AuthRoute();
        }),
      ],
      children: [
        AutoRoute(
          page: PirateCoinsRoute.page,
          path: "pirate-coins",
          children: [
            AutoRoute(
              page: StatsRoute.page,
              path: "stats",
              title: (context, route) => "Stats",
            ),
          ],
          title: (context, route) => "Pirate Coins",
        ),
        AutoRoute(
          page: DashboardRoute.page,
          path: "",
          title: (context, route) => "Dashboard",
          initial: true,
        ),
        AutoRoute(
          page: GpaRoute.page,
          path: "gpa-calculator",
          title: (context, route) => "GPA Calculator",
        ),
      ],
      title: (context, data) => "Pirate Code",
    ),
    AutoRoute(
      page: AuthRoute.page,
      path: "/login",
      title: (context, data) => "Login",
    ),
    RedirectRoute(path: "/*", redirectTo: "/"),
  ];
}
