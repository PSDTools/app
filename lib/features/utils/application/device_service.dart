/// This library contains the utilities feature's device business logic.
library;

import "package:riverpod_annotation/riverpod_annotation.dart";

import "../data/device_repository.dart";
import "../domain/device_model.dart";

part "device_service.g.dart";

/// Get the [currentPlatform]'s information.
@riverpod
Future<DeviceData> deviceInfo(DeviceInfoRef ref) async {
  final deviceInfo = ref.watch(
    deviceUtilsProvider.select((value) => value.deviceInfo),
  );

  return deviceInfo();
}
