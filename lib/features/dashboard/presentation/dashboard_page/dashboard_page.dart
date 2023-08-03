/// The auth feature.
library pirate_code.features.dashboard.page;

import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "../../../../../app/app_router.dart";
import "../../../../../l10n/l10n.dart";
import "../../domain/dashboard_domain.dart";

/// The page located at `/login/`
@RoutePage()
class DashboardPage extends ConsumerWidget {
  /// Create a new instance of [DashboardPage].
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gridItemHeight = MediaQuery.of(context).size.height / 3;
    const appletsFolder = "../../../../../../assets/applets/";
    final buttonsData = <Map<String, dynamic>>[
      {
        "imagePath": appletsFolder + "pirate-coins.png",
        "backgroundColor": const Color.fromARGB(255, 122, 194, 129),
        "title": "Pirate Coins",
        "destination": "/pirate-coins",
      },
      {
        "imagePath": appletsFolder + "gpa-calculator.png",
        "backgroundColor": const Color.fromARGB(255, 242, 184, 184),
        "title": "GPA Calculator",
        "destination": "/gpa-calculator",
      },
      {
        "imagePath": appletsFolder + "phs-map.png",
        "backgroundColor": const Color.fromARGB(255, 178, 254, 186),
        "title": "PHS Map",
        "destination": "/phs-map",
      },
      {
        "imagePath": appletsFolder + "temp-image.png",
        "backgroundColor": const Color.fromARGB(255, 249, 183, 255),
        "title": "Temp",
        "destination": "/email",
      },
      {
        "imagePath": appletsFolder + "temp-image.png",
        "backgroundColor": const Color.fromARGB(255, 187, 198, 255),
        "title": "Temp",
        "destination": "/favorite",
      },
      {
        "imagePath": appletsFolder + "temp-image.png",
        "backgroundColor": const Color.fromARGB(255, 255, 205, 130),
        "title": "Temp",
        "destination": "/cart",
      },
      {
        "imagePath": appletsFolder + "temp-image.png",
        "backgroundColor": Colors.blue,
        "title": "Temp",
        "destination": "/camera",
      },
      {
        "imagePath": appletsFolder + "temp-image.png",
        "backgroundColor": Colors.green,
        "title": "Temp",
        "destination": "/phone",
      },
      // Add more buttons data here
      {
        "imagePath": appletsFolder + "temp-image.png",
        "backgroundColor": Colors.purple,
        "title": "Temp",
        "destination": "/music",
      },
      {
        "imagePath": appletsFolder + "temp-image.png",
        "backgroundColor": Colors.orange,
        "title": "Temp",
        "destination": "/inbox",
      },
      {
        "imagePath": appletsFolder + "temp-image.png",
        "backgroundColor": Colors.red,
        "title": "Temp",
        "destination": "/notifications",
      },
      {
        "imagePath": appletsFolder + "temp-image.png",
        "backgroundColor": Colors.blue,
        "title": "Temp",
        "destination": "/calendar",
      },
      // Add more buttons data here
      {
        "imagePath": appletsFolder + "temp-image.png",
        "backgroundColor": Colors.green,
        "title": "Temp",
        "destination": "/coffee",
      },
      {
        "imagePath": appletsFolder + "temp-image.png",
        "backgroundColor": Colors.yellow,
        "title": "Temp",
        "destination": "/pizza",
      },
      {
        "imagePath": appletsFolder + "temp-image.png",
        "backgroundColor": Colors.blue,
        "title": "Temp",
        "destination": "/movies",
      },
      {
        "imagePath": appletsFolder + "temp-image.png",
        "backgroundColor": Colors.purple,
        "title": "Temp",
        "destination": "/book",
      },
      // Add more buttons data here
    ];
    final itemsData = <Map<String, dynamic>>[
      {
        "read": true,
        "title": "First Item",
      },
      {
        "read": false,
        "title": "Second Item",
      },
      // Add more items data here
      {
        "read": true,
        "title": "Nth Item",
      },
    ];

    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // Replace this with your other widgets if needed
                  Expanded(
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16.0,
                        mainAxisSpacing: 16.0,
                      ),
                      itemCount: buttonsData.length,
                      itemBuilder: (BuildContext context, int index) {
                        final buttonData = buttonsData[index];
                        return buildButton(context, buttonData);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 243, 243, 243),
                  borderRadius: BorderRadius.all(
                    Radius.circular(35.0),
                  ),
                ),
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 1 / 3,
                          height: 40,
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 252, 154, 255),
                            borderRadius: BorderRadius.all(
                              Radius.circular(35.0),
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
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 1 / 3,
                          height: 80,
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 255, 115, 115),
                            borderRadius: BorderRadius.all(
                              Radius.circular(35.0),
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.only(left: 20.0, top: 10.0),
                            child: Text(
                              "Gmail",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 1 / 3,
                          height: 80,
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 115, 169, 255),
                            borderRadius: BorderRadius.all(
                              Radius.circular(35.0),
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.only(left: 20.0, top: 10.0),
                            child: Text(
                              "Announcements",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 1 / 3,
                          height: 80,
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 115, 255, 117),
                            borderRadius: BorderRadius.all(
                              Radius.circular(35.0),
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.only(left: 20.0, top: 10.0),
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

Widget buildButton(BuildContext context, Map<String, dynamic> buttonData) {
  final imagePath = buttonData["imagePath"] as String;
  final backgroundColor = buttonData["backgroundColor"] as Color;
  final title = buttonData["title"] as String;
  final destination = buttonData["destination"] as String;

  return GestureDetector(
    onTap: () async {
      // Handle button tap here, e.g., navigate to the specified destination
      await Navigator.pushNamed(context, destination);
    },
    child: Card(
      color: backgroundColor,
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(35.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 8.0),
          Text(
            title,
            style: const TextStyle(
                color: Color.fromARGB(255, 0, 0, 0), fontSize: 16.0),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
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
