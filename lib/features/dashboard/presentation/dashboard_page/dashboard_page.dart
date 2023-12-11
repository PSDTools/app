/// This library contains the dashboard feature's main page.
library;

import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../../pirate_coins/application/coins_service.dart";
import "../../application/dashboard_service.dart";
import "../../domain/applet_entity.dart";

/// The page located at `/`.
@RoutePage()
class DashboardPage extends StatelessWidget {
  /// Create a new instance of [DashboardPage].
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Flex(
            direction:
                constraints.maxWidth > 200 ? Axis.vertical : Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              _Applets(),
              _NotificationBar(),
            ],
          );
        },
      ),
    );
  }
}

class _Applets extends ConsumerWidget {
  const _Applets({
    // Temporary ignore, see <dart-lang/sdk#49025>.
    // ignore: unused_element
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final buttonsData = ref.watch(appletsProvider);

    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: buttonsData.length,
                itemBuilder: (BuildContext context, int index) =>
                    _AppletButton(buttonData: buttonsData[index]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NotificationBar extends StatelessWidget {
  const _NotificationBar({
    // Temporary ignore, see <dart-lang/sdk#49025>.
    // ignore: unused_element
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const list = [
      // TODO(ParkerH27): Make this dynamic.
      _NotificationBarItem(
        name: "Pirate Life At a Glance",
        color: Color.fromARGB(255, 252, 154, 255),
        isTitle: true,
      ),
      _NotificationBarItem(
        name: "Gmail",
        color: Color.fromARGB(255, 255, 115, 115),
      ),
      _NotificationBarItem(
        name: "Canvas",
        color: Color.fromARGB(255, 208, 26, 25),
      ),
      _NotificationBarItem(
        name: "Announcements",
        color: Color.fromARGB(255, 115, 169, 255),
      ),
      _NotificationBarItem(
        name: "Calendar",
        color: Color.fromARGB(255, 115, 255, 117),
      ),
    ];

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 243, 243, 243),
            borderRadius: BorderRadius.all(
              Radius.circular(35),
            ),
          ),
          child: ListView.builder(
            itemBuilder: (context, index) {
              return list.elementAtOrNull(index);
            },
          ),
        ),
      ),
    );
  }
}

/// A button widget that navigates to a specified applet.
class _AppletButton extends ConsumerWidget {
  /// Create a new instance of [_AppletButton].
  const _AppletButton({
    required this.buttonData,
    // Temporary ignore, see <dart-lang/sdk#49025>.
    // ignore: unused_element
    super.key,
  });

  /// The list of
  final AppletEntity buttonData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppletEntity(
      image: imagePath,
      color: backgroundColor,
      name: title,
      location: destination,
    ) = buttonData;

    return Card(
      color: backgroundColor,
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(35),
      ),
      child: InkWell(
        onTap: () async {
          ref.read(currentStageProvider.notifier).reset();
          // Handle button tap here to navigate to the specified destination.
          await context.router.pushNamed(destination);
        },
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isLarge = constraints.maxWidth < 50;

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isLarge) ...[
                  const SizedBox(height: 8),
                  Text(
                    title,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 16,
                    ),
                  ),
                ],
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Image.asset(
                      imagePath,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _NotificationBarItem extends StatelessWidget {
  const _NotificationBarItem({
    required this.name,
    required this.color,
    this.isTitle = false,
    // Temporary ignore, see <dart-lang/sdk#49025>.
    // ignore: unused_element
    super.key,
  });

  final String name;
  final Color color;
  final bool isTitle;

  @override
  ListTile build(BuildContext context) {
    return ListTile(
      title: _NotificationItem(
        name: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Center(
            child: Text(
              name,
              style: TextStyle(fontSize: isTitle ? 24 : 16),
            ),
          ),
        ),
        color: color,
        height: isTitle ? 60 : 80,
      ),
    );
  }
}

class _NotificationItem extends StatelessWidget {
  const _NotificationItem({
    required this.name,
    required this.color,
    required this.height,
    // Temporary ignore, see <dart-lang/sdk#49025>.
    // ignore: unused_element
    super.key,
  });

  final Widget name;
  final Color color;
  final double height;

  @override
  Padding build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Container(
        width: MediaQuery.of(context).size.width * 1 / 3,
        height: height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(
            Radius.circular(35),
          ),
        ),
        child: Align(
          alignment: Alignment.topCenter,
          child: name,
        ),
      ),
    );
  }
}
