/// This library contains the utilities feature's device data fetchers.
library;

import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:os_detect/os_detect.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

part "device_repository.g.dart";

/// Get the current device platform as an enum.
@Riverpod(keepAlive: true)
Device currentPlatform(Ref ref) {
  return switch (operatingSystem) {
    "android" => Device.android,
    "ios" => Device.ios,
    String() => Device.other,
  };
}

/// An enum containing the supported devices.
enum Device {
  /// The Android platform.
  android,

  /// The iOS platform.
  ios,

  /// Browsers.
  web,

  /// Linux/UNIX/POSIX platforms.
  linux,

  /// The OS X, etc. platform.
  macOS,

  /// The windows platform.
  windows,

  /// Other platforms, like Fuchsia.
  other,
}
