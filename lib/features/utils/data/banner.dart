import "package:flutter/material.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "flavor.dart";

part "banner.g.dart";

class BannerConfig {
  BannerConfig({
    required this.bannerName,
    required this.bannerColor,
  });

  final String bannerName;
  final Color bannerColor;
}

@riverpod
BannerConfig defaultBanner(DefaultBannerRef ref) {
  final flavorConfig = ref.watch(flavorConfigProvider);

  return BannerConfig(
    bannerName: flavorConfig.name,
    bannerColor: flavorConfig.color,
  );
}
