/// This library contains the [WrapperPage] widget, which wraps the pages.
///
/// This didn't warrant its own feature, so it gets lumped in here.
library;

import "package:auto_route/auto_route.dart";
import "package:auto_size_text/auto_size_text.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:url_launcher/link.dart";

import "../../../../app/app_router.dart";
import "../../../../gen/assets.gen.dart";
import "../../../../gen/fonts.gen.dart";
import "../../../../gen/version.gen.dart";
import "../../../../utils/hooks.dart";
import "../../../auth/application/auth_service.dart";

/// Wrap the app, providing navigation and routing.
/// It enforces that the app is under `/pirate-coins`.
/// It also provides a [Scaffold] with a [BottomNavigationBar] or [NavigationRail].
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
        return AutoRouter(
          builder: (context, child) {
            final isSmall = constraints.maxWidth < 450;

            final page = isSmall
                ? _MobileWrapper(child: child)
                : _ExpandedWrapper(constraints: constraints, child: child);

            return SafeArea(
              child: page,
            );
          },
        );
      },
    );
  }
}

class _ExpandedWrapper extends HookConsumerWidget {
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
    final theme = Theme.of(context);
    final name = ref.watch(usernameProvider).valueOrNull;
    final email = ref.watch(emailProvider).valueOrNull;
    final avatar = ref.watch(avatarProvider).valueOrNull;

    return Scaffold(
      appBar: AppBar(
        title: IconButton(
          onPressed: () async => context.router.push(const DashboardRoute()),
          icon: const Icon(Icons.home),
          color: Colors.black,
          tooltip: "Going Home!",
        ),
      ),
      drawer: NavigationDrawer(
        children: [
          UserAccountsDrawerHeader(
            accountName: name != null ? AutoSizeText(name) : null,
            accountEmail: email != null ? AutoSizeText(email) : null,
            currentAccountPicture: avatar != null
                ? CircleAvatar(backgroundImage: MemoryImage(avatar))
                : null,
          ),
          AboutListTile(
            icon: const Icon(Icons.info),
            applicationIcon: Assets.icon.icon.image(width: 50),
            applicationName: "Pattonville Wallet",
            applicationVersion: packageVersion,
            applicationLegalese: "© 2023 Eli D. and Parker H.",
            aboutBoxChildren: [
              const SizedBox(height: 24),
              Link(
                uri: Uri.https("github.com", "PSDTools/app"),
                target: LinkTarget.blank,
                builder: (context, followLink) {
                  return _AppDescription(followLink: followLink);
                },
              ),
            ],
          ),
        ],
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
                style: TextStyle(
                  fontFamily: FontFamily.mrDafoe,
                  color: const Color.fromARGB(255, 9, 56, 19),
                  shadows: [
                    Shadow(
                      color: theme.colorScheme.shadow.withOpacity(0.5),
                      blurRadius: 1,
                    ),
                  ],
                ),
                textScaler: const TextScaler.linear(4),
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
                  color: theme
                      .colorScheme.surfaceContainerHighest, // background color
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

class _AppDescription extends HookWidget {
  const _AppDescription({
    this.followLink,
    // Temporary ignore, see <dart-lang/sdk#49025>.
    // ignore: unused_element
    super.key,
  });

  final GestureTapCallback? followLink;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final textStyle = theme.textTheme.bodyMedium;

    final tapGestureRecognizer = useTapGestureRecognizer(
      onTap: followLink,
    );

    return Text.rich(
      TextSpan(
        style: textStyle,
        children: [
          const TextSpan(
            text:
                "Pattonville Wallet is hopefully going to become Pattonville School District's new app for reenforcing positive behavior. View the source at ",
          ),
          TextSpan(
            style: textStyle?.copyWith(
              color: theme.colorScheme.primary,
            ),
            text: "github:PSDTools/app",
            recognizer: tapGestureRecognizer,
          ),
          const TextSpan(text: "."),
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
        leading: const AutoLeadingButton(),
        title: AutoSizeText(context.topRoute.title(context)),
      ),
      body: child,
    );
  }
}
