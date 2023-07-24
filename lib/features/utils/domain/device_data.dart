/// The utils feature's device model.
library pirate_code.features.utils.domain.device;

import "package:flutter/foundation.dart";
import "package:freezed_annotation/freezed_annotation.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../data/device.dart";

part "device_data.freezed.dart";
part "device_data.g.dart";

/// Information about the [currentPlatform].
@freezed
@immutable
sealed class DeviceData with _$DeviceData {
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
}

/// An enum containing the supported devices.
enum Device {
  /// The Android platform.
  android,

  /// The iOS platform.
  ios,

  /// Other platforms.
  other;
}

/// An enum containing the possible build modes.
enum BuildMode {
  /// The debug build mode.
  /// This is the only mode that can run on emulators.
  debug,

  /// The profile build mode.
  /// This is the mode that can be used to profile the app.
  profile,

  /// The release build mode.
  /// This is the only mode that should be published to the app store.
  release;

  /// Check if the current build mode is [debug].
  bool get isDebug => this == BuildMode.debug;

  /// Check if the current build mode is [profile].
  bool get isProfile => this == BuildMode.profile;

  /// Check if the current build mode is [release].
  bool get isRelease => this == BuildMode.release;
}

/// Get the [currentPlatform]'s information.
@riverpod
Future<DeviceData> deviceInfo(DeviceInfoRef ref) async {
  return await ref
      .watch(deviceUtilsProvider.select((value) => value.deviceInfo()));
}

/// Get the current build mode.
@riverpod
BuildMode buildMode(BuildModeRef ref) =>
    ref.watch(deviceUtilsProvider.select((value) => value.currentBuildMode()));
