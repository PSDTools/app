import "package:device_info/device_info.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../domain/device_data.dart";

part "device.g.dart";

enum BuildMode { debug, profile, release }

abstract class DeviceRepository {
  BuildMode currentBuildMode();
  Future<DeviceData> deviceInfo(Device device);

  @Deprecated("Use deviceInfo instead.")
  Future<AndroidDeviceInfo> androidDeviceInfo();

  @Deprecated("Use deviceInfo instead.")
  Future<IosDeviceInfo> iosDeviceInfo();
}

class DeviceUtilsRepository implements DeviceRepository {
  const DeviceUtilsRepository({required DeviceInfoPlugin plugin})
      : _plugin = plugin;

  final DeviceInfoPlugin _plugin;

  @override
  BuildMode currentBuildMode() {
    if (const bool.fromEnvironment("dart.vm.product")) {
      return BuildMode.release;
    }
    var result = BuildMode.profile;

    // Little trick, since assert only runs on DEBUG mode.
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
  Future<DeviceData> deviceInfo(Device device) async {
    switch (device) {
      case Device.android:
        final androidInfo = await _plugin.androidInfo;
        final version = androidInfo.version;
        final info = DeviceData(
          device: Device.android,
          isPhysicalDevice: androidInfo.isPhysicalDevice,
          model: androidInfo.model,
          version: androidInfo.version,
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

  @override
  Future<AndroidDeviceInfo> androidDeviceInfo() {
    return _plugin.androidInfo;
  }

  @override
  Future<IosDeviceInfo> iosDeviceInfo() {
    return _plugin.iosInfo;
  }
}

@riverpod
DeviceRepository deviceUtils(DeviceUtilsRef ref) {
  final plugin = ref.watch(pluginProvider);

  return DeviceUtilsRepository(plugin: plugin);
}

@riverpod
DeviceInfoPlugin plugin(PluginRef _) {
  return DeviceInfoPlugin();
}
