/// This library contains the app's routing.
library;

import "package:auto_route/auto_route.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../features/auth/domain/auth_domain.dart";
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
  AppRouter({required this.container});

  /// Gain access to the providers.
  ProviderContainer container;

  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(
          page: WrapperRoute.page,
          path: "/",
          guards: [
            AutoRouteGuard.redirect(
              (resolver) {
                final authState = container.read(
                  pirateAuthProvider.select((value) => value.asData?.value),
                );

                return (authState != null) ? null : const AuthRoute();
              },
            ),
          ],
          children: [
            AutoRoute(
              page: PirateCoinsRoute.page,
              path: "pirate-coins",
              title: (context, route) => "Pirate Coins",
            ),
            AutoRoute(
              page: DashboardRoute.page,
              path: "",
              title: (context, route) => "Dashboard",
              initial: true,
            ),
            AutoRoute(
              page: StatsRoute.page,
              path: "stats",
              title: (context, route) => "Stats",
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

// Make sure you don't initiate your router inside of the build function.
AppRouter? _appRouter;

/// The app's router.
AppRouter? get appRouter => _appRouter;

/// Create the app router.
void setAppRouter(ProviderContainer container) =>
    _appRouter ??= AppRouter(container: container);
