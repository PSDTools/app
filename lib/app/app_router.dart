/// This library contains the app's routing.
library;

import "package:auto_route/auto_route.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../features/auth/application/auth_service.dart";
import "../features/auth/presentation/auth_page/auth_page.dart";
import "../features/dashboard/presentation/dashboard_page/dashboard_page.dart";
import "../features/dashboard/presentation/wrapper_page/wrapper_page.dart";
import "../features/gpa_calculator/presentation/gpa_page/gpa_page.dart";
import "../features/pirate_coins/presentation/pirate_coins_page/pirate_coins_page.dart";
import "../features/pirate_coins/presentation/stats_page/stats_page.dart";

part "app_router.gr.dart";

/// The router for the application.
@AutoRouterConfig(replaceInRouteName: "Page,Route")
class AppRouter extends _$AppRouter {
  /// Create a new instance of [AppRouter].
  AppRouter({required this.ref});

  /// Gain access to the needed providers.
  final Ref<AppRouter> ref;

  @override
  final defaultRouteType = const RouteType.custom(
    opaque: false,
    transitionsBuilder: TransitionsBuilders.slideLeftWithFade,
  );

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: WrapperRoute.page,
          path: "/",
          guards: [
            AutoRouteGuard.redirect(
              (resolver) {
                final authState = ref.read(userProvider).valueOrNull;

                return (authState != null) ? null : const AuthRoute();
              },
            ),
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
