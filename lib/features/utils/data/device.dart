/// The utils feature's device data.
library pirate_code.features.utils.data.device;

import "dart:io";

import "package:device_info_plus/device_info_plus.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../domain/device_data.dart";

part "device.g.dart";

/// A repository for device information.
abstract class DeviceRepository {
  /// Get the current build mode.
  BuildMode currentBuildMode();

  /// Get information about the [currentPlatform].
  Future<DeviceData> deviceInfo();
}

/// The default implementation of [DeviceRepository], using [DeviceInfoPlugin] from device_info_plus.
/// This implementation will return the device information for the [currentPlatform].
/// If the platform* is not supported by device_info_plus, it will return a default value.
/// * AKA Fuchsia.
class DeviceUtilsRepository implements DeviceRepository {
  /// Create a new instance of [DeviceUtilsRepository].
  const DeviceUtilsRepository({
    required DeviceInfoPlugin plugin,
    required Device platform,
  })  : _plugin = plugin,
        _platform = platform;

  final DeviceInfoPlugin _plugin;
  final Device _platform;

  @override
  BuildMode currentBuildMode() {
    if (const bool.fromEnvironment("dart.vm.product")) {
      return BuildMode.release;
    }
    var result = BuildMode.profile;

    // Little trick, since `assert` only runs on DEBUG mode.
    assert(
      () {
        result = BuildMode.debug;

        return true;
      }(),
      "",
    );

    return result;
  }

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

      case Device.other:
        return DeviceData(
          device: _platform,
          isPhysicalDevice: false,
          model: "Unknown",
        );
    }
  }
}

/// Get information about the [currentPlatform] and build mode.
@riverpod
DeviceRepository deviceUtils(DeviceUtilsRef ref) {
  final plugin = ref.watch(_pluginProvider);
  final device = ref.watch(currentPlatformProvider);

  return DeviceUtilsRepository(plugin: plugin, platform: device);
}

@riverpod
DeviceInfoPlugin _plugin(_PluginRef _) {
  return DeviceInfoPlugin();
}

/// Get the current device platform.
@riverpod
String _currentDevice(_CurrentDeviceRef _) => Platform.operatingSystem;

/// Get the current device platform, enum-ized.
@riverpod
Device currentPlatform(CurrentPlatformRef ref) {
  final currentDevice = ref.watch(_currentDeviceProvider);

  return switch (currentDevice) {
    "android" => Device.android,
    "ios" => Device.ios,
    _ => Device.other,
  };
}
