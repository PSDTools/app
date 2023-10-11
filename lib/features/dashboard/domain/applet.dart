import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:freezed_annotation/freezed_annotation.dart";

import "../../../utils/json_converters.dart";

part "applet.freezed.dart";
part "applet.g.dart";

/// Represent an applet, which is a widget that can be added to the dashboard.
@freezed
@immutable
sealed class Applet with _$Applet {
  /// Create a new, immutable [Applet].
  const factory Applet({
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
  }) = _Applet;

  /// Convert a JSON [Map] into a new, immutable [Applet].
  factory Applet.fromJson(Map<String, dynamic> json) => _$AppletFromJson(json);
}
