import "package:flutter/material.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../dart_define.gen.dart";
import "../../../utils/secrets.dart";
import "../../../utils/string.dart";

part "flavor.g.dart";

class FlavorValues {
  FlavorValues();
  // Add flavor-specific values that aren't secrets.
}

class FlavorConfig {
  FlavorConfig({
    required this.flavor,
    required this.values,
    required this.color,
    required StringUtils stringUtils,
  }) : _stringUtils = stringUtils;

  final Flavor flavor;
  final Color color;
  final FlavorValues values;

  final StringUtils _stringUtils;

  bool get isProduction => flavor == Flavor.production;
  bool get isDevelopment => flavor == Flavor.development;
  bool get isStaging => flavor == Flavor.staging;

  String get name => _stringUtils.enumName(flavor.toString());
}

@Riverpod(dependencies: [flavor, StringUtils])
FlavorConfig flavorConfig(FlavorConfigRef ref) {
  final flavor = ref.watch(flavorProvider);
  final stringUtils = ref.watch(stringUtilsProvider);

  return FlavorConfig(
    flavor: flavor,
    values: FlavorValues(),
    color: Colors.blue,
    stringUtils: stringUtils,
  );
}
