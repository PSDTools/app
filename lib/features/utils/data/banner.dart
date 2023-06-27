/// The utils feature's banner data.
library pirate_code.features.utils.data.banner;

import "package:flutter/material.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "flavor.dart";

part "banner.g.dart";

/// The dev banner's associated configuration.
class BannerConfig {
  /// Create a new instance of [BannerConfig].
  BannerConfig({
    required this.bannerName,
    required this.bannerColor,
  });

  /// The name to display on the banner.
  final String bannerName;

  /// The color of the banner.
  final Color bannerColor;
}

/// Get the default fallback banner.
@riverpod
BannerConfig defaultBanner(DefaultBannerRef ref) {
  final flavorConfig = ref.watch(flavorConfigProvider);

  return BannerConfig(
    bannerName: flavorConfig.name,
    bannerColor: flavorConfig.color,
  );
}
