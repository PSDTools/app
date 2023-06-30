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
        padding: const EdgeInsets.all(150),
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
    final flavorConfig = ref.watch(flavorConfigProvider);
    final currentBuildMode = ref.watch(buildModeProvider);
    final deviceInfo = ref.watch(deviceInfoProvider);

    return deviceInfo.when(
      data: (device) {
        final stringUtils = ref.watch(stringUtilsProvider);
        final buildMode = stringUtils.enumName(currentBuildMode.toString());

        final androidView = [
          _BuildTile("Manufacturer:", device.manufacturer),
          _BuildTile("Android version:", device.release),
          _BuildTile("Android SDK:", "${device.sdkInt}"),
        ];

        final iosView = [
          _BuildTile("Device:", device.name),
          _BuildTile("System name:", device.systemName),
          _BuildTile("System version:", device.systemVersion),
        ];

        final platformView = switch (device.device) {
          Device.android => androidView,
          Device.ios => iosView,
          Device.other => const [
              _BuildTile(
                "Oops.",
                "Chances are, you're neither on Android nor iOS.",
              ),
            ],
        };

        return ListView(
          children: [
            _BuildTile("Flavor:", flavorConfig.name),
            _BuildTile("Build mode:", buildMode),
            _BuildTile("Physical device?:", "${device.isPhysicalDevice}"),
            _BuildTile("Model:", device.model),
            ...platformView,
          ],
        );
      },
      error: (err, stack) {
        final message = "An issue occurred: $err, $stack.";

        return Text(message);
      },
      loading: () => const Center(
        child: Column(
          children: [
            CircularProgressIndicator(),
            Text("Loading..."),
          ],
        ),
      ),
    );
  }
}
