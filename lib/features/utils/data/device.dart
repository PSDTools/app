import "dart:io";

import "package:device_info/device_info.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../domain/device_data.dart";

part "device.g.dart";


abstract class DeviceRepository {
  BuildMode currentBuildMode();
  Future<DeviceData> deviceInfo();
}

class DeviceUtilsRepository implements DeviceRepository {
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
          device: Device.android,
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
          device: Device.ios,
          isPhysicalDevice: iosInfo.isPhysicalDevice,
          model: iosInfo.model,
          name: iosInfo.name,
          systemName: iosInfo.systemName,
          systemVersion: iosInfo.systemVersion,
        );

        return info;

      case Device.other:
        return DeviceData(
          device: Device.other,
          isPhysicalDevice: false,
          model: "Unknown",
        );
    }
  }
}

@riverpod
DeviceRepository deviceUtils(DeviceUtilsRef ref) {
  final plugin = ref.watch(_pluginProvider);
  final device = ref.watch(currentDeviceProvider);

  return DeviceUtilsRepository(plugin: plugin, platform: device);
}

@riverpod
DeviceInfoPlugin _plugin(_PluginRef _) {
  return DeviceInfoPlugin();
}

@riverpod
Device currentDevice(CurrentDeviceRef _) {
  return switch (Platform.operatingSystem) {
    "android" => Device.android,
    "ios" => Device.ios,
    _ => Device.other,
  };
}
