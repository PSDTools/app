/// This file contains the [WrapperPage] widget, which wraps the pages.
library pirate_code.features.wrapper.presentation.wrapper_page;

import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";

import "../../../../app/app_router.dart";
import "../../../../l10n/l10n.dart";
import "../../../utils/presentation/device_info/device_banner.dart";

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
          routes: const [PirateCoinsRoute(), StatsRoute(), DashboardRoute()],
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
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 43, 188, 75),
        title: IconButton(
          onPressed: () async {
            print("Nothing to see here, move along.");
          },
          icon: Icon(Icons.home),
          color: Colors.black,
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 43, 188, 75),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: 80,
            color: const Color.fromARGB(255, 43, 188, 75),
            child: RotatedBox(
              quarterTurns: 1,
              child: Text(
                "Pattonville Pirates",
                style: TextStyle(
                  fontFamily: "MrDafoe",
                  color: Color.fromARGB(255, 11, 70, 24),
                  shadows: [
                    Shadow(
                      color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
                      offset: Offset(0, 0),
                      blurRadius: 1,
                    ),
                  ],
                ),
                textScaleFactor: 4,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Expanded(
            child: ColoredBox(
              color: Color.fromARGB(255, 43, 188, 75),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(
                      255, 255, 255, 255), //background color
                  border: Border.all(
                    color: Colors.transparent, // border color
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25.0),
                  ),
                ),
                child: child,
              ),
            ),
          ),
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
          title: Text('Green Home Page'),
          backgroundColor: Colors.green,
        ),
        body: child);
  }
}
