/// This library contains the utilities feature's development banner's [Model].
library;

import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:freezed_annotation/freezed_annotation.dart";

import "../../../utils/json_converters.dart";
import "../../../utils/models.dart";

part "banner_model.freezed.dart";
part "banner_model.g.dart";

/// Represent the development banner's configuration.
@freezed
@immutable
sealed class BannerConfig with _$BannerConfig implements Model {
  /// Create a new, immutable instance of [BannerConfig].
  const factory BannerConfig({
    /// The name to display on the banner.
    required String bannerName,

    /// The color of the banner.
    @ColorConverter() required Color bannerColor,
  }) = _BannerConfig;

  /// Convert a JSON [Map] into a new, immutable instance of [BannerConfig].
  factory BannerConfig.fromJson(Map<String, Object?> json) =>
      _$BannerConfigFromJson(json);
}
