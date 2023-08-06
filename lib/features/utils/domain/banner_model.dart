/// The dev banner's [Model].
library;

import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:freezed_annotation/freezed_annotation.dart";

import "../../../utils/models.dart";

part "banner_model.freezed.dart";
part "banner_model.g.dart";

/// The dev banner's associated configuration.
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

/// Converts to and from [Color] and [String].
///
/// With lots and lots and lots and lots of thanks to many, including:
/// - [Json_Serializable](https://pub.dev/packages/json_serializable),
/// - [Freezed](https://pub.dev/packages/freezed), and
/// - [StackOverflow](https://stackoverflow.com/a/49835615).
class ColorConverter implements JsonConverter<Color, String> {
  /// Create a new instance of [ColorConverter].
  const ColorConverter();

  @override
  Color fromJson(String json) {
    final valueString = json.split("(0x")[1].split(")")[0];
    final value = int.parse(valueString, radix: 16);

    return Color(value);
  }

  @override
  String toJson(Color data) => data.toString();
}
