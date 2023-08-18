import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:freezed_annotation/freezed_annotation.dart";

import "../../../gen/assets.gen.dart";
import "../../../utils/models.dart";
import "../../auth/domain/auth_model.dart";

part "dashboard_model.freezed.dart";

/// The model for the dashboard.
@freezed
@immutable
sealed class DashboardModel with _$DashboardModel implements Model {
  /// Create a new, immutable [DashboardModel].
  const factory DashboardModel({
    required List<Applet> applets,
    required PirateUser? user,
  }) = _DashboardModel;
}

/// Represent an applet, which is a widget that can be added to the dashboard.
@freezed
@immutable
sealed class Applet with _$Applet implements Model {
  /// Create a new, immutable [Applet].
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
