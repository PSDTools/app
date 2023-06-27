/// The utils feature's flavor data.
library pirate_code.features.utils.data.flavor;

import "package:flutter/material.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../dart_define.gen.dart";
import "../../../utils/common/string.dart";
import "../../../utils/data/secrets.dart";

part "flavor.g.dart";

/// This class contains flavor-specific configurations.
class FlavorValues {
  /// Create a new instance of [FlavorValues].
  FlavorValues();

  // Add flavor-specific values that aren't secrets.
}

/// This class contains flavor-specific configurations.
class FlavorConfig {
  /// Create a new instance of [FlavorConfig].
  FlavorConfig({
    required this.flavor,
    required this.values,
    required this.color,
    required StringUtils stringUtils,
  }) : _stringUtils = stringUtils;

  /// The flavor of the app.
  final Flavor flavor;

  /// The color of the flavor banner.
  final Color color;

  /// The flavor-specific values.
  final FlavorValues values;

  final StringUtils _stringUtils;

  /// If the app is in production mode.
  bool get isProduction => flavor == Flavor.production;

  /// If the app is in development mode.
  bool get isDevelopment => flavor == Flavor.development;

  /// If the app is in staging mode.
  bool get isStaging => flavor == Flavor.staging;

  /// The name of the flavor.
  String get name => _stringUtils.enumName(flavor.toString());
}

/// Get the flavor, and it's associated configuration, for the app.
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
