/// The utils feature's device model.
library pirate_code.features.utils.domain.device;

import "package:freezed_annotation/freezed_annotation.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../data/device.dart";

part "device_data.freezed.dart";
part "device_data.g.dart";

/// Information about the [currentDevice].
@freezed
class DeviceData with _$DeviceData {
  /// Create a new, immutable instance of [DeviceData].
  factory DeviceData({
    required Device device,
    required bool isPhysicalDevice,
    required String model,
    String? name,
    String? systemName,
    String? systemVersion,
    String? manufacturer,
    String? release,
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
  other
}

/// An enum containing the possible build modes.
enum BuildMode {
  /// The debug build mode.
  /// This is the only mode that can run on emulators.
  debug,

  /// The profile build mode.
  /// This is a mode that can be used to profile the app.
  profile,

  /// The release build mode.
  /// This is the only mode that can be published to the app store.
  release
}

/// Get the [currentDevice]'s information.
@riverpod
Future<DeviceData> deviceInfo(DeviceInfoRef ref) async {
  return await ref
      .watch(deviceUtilsProvider.select((value) => value.deviceInfo()));
}

/// Get the current build mode.
@riverpod
BuildMode buildMode(BuildModeRef ref) {
  return ref
      .watch(deviceUtilsProvider.select((value) => value.currentBuildMode()));
}
