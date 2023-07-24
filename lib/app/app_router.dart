/// The app's routing.
library pirate_code.app.router;

import "package:auto_route/auto_route.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../features/auth/domain/auth_domain.dart";
import "../features/auth/presentation/auth_page.dart";
import "../features/pirate_coins/presentation/pirate_coins_page.dart";
import "../features/stats/presentation/stats_page.dart";
import "../features/wrapper/presentation/wrapper_page.dart";

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
          path: "/pirate-coins",
          children: [
            AutoRoute(page: PirateCoinsRoute.page, path: ""),
            AutoRoute(page: StatsRoute.page, path: "stats"),
          ],
          guards: [
            AutoRouteGuard.redirect(
              (resolver) {
                final authState = container.read(authProvider);

                return (authState != null) ? null : const AuthRoute();
              },
            ),
          ],
        ),
        AutoRoute(page: AuthRoute.page, path: "/login", initial: true),
        RedirectRoute(path: "*", redirectTo: "/login"),
      ];
}
