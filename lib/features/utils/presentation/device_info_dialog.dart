/// The utils feature's device presentation.
library pirate_code.features.utils.presentation.device;

import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../utils/common/string.dart";
import "../domain/device_data.dart";
import "../domain/flavor.dart";

/// A dialog that displays information about the device.
class DeviceInfoDialog extends ConsumerWidget {
  /// Create a new instance of [DeviceInfoDialog].
  const DeviceInfoDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final flavorConfig = ref.watch(flavorConfigProvider);

    return AlertDialog(
      title: Container(
        padding: const EdgeInsets.all(15),
        color: flavorConfig.color,
        child: const Text("Device Info", style: TextStyle(color: Colors.white)),
      ),
      titlePadding: EdgeInsets.zero,
      content: const _GetContent(),
      contentPadding: const EdgeInsets.only(bottom: 10),
    );
  }
}

class _BuildTile extends ConsumerWidget {
  const _BuildTile(
    this.text,
    this.value, {
    // Temporary ignore, see <dart-lang/sdk#49025>.
    // ignore: unused_element
    super.key,
  });

  final String text;
  final String? value;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Row(
        children: [
          Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value ?? ""),
        ],
      ),
    );
  }
}

class _GetContent extends ConsumerWidget {
  const _GetContent({
    // Temporary ignore, see <dart-lang/sdk#49025>.
    // ignore: unused_element
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceInfo = ref.watch(deviceInfoProvider);

    switch (deviceInfo) {
      case AsyncData(:final value):
        return _View(value: value);
      case AsyncLoading():
        return const Center(
          child: Column(
            children: [
              CircularProgressIndicator(),
              Text("Loading..."),
            ],
          ),
        );
      case AsyncError(:final error, :final stackTrace):
        final message = "An issue occurred: $error, $stackTrace.";

        return Text(message);
      default:
        return const Text("Unknown");
    }
  }
}

class _View extends ConsumerWidget {
  const _View({
    required this.value,
    // Temporary ignore, see <dart-lang/sdk#49025>.
    // ignore: unused_element
    super.key,
  });

  final DeviceData value;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final flavorConfig = ref.watch(flavorConfigProvider);
    final currentBuildMode = ref.watch(buildModeProvider);
    final stringUtils = ref.watch(stringUtilsProvider);
    final buildMode = stringUtils.enumName(currentBuildMode.toString());

    final platformView = switch (value.device) {
      Device.android => androidView(value),
      Device.ios => iosView(value),
      Device.other => otherView(value),
    };

    return ListView(
      children: [
        _BuildTile("Flavor:", flavorConfig.name),
        _BuildTile("Build mode:", buildMode),
        _BuildTile("Physical device?:", "${value.isPhysicalDevice}"),
        _BuildTile("Model:", value.model),
        ...platformView,
      ],
    );
  }

  List<_BuildTile> iosView(DeviceData value) {
    final iosView = [
      _BuildTile("Device:", value.name),
      _BuildTile("System name:", value.systemName),
      _BuildTile("System version:", value.systemVersion),
    ];

    return iosView;
  }

  List<_BuildTile> androidView(DeviceData value) {
    final androidView = [
      _BuildTile("Manufacturer:", value.manufacturer),
      _BuildTile("Android version:", value.release),
      _BuildTile("Android SDK:", "${value.sdkInt}"),
    ];

    return androidView;
  }

  List<_BuildTile> otherView(DeviceData value) {
    const otherView = [
      _BuildTile(
        "Oops.",
        "Chances are, you're neither on Android nor iOS.",
      ),
    ];

    return otherView;
  }
}
