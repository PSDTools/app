/// This library contains the utilities feature's device [Model].
library;

import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:freezed_annotation/freezed_annotation.dart";

import "../../../utils/models.dart";
import "../data/device_data.dart";

part "device_model.freezed.dart";
part "device_model.g.dart";

/// Represent [Model]ed information about the [currentPlatform].
@freezed
@immutable
sealed class DeviceData with _$DeviceData implements Model {
  /// Create a new, immutable instance of [DeviceData].
  const factory DeviceData({
    /// The current [Device].
    required Device device,

    /// If the current [Device] is a physical device.
    required bool isPhysicalDevice,

    /// The current [Device]'s model.
    required String model,

    /// The current [Device]'s name.
    String? name,

    /// The current [Device]'s operating system.
    String? systemName,

    /// The current [Device]'s operating system version.
    String? systemVersion,

    /// The current [Device]'s manufacturer.
    String? manufacturer,

    /// The current [Device]'s release.
    String? release,

    /// The current [Device]'s SDK number.
    int? sdkInt,
  }) = _DeviceData;

  /// Convert a JSON [Map] into a new, immutable instance of [DeviceData].
  factory DeviceData.fromJson(Map<String, Object?> json) =>
      _$DeviceDataFromJson(json);
}

/// An enum containing the supported devices.
enum Device {
  /// The Android platform.
  android,

  /// The iOS platform.
  ios,

  /// Other platforms, like Fuchsia.
  other;
}

/// An enum containing the possible build modes.
enum BuildMode {
  /// The debug build mode.
  /// This is the only mode that can run on emulators.
  debug(Colors.blue),

  /// The profile build mode.
  /// This is the mode that can be used to profile the app.
  profile(Colors.red),

  /// The release build mode.
  /// This is the only mode that should be published to the app store.
  release(Colors.green);

  const BuildMode(this.color);

  /// The color associated with the build mode.
  final Color color;

  /// Check if the current build mode is [debug].
  bool get isDebug => this == BuildMode.debug;

  /// Check if the current build mode is [profile].
  bool get isProfile => this == BuildMode.profile;

  /// Check if the current build mode is [release].
  bool get isRelease => this == BuildMode.release;
}
