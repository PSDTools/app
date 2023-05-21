import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "app/app_router.dart";

@RoutePage()
class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return AutoTabsRouter(
          routes: const [
            GeneratorRoute(),
            FavoritesRoute(),
          ],
          duration: const Duration(milliseconds: 200),
          transitionBuilder: (context, child, animation) {
            final tabsRouter = AutoTabsRouter.of(context);

            Widget page;
            if (constraints.maxWidth < 450) {
              page = Scaffold(
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
                body: MainArea(
                  child: child,
                ),
                bottomNavigationBar: BottomNavigationBar(
                  currentIndex: tabsRouter.activeIndex,
                  onTap: tabsRouter.setActiveIndex,
                  unselectedIconTheme: const IconThemeData(
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                  selectedIconTheme: const IconThemeData(
                    color: Color.fromARGB(255, 39, 131, 0),
                  ),
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
              page = Scaffold(
                body: Row(
                  children: [
                    NavigationRail(
                      selectedIndex: tabsRouter.activeIndex,
                      onDestinationSelected: tabsRouter.setActiveIndex,
                      extended: constraints.maxWidth >= 600,
                      destinations: const [
                        NavigationRailDestination(
                          icon: Icon(Icons.home),
                          label: Text("Home"),
                        ),
                        NavigationRailDestination(
                          icon: Icon(
                            Icons.favorite,
                            color: Color.fromARGB(255, 161, 0, 0),
                          ),
                          label: Text(
                            "Favorites",
                            style: TextStyle(
                              color: Color.fromARGB(255, 161, 0, 0),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: MainArea(
                        child: child,
                      ),
                    ),
                  ],
                ),
              );
            }

            return WillPopScope(
              onWillPop: () async {
                final atHomeTab = tabsRouter.activeIndex == 0;
                if (!atHomeTab) {
                  tabsRouter.setActiveIndex(0);
                }
                return atHomeTab;
              },
              child: SafeArea(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: DefaultTabController(
                    length: 3,
                    child: page,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

/// The container for the current page, with its background color
/// and subtle switching animation.
///
/// With lots and lots and lots and lots of thanks to
/// - [Immich](https://github.com/immich-app/immich/blob/main/mobile/lib/shared/views/tab_controller_page.dart),
/// - [StackOverflow](https://stackoverflow.com/a/62163655), and
/// - [@gbaccetta](https://github.com/gbaccetta/flutter_navigation_tutorial/blob/master/lib/group_screens/group_screen.dart)
class MainArea extends ConsumerWidget {
  const MainArea({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;

    return ColoredBox(
      color: colorScheme.surfaceVariant,
      child: child,
    );
  }
}
