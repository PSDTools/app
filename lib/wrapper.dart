import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "app/app_router.dart";

class Wrapper extends ConsumerWidget {
  const Wrapper({super.key});

  static const tabs = [
    Tab(text: "1", icon: Icon(Icons.abc)),
    Tab(text: "2", icon: Icon(Icons.abc)),
    Tab(text: "3", icon: Icon(Icons.abc)),
  ];

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

            final page = constraints.maxWidth < 450
                ? Scaffold(
                    appBar: AppBar(
                      leading: const AutoLeadingButton(),
                      title: Text(context.topRoute.name),
                      bottom: const TabBar(tabs: tabs),
                    ),
                    body: _MainArea(
                      child: child,
                    ),
                    bottomNavigationBar: BottomNavigationBar(
                      items: const [
                        BottomNavigationBarItem(
                          icon: Icon(Icons.home),
                          label: "Home",
                        ),
                        BottomNavigationBarItem(
                          icon: Icon(Icons.favorite),
                          label: "Favorites",
                        ),
                      ],
                      onTap: tabsRouter.setActiveIndex,
                      currentIndex: tabsRouter.activeIndex,
                    ),
                  )
                : Scaffold(
                    body: Row(
                      children: [
                        NavigationRail(
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
                        Expanded(
                          child: _MainArea(
                            child: child,
                          ),
                        ),
                      ],
                    ),
                  );

            return WillPopScope(
              onWillPop: onWillPop(tabsRouter),
              child: SafeArea(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: DefaultTabController(
                    length: tabs.length,
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

  Future<bool> Function() onWillPop(TabsRouter tabsRouter) {
    Future<bool> onWillPopFunc() async {
      final atHomeTab = tabsRouter.activeIndex == 0;
      if (!atHomeTab) {
        tabsRouter.setActiveIndex(0);
      }

      return atHomeTab;
    }

    return onWillPopFunc;
  }
}

/// (Not) generated route for [Wrapper].
class WrapperRoute extends PageRouteInfo<void> {
  const WrapperRoute({List<PageRouteInfo>? children})
      : super(
          WrapperRoute.name,
          initialChildren: children,
        );

  static const String name = "Wrapper";
  static const PageInfo<void> page = PageInfo<void>(name);
}

/// The container for the current page, with its background color and subtle switching animation.
///
/// With lots and lots and lots and lots of thanks to many.
///
/// - [Immich](https://github.com/immich-app/immich/blob/main/mobile/lib/shared/views/tab_controller_page.dart),
/// - [StackOverflow](https://stackoverflow.com/a/62163655), and
/// - [@gbaccetta](https://github.com/gbaccetta/flutter_navigation_tutorial/blob/master/lib/group_screens/group_screen.dart)
class _MainArea extends ConsumerWidget {
  const _MainArea({
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
