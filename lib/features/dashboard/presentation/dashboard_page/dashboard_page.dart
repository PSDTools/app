/// The auth feature.
library pirate_code.features.dashboard.page;

import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../app/app_router.dart";
import "../../../../gen/assets.gen.dart";
import "../../domain/dashboard_model.dart";

/// The page located at `/login/`.
@RoutePage()
class DashboardPage extends ConsumerWidget {
  /// Create a new instance of [DashboardPage].
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _Applets(),
          _NotificationBar(),
        ],
      ),
    );
  }
}

class _Applets extends StatelessWidget {
  const _Applets({
    // Temporary ignore, see <dart-lang/sdk#49025>.
    // ignore: unused_element
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const appletsFolder = Assets.applets;
    final buttonsData = [
      Applet(
        name: "Pirate Coins",
        image: appletsFolder.pirateCoins,
        color: const Color.fromARGB(255, 122, 194, 129),
        location: const PirateCoinsRoute(),
      ),
      // Applet(
      //   image: appletsFolder.gpaCalculator,
      //   color: const Color.fromARGB(255, 242, 184, 184),
      //   name: "GPA Calculator",
      //   location: const GpaCalculatorRoute(),
      // ),
      // Applet(
      //   image: appletsFolder.phsMap,
      //   color: const Color.fromARGB(255, 178, 254, 186),
      //   name: "PHS Map",
      //   location: const PhsMapRoute(),
      // ),

      // Add more buttons here
      // Ideas:
      //
      // Email inbox
      // Notifications
      // Calendar
    ];

    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Replace this with your other widgets if needed
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: buttonsData.length,
                itemBuilder: (BuildContext context, int index) {
                  final buttonData = buttonsData[index];
                  return _AppletButton(buttonData: buttonData);
                },
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
          child: ListView(
            children: const [
              _NotificationBarTitle(
                title: "Pirate Life At a Glance",
                color: Color.fromARGB(255, 252, 154, 255),
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
            ],
          ),
        ),
      ),
    );
  }
}

/// A button widget that navigates to a specified applet.
class _AppletButton extends StatelessWidget {
  /// Create a new instance of [_AppletButton].
  const _AppletButton({
    required this.buttonData,
    // Temporary ignore, see <dart-lang/sdk#49025>.
    // ignore: unused_element
    super.key,
  });

  /// The list of
  final Applet buttonData;

  @override
  Widget build(BuildContext context) {
    final imagePath = buttonData.image.path;
    final backgroundColor = buttonData.color;
    final title = buttonData.name;
    final destination = buttonData.location;

    return GestureDetector(
      onTap: () async {
        // Handle button tap here to navigate to the specified destination.
        final router = context.router;
        await router.push(destination);
      },
      child: Card(
        color: backgroundColor,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(35),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                color: Color.fromARGB(255, 0, 0, 0),
                fontSize: 16,
              ),
            ),
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
        ),
      ),
    );
  }
}

class _NotificationBarTitle extends StatelessWidget {
  const _NotificationBarTitle({
    required this.title,
    required this.color,
    // Temporary ignore, see <dart-lang/sdk#49025>.
    // ignore: unused_element
    super.key,
  });

  final String title;
  final Color color;

  @override
  _NotificationItem build(BuildContext context) {
    return _NotificationItem(
      name: Center(
        child: Text(
          title,
          style: const TextStyle(fontSize: 24),
        ),
      ),
      color: color,
      height: 40,
    );
  }
}

class _NotificationBarItem extends StatelessWidget {
  const _NotificationBarItem({
    required this.name,
    required this.color,
    // Temporary ignore, see <dart-lang/sdk#49025>.
    // ignore: unused_element
    super.key,
  });

  final String name;
  final Color color;

  @override
  _NotificationItem build(BuildContext context) {
    return _NotificationItem(
      name: Padding(
        padding: const EdgeInsets.only(left: 20, top: 10),
        child: Text(
          name,
          style: const TextStyle(fontSize: 16),
        ),
      ),
      color: color,
      height: 80,
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
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          width: MediaQuery.of(context).size.width * 1 / 3,
          height: height,
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.all(
              Radius.circular(35),
            ),
          ),
          child: name,
        ),
      ),
    );
  }
}
