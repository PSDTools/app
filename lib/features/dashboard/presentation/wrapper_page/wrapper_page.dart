/// This file contains the [WrapperPage] widget, which wraps the pages.
library pirate_code.features.wrapper.presentation.wrapper_page;

import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

import "../../../../app/app_router.dart";
import "../../../../utils/log.dart";
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
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: IconButton(
          onPressed: () async {
            log.info("Nothing to see here, move along.");
          },
          icon: const Icon(Icons.home),
          color: Colors.black,
        ),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: 80,
            color: theme.appBarTheme.backgroundColor,
            child: RotatedBox(
              quarterTurns: 1,
              child: Text(
                "Pattonville Pirates",
                style: GoogleFonts.mrDafoe(
                  color: const Color.fromARGB(255, 11, 70, 24),
                  shadows: [
                    Shadow(
                      color: theme.colorScheme.shadow.withOpacity(0.5),
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
              color: theme.appBarTheme.backgroundColor ??
                  const Color.fromARGB(255, 43, 188, 75),
              child: Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceVariant, // background color
                  border: Border.all(
                    color: Colors.transparent, // border color
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(25),
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Green Home Page"),
      ),
      body: child,
    );
  }
}
