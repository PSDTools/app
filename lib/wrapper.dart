import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "app/app_router.dart";

/// With lots and lots and lots and lots of thanks to many, including:
/// - [Immich](https://github.com/immich-app/immich/blob/main/mobile/lib/shared/views/tab_controller_page.dart),
/// - [StackOverflow](https://stackoverflow.com/a/62163655), and
/// - [@gbaccetta](https://github.com/gbaccetta/flutter_navigation_tutorial/blob/master/lib/group_screens/group_screen.dart).
@RoutePage()
class WrapperPage extends ConsumerWidget {
  const WrapperPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return AutoTabsRouter(
          routes: const [
            GeneratorRoute(),
            FavoritesRoute(),
            JimmyRoute(),
          ],
          duration: const Duration(milliseconds: 200),
          transitionBuilder: (context, child, animation) {
            final tabsRouter = AutoTabsRouter.of(context);

            Future<bool> onWillPop() async {
              final atHomeTab = tabsRouter.activeIndex == 0;
              if (!atHomeTab) {
                tabsRouter.setActiveIndex(0);
              }

              return atHomeTab;
            }

            final page = constraints.maxWidth < 450
                ? _MobileWrapper(child: child)
                : _ExpandedWrapper(constraints: constraints, child: child);

            return WillPopScope(
              onWillPop: onWillPop,
              child: SafeArea(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: page,
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class _ExpandedWrapper extends ConsumerWidget {
  const _ExpandedWrapper({
    required this.child,
    required this.constraints,
    // Temporary ignore, see <dart-lang/sdk#49025>.
    // ignore: unused_element
    super.key,
  });

  final Widget child;
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabsRouter = AutoTabsRouter.of(context);

    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            extended: constraints.maxWidth >= 100000,
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.home),
                label: Text("Home"),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.favorite),
                label: Text("Favorites"),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.face_2_sharp),
                label: Text("Jimmy"),
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
  }
}

class _MobileWrapper extends ConsumerWidget {
  const _MobileWrapper({
    required this.child,
    // Temporary ignore, see <dart-lang/sdk#49025>.
    // ignore: unused_element
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabsRouter = AutoTabsRouter.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: const AutoLeadingButton(),
        title: Text(context.topRoute.name),
      ),
      body: _MainArea(child: child),
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
          BottomNavigationBarItem(
            icon: Icon(Icons.face_2_sharp),
            label: "Jimmy",
          ),
        ],
        onTap: tabsRouter.setActiveIndex,
        currentIndex: tabsRouter.activeIndex,
        selectedIconTheme: const IconThemeData(
          color: Color.fromARGB(255, 39, 131, 0),
        ),
        unselectedIconTheme: const IconThemeData(
          color: Color.fromARGB(255, 0, 0, 0),
        ),
      ),
    );
  }
}

// The container for the current page, with its background color and subtle switching animation.
class _MainArea extends ConsumerWidget {
  const _MainArea({
    required this.child,
    // Temporary ignore, see <dart-lang/sdk#49025>.
    // ignore: unused_element
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
