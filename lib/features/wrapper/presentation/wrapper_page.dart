/// This file contains the [WrapperPage] widget, which wraps the pages.
library pirate_code.features.wrapper.presentation.wrapper_page;

import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";

import "../../../app/app_router.dart";
import "../../../l10n/l10n.dart";
import "../../utils/presentation/device_banner.dart";

/// Wrap the app, providing navigation and routing.
/// It enforces that the app is under `/pirate-coins`.
/// It also provides a [Scaffold] with a [BottomNavigationBar] or [NavigationRail].
///
///
/// With lots and lots and lots and lots of thanks to many, including:
/// - [Immich](https://github.com/immich-app/immich/blob/main/mobile/lib/shared/views/tab_controller_page.dart),
/// - [StackOverflow](https://stackoverflow.com/a/62163655), and
/// - [@gbaccetta](https://github.com/gbaccetta/flutter_navigation_tutorial/blob/master/lib/group_screens/group_screen.dart).
@RoutePage()
class WrapperPage extends StatelessWidget {
  /// Create a new instance of [WrapperPage].
  const WrapperPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return AutoTabsRouter(
          routes: const [
            PirateCoinsRoute(),
            StatsRoute(),
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

            final small = constraints.maxWidth < 450;

            final page = small
                ? _MobileWrapper(child: child)
                : _ExpandedWrapper(constraints: constraints, child: child);

            return WillPopScope(
              onWillPop: onWillPop,
              child: SafeArea(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: DeviceBanner(child: page),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class _ExpandedWrapper extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final tabsRouter = AutoTabsRouter.of(context);
    final l10n = context.l10n;
    final large = constraints.maxWidth >= 600;

    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            extended: large,
            destinations: [
              NavigationRailDestination(
                icon: const Icon(Icons.currency_bitcoin_outlined),
                label: Text(l10n.pirateCoinsPageTitle),
              ),
              NavigationRailDestination(
                icon: const Icon(Icons.stacked_bar_chart),
                label: Text(l10n.statsPageTitle),
              ),
            ],
            selectedIndex: tabsRouter.activeIndex,
            onDestinationSelected: tabsRouter.setActiveIndex,
          ),
          Expanded(child: child),
        ],
      ),
    );
  }
}

class _MobileWrapper extends StatelessWidget {
  const _MobileWrapper({
    required this.child,
    // Temporary ignore, see <dart-lang/sdk#49025>.
    // ignore: unused_element
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final tabsRouter = AutoTabsRouter.of(context);
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
        leading: const AutoLeadingButton(),
        title: Text(context.topRoute.title(context)),
      ),
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.currency_bitcoin_outlined),
            label: l10n.pirateCoinsPageTitle,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.stacked_bar_chart),
            label: l10n.statsPageTitle,
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
