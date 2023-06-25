import "package:freezed_annotation/freezed_annotation.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../data/device.dart";

part "device_data.freezed.dart";
part "device_data.g.dart";

@freezed
class DeviceData with _$DeviceData {
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

enum Device { android, ios, other }

enum BuildMode { debug, profile, release }

@riverpod
Future<DeviceData> deviceInfo(DeviceInfoRef ref) async {
  return await ref
      .watch(deviceUtilsProvider.select((value) => value.deviceInfo()));
}

@riverpod
BuildMode buildMode(BuildModeRef ref) {
  return ref
      .watch(deviceUtilsProvider.select((value) => value.currentBuildMode()));
}
