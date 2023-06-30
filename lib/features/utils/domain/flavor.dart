/// The utils feature's flavor data.
library pirate_code.features.utils.data.flavor;

import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:freezed_annotation/freezed_annotation.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../dart_define.gen.dart";
import "../../../utils/common/string.dart";
import "../../../utils/data/secrets.dart";

part "flavor.freezed.dart";
part "flavor.g.dart";

/// This class contains flavor-specific configurations.
@freezed
@immutable
class FlavorValues with _$FlavorValues {
  /// Create a new instance of [FlavorValues].
  const factory FlavorValues() = _FlavorValues;

  // Add flavor-specific values that aren't secrets.
}

@freezed
@immutable

/// This class contains flavor-specific configurations.
class FlavorConfig with _$FlavorConfig {
  /// Create a new instance of [FlavorConfig].
  const factory FlavorConfig({
    /// The flavor of the app.
    required Flavor flavor,

    /// The color of the flavor banner.
    required FlavorValues values,

    /// The flavor-specific values.
    required Color color,

    /// An instance of [StringUtils].
    required StringUtils stringUtils,
  }) = _FlavorConfig;

  const FlavorConfig._();

  /// If the app is in production mode.
  bool get isProduction => this.flavor == Flavor.production;

  /// If the app is in development mode.
  bool get isDevelopment => this.flavor == Flavor.development;

  /// If the app is in staging mode.
  bool get isStaging => this.flavor == Flavor.staging;

  /// The name of the flavor.
  String get name => stringUtils.enumName(flavor.toString());
}

/// Get the flavor, and its associated configuration, for the app.
@riverpod
FlavorConfig flavorConfig(FlavorConfigRef ref) {
  final flavor = ref.watch(flavorProvider);
  final stringUtils = ref.watch(stringUtilsProvider);

  return FlavorConfig(
    flavor: flavor,
    values: const FlavorValues(),
    color: Colors.blue,
    stringUtils: stringUtils,
  );
}
