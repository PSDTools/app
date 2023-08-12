import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:freezed_annotation/freezed_annotation.dart";

import "../../../gen/assets.gen.dart";

part "dashboard_model.freezed.dart";

///
@freezed
class Applet with _$Applet {
  ///
  const factory Applet({
    required String name,
    required AssetGenImage image,
    required Color color,
    required PageRouteInfo location,
    // required String id,
    // required String name,
    // required String description,
    // required String icon,
    // required String url,
    // required String type,
    // required String category,
    // required String color,
    // required String status,
    // required String createdAt,
    // required String updatedAt,
  }) = _Applet;
}
