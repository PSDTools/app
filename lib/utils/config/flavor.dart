import "package:flutter/material.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../dart_define.gen.dart";
import "../secrets.dart";
import "string.dart";

part "flavor.g.dart";

class FlavorValues {
  FlavorValues();
  // Add flavor-specific values that aren't secrets.
}

class FlavorConfig {
  FlavorConfig({
    required this.flavor,
    required this.values,
    this.color = Colors.blue,
  });

  final Flavor flavor;
  final Color color;
  final FlavorValues values;

  bool get isProduction => flavor == Flavor.production;
  bool get isDevelopment => flavor == Flavor.development;
  bool get isStaging => flavor == Flavor.staging;
  String get name => StringUtils.enumName(flavor.toString());
}

@riverpod
FlavorConfig flavorConfig(FlavorConfigRef ref) {
  final flavor = ref.watch(flavorProvider);

  return FlavorConfig(
    flavor: flavor,
    values: FlavorValues(),
  );
}
