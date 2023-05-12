import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "app_router.dart";

@RoutePage()
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    return LayoutBuilder(
      builder: (context, constraints) {
        return AutoTabsRouter(
          routes: const [
            GeneratorRoute(),
            FavoritesRoute(),
          ],
          builder: (context, child) {
            final tabsRouter = AutoTabsRouter.of(context);

            // The container for the current page, with its background color
            // and subtle switching animation.
            var mainArea = ColoredBox(
              color: colorScheme.surfaceVariant,
              child: const AnimatedSwitcher(
                duration: Duration(milliseconds: 200),
                child: AutoRouter(),
              ),
            );

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
                body: mainArea,
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
              return Scaffold(
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
                    Expanded(child: mainArea),
                  ],
                ),
              );
            }
          },
        );
      },
    );
  }
}
