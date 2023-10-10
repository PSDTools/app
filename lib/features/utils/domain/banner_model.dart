/// This library contains the utilities feature's development banner's [Model].
library;

import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:freezed_annotation/freezed_annotation.dart";

import "../../../utils/models.dart";

part "banner_model.freezed.dart";

/// Represent the development banner's configuration.
@freezed
@immutable
sealed class BannerConfig with _$BannerConfig {
  /// Create a new, immutable instance of [BannerConfig].
  const factory BannerConfig({
    /// The name to display on the banner.
    required String name,

    /// The color of the banner.
    required Color color,
  }) = _BannerConfig;
}
