import "package:device_info/device_info.dart";
import "package:freezed_annotation/freezed_annotation.dart";

part "device_data.freezed.dart";

@freezed
class DeviceData with _$DeviceData {
  factory DeviceData({
    required Device device,
    required bool isPhysicalDevice,
    required String model,
    String? name,
    String? systemName,
    String? systemVersion,
    AndroidBuildVersion? version,
    String? manufacturer,
    String? release,
    int? sdkInt,
  }) = _DeviceData;

  const DeviceData._();

  bool get isOther => device == Device.other;
}

enum Device { android, ios, other }
