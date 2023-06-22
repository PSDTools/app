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

@Riverpod(dependencies: [flavor, StringUtils])
class FlavorConfig extends _$FlavorConfig {
  FlavorConfig({
    required this.flavor,
    required this.values,
    this.color = Colors.blue,
  });

  @override
  FlavorConfig build() {
    final flavor = ref.watch(flavorProvider);

    return FlavorConfig(
      flavor: flavor,
      values: FlavorValues(),
    );
  }

  final Flavor flavor;
  final Color color;
  final FlavorValues values;

  bool get isProduction => flavor == Flavor.production;
  bool get isDevelopment => flavor == Flavor.development;
  bool get isStaging => flavor == Flavor.staging;
  String get name {
    final stringUtils = ref.watch(stringUtilsProvider);

    return stringUtils.enumName(flavor.toString());
  }
}
