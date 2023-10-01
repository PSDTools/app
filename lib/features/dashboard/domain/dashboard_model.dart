/// This library contains the dashboard feature's [Model].
library;

import "package:auto_route/auto_route.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:freezed_annotation/freezed_annotation.dart";

import "../../../gen/assets.gen.dart";
import "../../../utils/models.dart";

part "dashboard_model.freezed.dart";

/// Represent the model for the dashboard.
@freezed
@immutable
sealed class DashboardModel with _$DashboardModel {
  /// Create a new, immutable [DashboardModel].
  const factory DashboardModel({
    required List<Applet> applets,
  }) = _DashboardModel;
}

/// Represent an applet, which is a widget that can be added to the dashboard.
@freezed
@immutable
sealed class Applet with _$Applet {
  /// Create a new, immutable [Applet].
  const factory Applet({
    /// The name of the applet.
    required String name,

    /// The image to display on the applet's widget.
    required AssetGenImage image,

    /// The color to display as the background of the applet's widget.
    required Color color,

    /// Where the applet's widget should link to.
    required PageRouteInfo location, // prevents JSON serialization
    // required String id,
    // required String description,
    // required String type,
    // required String category,
    // required String status,
    // required String createdAt,
    // required String updatedAt,
  }) = _Applet;
}
