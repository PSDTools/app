import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "app/app_router.dart";

@RoutePage()
class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;

    return LayoutBuilder(
      builder: (context, constraints) {
        return AutoTabsRouter(
          routes: const [
            GeneratorRoute(),
            FavoritesRoute(),
          ],
          builder: (context, child) {
            final tabsRouter = AutoTabsRouter.of(context);

            if (constraints.maxWidth < 450) {
              return Scaffold(
                appBar: AppBar(
                  title: Text(context.topRoute.name),
                  leading: const AutoLeadingButton(),
                  bottom: const TabBar(
                    tabs: [
                      Tab(text: "1", icon: Icon(Icons.abc)),
                      Tab(text: "2", icon: Icon(Icons.abc)),
                      Tab(text: "3", icon: Icon(Icons.abc)),
                    ],
                  ),
                ),
                body: mainArea(colorScheme, child),
                bottomNavigationBar: BottomNavigationBar(
                  currentIndex: tabsRouter.activeIndex,
                  onTap: tabsRouter.setActiveIndex,
                  items: const [
                    BottomNavigationBarItem(
                      label: "Home",
                      icon: Icon(Icons.home),
                    ),
                    BottomNavigationBarItem(
                      label: "Favorites",
                      icon: Icon(Icons.favorite),
                    ),
                  ],
                ),
              );
            } else {
              return WillPopScope(
                onWillPop: () async {
                  final atHomeTab = tabsRouter.activeIndex == 0;
                  if (!atHomeTab) {
                    tabsRouter.setActiveIndex(0);
                  }
                  return atHomeTab;
                },
                child: Scaffold(
                  body: Row(
                    children: [
                      SafeArea(
                        child: NavigationRail(
                          extended: constraints.maxWidth >= 600,
                          destinations: const [
                            NavigationRailDestination(
                              icon: Icon(Icons.home),
                              label: Text("Home"),
                            ),
                            NavigationRailDestination(
                              icon: Icon(Icons.favorite),
                              label: Text("Favorites"),
                            ),
                          ],
                          selectedIndex: tabsRouter.activeIndex,
                          onDestinationSelected: tabsRouter.setActiveIndex,
                        ),
                      ),
                      Expanded(child: mainArea(colorScheme, child)),
                    ],
                  ),
                ),
              );
            }
          },
        );
      },
    );
  }

  /// The container for the current page, with its background color
  /// and subtle switching animation.
  ///
  /// With lots and lots and lots and lots of thanks to
  /// [Immich](https://github.com/immich-app/immich/blob/main/mobile/lib/shared/views/tab_controller_page.dart)
  ColoredBox mainArea(ColorScheme colorScheme, Widget child) {
    final mainArea = ColoredBox(
      color: colorScheme.surfaceVariant,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: child,
      ),
    );
    return mainArea;
  }
}
