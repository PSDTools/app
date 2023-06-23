import "package:device_info/device_info.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

part "device.g.dart";

enum BuildMode { debug, profile, release }

abstract class DeviceRepository {
  BuildMode currentBuildMode();
  Future<AndroidDeviceInfo> androidDeviceInfo();
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
