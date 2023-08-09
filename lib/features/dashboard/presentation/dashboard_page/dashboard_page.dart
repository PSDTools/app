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

    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Replace this with your other widgets if needed
                  Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
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
          ),
          Expanded(
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
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 1 / 3,
                          height: 40,
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 252, 154, 255),
                            borderRadius: BorderRadius.all(
                              Radius.circular(35),
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              "Pirate Life At a Glance",
                              style: TextStyle(fontSize: 24),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 1 / 3,
                          height: 80,
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 255, 115, 115),
                            borderRadius: BorderRadius.all(
                              Radius.circular(35),
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.only(left: 20, top: 10),
                            child: Text(
                              "Gmail",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 1 / 3,
                          height: 80,
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 115, 169, 255),
                            borderRadius: BorderRadius.all(
                              Radius.circular(35),
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.only(left: 20, top: 10),
                            child: Text(
                              "Announcements",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 1 / 3,
                          height: 80,
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 115, 255, 117),
                            borderRadius: BorderRadius.all(
                              Radius.circular(35),
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.only(left: 20, top: 10),
                            child: Text(
                              "Pirate Calendar",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
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
