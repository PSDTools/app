import "package:freezed_annotation/freezed_annotation.dart";

part "device_data.freezed.dart";

@freezed
class DeviceData with _$DeviceData {
  factory DeviceData({
    required String name,
  }) = _DeviceData;
}

enum Device { android, ios, other }
