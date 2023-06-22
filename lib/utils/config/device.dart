// ignore_for_file: avoid_classes_with_only_static_members

import "package:device_info/device_info.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

part "device.g.dart";

enum BuildMode { debug, profile, release }

class DeviceUtils {
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

  Future<AndroidDeviceInfo> androidDeviceInfo() {
    final plugin = DeviceInfoPlugin();

    return plugin.androidInfo;
  }

  Future<IosDeviceInfo> iosDeviceInfo() {
    final plugin = DeviceInfoPlugin();

    return plugin.iosInfo;
  }
}

@riverpod
// Required for riverpod.
// ignore: avoid-unused-parameters
DeviceUtils deviceUtils(DeviceUtilsRef ref) {
  return DeviceUtils();
}
