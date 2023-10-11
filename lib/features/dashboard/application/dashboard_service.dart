/// This library contains the dashboard features's business logic.
library;

import "package:flutter/material.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../gen/assets.gen.dart";
import "../domain/applet.dart";
import "../domain/dashboard_model.dart";

part "dashboard_service.g.dart";

/// Get the applets list and other such data.
@riverpod
class DashboardService extends _$DashboardService {
  @override
  DashboardModel build() {
    final applets = ref.watch(_appletsProvider);

    return DashboardModel(applets: applets);
  }
}

/// Get the list of applets.
@riverpod
List<Applet> _applets(_AppletsRef ref) {
  // Add more buttons here
  // Ideas:
  //
  // Email inbox
  // Notifications
  // Calendar

  const appletsFolder = Assets.applets;
  return [
    Applet(
      name: "Pirate Coins",
      image: appletsFolder.pirateCoins.path,
      color: const Color.fromARGB(255, 122, 194, 129),
      // TODO(lishaduck): figure out how to use routes to keep this type-safe.
      location: "/pirate-coins",
    ),
    Applet(
      image: appletsFolder.gpaCalculator.path,
      color: const Color.fromARGB(255, 242, 184, 184),
      name: "GPA Calculator",
      location: "/gpa-calculator",
    ),
    // Applet(
    //   image: appletsFolder.phsMap,
    //   color: const Color.fromARGB(255, 178, 254, 186),
    //   name: "PHS Map",
    //   location: const PhsMapRoute(),
    // ),
  ];
}
