/// The utils feature's banner data.
library pirate_code.features.utils.domain.banner;

import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:freezed_annotation/freezed_annotation.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../utils/constants.dart";

part "banner.freezed.dart";
part "banner.g.dart";

/// The dev banner's associated configuration.
@freezed
@immutable
sealed class BannerConfig with _$BannerConfig {
  /// Create a new, immutable instance of [BannerConfig].
  const factory BannerConfig({
    /// The name to display on the banner.
    required String bannerName,

    /// The color of the banner.
    required Color bannerColor,
  }) = _BannerConfig;
}

/// Get the default fallback banner.
@riverpod
BannerConfig defaultBanner(DefaultBannerRef ref) {
  return BannerConfig(
    bannerName: buildMode.name,
    bannerColor: buildMode.color,
  );
}
