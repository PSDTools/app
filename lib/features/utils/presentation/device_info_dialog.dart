import "dart:io";

import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../utils/string.dart";
import "../data/device.dart";
import "../data/flavor.dart";
import "../domain/device_data.dart";

class DeviceInfoDialog extends ConsumerWidget {
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
    this.value,
  );

  final String text;
  final String? value;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return value != null
        ? Padding(
            padding: const EdgeInsets.all(5),
            child: Row(
              children: [
                Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(value ?? ""),
              ],
            ),
          )
        : const Text("");
  }
}

class _GetContent extends ConsumerWidget {
  const _GetContent();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (Platform.isAndroid) {
      return const _PlatformContent(Device.android);
    } else if (Platform.isIOS) {
      return const _PlatformContent(Device.ios);
    } else {
      return const _PlatformContent(Device.other);
    }
  }
}

class _PlatformContent extends ConsumerWidget {
  const _PlatformContent(Device platform) : _platform = platform;

  final Device _platform;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final flavorConfig = ref.watch(flavorConfigProvider);
    final deviceUtils = ref.watch(deviceUtilsProvider);

    return FutureBuilder(
      // Actually, this takes a future.
      // ignore: discarded_futures
      future: deviceUtils.deviceInfo(_platform),
      builder: (context, AsyncSnapshot<DeviceData?> snapshot) {
        if (!snapshot.hasData) return Container();

        final stringUtils = ref.watch(stringUtilsProvider);
        final buildMode =
            stringUtils.enumName(deviceUtils.currentBuildMode().toString());
        final device = snapshot.data;

        if (device?.isOther ?? true) {
          return const Text("You're neither on Android nor iOS");
        }

        return ListView(
          children: [
            _BuildTile("Flavor:", flavorConfig.name),
            _BuildTile("Build mode:", buildMode),
            _BuildTile("Physical device?:", "${device?.isPhysicalDevice}"),
            _BuildTile("Device:", device?.name),
            _BuildTile("Manufacturer:", device?.manufacturer),
            _BuildTile("Model:", device?.model),
            _BuildTile("System name:", device?.systemName),
            _BuildTile("System version:", device?.systemVersion),
            _BuildTile("Android version:", device?.release),
            _BuildTile("Android SDK:", "${device?.sdkInt}"),
          ],
        );
      },
    );
  }
}
