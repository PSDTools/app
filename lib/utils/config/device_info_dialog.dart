import "dart:io";

import "package:device_info/device_info.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "device.dart";
import "flavor.dart";
import "string.dart";

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
  const _GetContent();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (Platform.isAndroid) {
      return const _AndroidContent();
    }

    if (Platform.isIOS) {
      return const _IOSContent();
    }

    return const Text("You're not on Android neither iOS");
  }
}

class _IOSContent extends ConsumerWidget {
  const _IOSContent();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final flavorConfig = ref.watch(flavorConfigProvider);
    final deviceUtils = ref.watch(deviceUtilsProvider);

    return FutureBuilder(
      // Actually, this takes a future.
      // ignore: discarded_futures
      future: deviceUtils.iosDeviceInfo(),
      builder: (context, AsyncSnapshot<IosDeviceInfo> snapshot) {
        if (!snapshot.hasData) return Container();

        final device = snapshot.data;

        final buildMode =
            StringUtils.enumName(deviceUtils.currentBuildMode().toString());

        return ListView(
          children: [
            _BuildTile("Flavor:", flavorConfig.name),
            _BuildTile("Build mode:", buildMode),
            _BuildTile("Physical device?:", "${device?.isPhysicalDevice}"),
            _BuildTile("Device:", device?.name),
            _BuildTile("Model:", device?.model),
            _BuildTile("System name:", device?.systemName),
            _BuildTile("System version:", device?.systemVersion),
          ],
        );
      },
    );
  }
}

class _AndroidContent extends ConsumerWidget {
  const _AndroidContent();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final flavorConfig = ref.watch(flavorConfigProvider);
    final deviceUtils = ref.watch(deviceUtilsProvider);

    return FutureBuilder(
      // Actually, this takes a future.
      // ignore: discarded_futures
      future: deviceUtils.androidDeviceInfo(),
      builder: (context, AsyncSnapshot<AndroidDeviceInfo> snapshot) {
        if (!snapshot.hasData) return Container();

        final device = snapshot.data;
        final version = device?.version;

        final buildMode =
            StringUtils.enumName(deviceUtils.currentBuildMode().toString());

        return ListView(
          children: [
            _BuildTile("Flavor:", flavorConfig.name),
            _BuildTile("Build mode:", buildMode),
            _BuildTile("Physical device?:", "${device?.isPhysicalDevice}"),
            _BuildTile("Manufacturer:", device?.manufacturer),
            _BuildTile("Model:", device?.model),
            _BuildTile("Android version:", version?.release),
            _BuildTile("Android SDK:", "${version?.sdkInt}"),
          ],
        );
      },
    );
  }
}
