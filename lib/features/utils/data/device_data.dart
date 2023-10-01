/// This library contains the utilities feature's device data fetchers.
library;

import "package:device_info_plus/device_info_plus.dart";
import "package:os_detect/os_detect.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../domain/device_model.dart";

part "device_data.g.dart";

/// A repository for device information.
abstract interface class DeviceRepository {
  /// Get information about the [currentPlatform].
  Future<DeviceData> deviceInfo();
}

/// The default implementation of [DeviceRepository], using [DeviceInfoPlugin] from [`device_info_plus`](https://pub.dev/packages/device_info_plus).
/// This implementation will return the device information for the [currentPlatform].
/// If the platform is not supported, it will return a default value.
base class _DeviceUtilsRepository implements DeviceRepository {
  /// Create a new instance of [_DeviceUtilsRepository].
  const _DeviceUtilsRepository({
    required DeviceInfoPlugin plugin,
    required Device platform,
  })  : _plugin = plugin,
        _platform = platform;

  final DeviceInfoPlugin _plugin;
  final Device _platform;

  @override
  Future<DeviceData> deviceInfo() async {
    switch (_platform) {
      case Device.android:
        final androidInfo = await _plugin.androidInfo;
        final version = androidInfo.version;
        final info = DeviceData(
          device: _platform,
          isPhysicalDevice: androidInfo.isPhysicalDevice,
          model: androidInfo.model,
          manufacturer: androidInfo.manufacturer,
          release: version.release,
          sdkInt: version.sdkInt,
        );

        return info;

      case Device.ios:
        final iosInfo = await _plugin.iosInfo;
        final info = DeviceData(
          device: _platform,
          isPhysicalDevice: iosInfo.isPhysicalDevice,
          model: iosInfo.model,
          name: iosInfo.name,
          systemName: iosInfo.systemName,
          systemVersion: iosInfo.systemVersion,
        );

        return info;

      case _:
        return DeviceData(
          device: _platform,
          isPhysicalDevice: false,
          model: "Unknown",
        );
    }
  }
}

/// Get the information about the [currentPlatform] and build mode.
@riverpod
DeviceRepository deviceUtils(DeviceUtilsRef ref) {
  final device = ref.watch(currentPlatformProvider);
  final plugin = DeviceInfoPlugin();

  return _DeviceUtilsRepository(plugin: plugin, platform: device);
}

/// Get the current device platform as an enum.
@Riverpod(keepAlive: true)
Device currentPlatform(CurrentPlatformRef ref) {
  return switch (operatingSystem) {
    "android" => Device.android,
    "ios" => Device.ios,
    _ => Device.other,
  };
}
