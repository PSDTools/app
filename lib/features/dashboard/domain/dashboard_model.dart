/// This library contains the dashboard feature's [Model].
library;

import "package:flutter/foundation.dart";
import "package:freezed_annotation/freezed_annotation.dart";

import "../../../utils/models.dart";
import "applet_entity.dart";

part "dashboard_model.freezed.dart";
part "dashboard_model.g.dart";

/// Represent the model for the dashboard.
@freezed
@immutable
sealed class DashboardModel with _$DashboardModel {
  /// Create a new, immutable [DashboardModel].
  const factory DashboardModel({
    required List<AppletEntity> applets,
  }) = _DashboardModel;

  /// Convert a JSON [Map] into a new, immutable [DashboardModel].
  factory DashboardModel.fromJson(Map<String, dynamic> json) =>
      _$DashboardModelFromJson(json);
}
