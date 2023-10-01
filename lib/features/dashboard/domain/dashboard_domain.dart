/// This library contains the dashboard features's business logic.
library;

import "package:flutter/material.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../app/app_router.dart";
import "../../../gen/assets.gen.dart";
import "dashboard_model.dart";

part "dashboard_domain.g.dart";

/// Get the applets list and other such data.
@riverpod
class DashboardDomain extends _$DashboardDomain {
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
      image: appletsFolder.pirateCoins,
      color: const Color.fromARGB(255, 122, 194, 129),
      location: const PirateCoinsRoute(),
    ),
    Applet(
      image: appletsFolder.gpaCalculator,
      color: const Color.fromARGB(255, 242, 184, 184),
      name: "GPA Calculator",
      location: const GpaRoute(),
    ),
    // Applet(
    //   image: appletsFolder.phsMap,
    //   color: const Color.fromARGB(255, 178, 254, 186),
    //   name: "PHS Map",
    //   location: const PhsMapRoute(),
    // ),
  ];
}
