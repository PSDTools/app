import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:freezed_annotation/freezed_annotation.dart";

import "../../../utils/json_converters.dart";

part "applet_entity.freezed.dart";
part "applet_entity.g.dart";

/// Represent an applet, which is a widget that can be added to the dashboard.
@freezed
@immutable
sealed class AppletEntity with _$AppletEntity {
  /// Create a new, immutable [AppletEntity].
  const factory AppletEntity({
    /// The name of the applet.
    required String name,

    /// The image to display on the applet's widget.
    required String image,

    /// The color to display as the background of the applet's widget.
    @ColorConverter() required Color color,

    /// Where the applet's widget should link to.
    required String location,
    // required String id,
    // required String description,
    // required String type,
    // required String category,
    // required String status,
    // required String createdAt,
    // required String updatedAt,
  }) = _AppletEntity;

  /// Convert a JSON [Map] into a new, immutable [AppletEntity].
  factory AppletEntity.fromJson(Map<String, dynamic> json) =>
      _$AppletEntityFromJson(json);
}
