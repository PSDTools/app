/// The utils feature's device presentation.
library pirate_code.features.utils.presentation.device;

import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../l10n/l10n.dart";
import "../../../utils/constants.dart";
import "../domain/device_data.dart";

/// A dialog that displays information about the device.
class DeviceInfoDialog extends StatelessWidget {
  /// Create a new instance of [DeviceInfoDialog].
  const DeviceInfoDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      title: Container(
        padding: const EdgeInsets.all(15),
        color: buildMode.color,
        child: Text(
          "Device Info",
          style: theme.textTheme.titleMedium,
        ),
      ),
      titlePadding: EdgeInsets.zero,
      content: const _GetContent(),
      contentPadding: const EdgeInsets.only(bottom: 10),
    );
  }
}

class _BuildTile extends StatelessWidget {
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
  Widget build(BuildContext context) {
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
    final l10n = context.l10n;

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
      case _:
        return Text(l10n.error("Unknown state"));
    }
  }
}

class _View extends StatelessWidget {
  const _View({
    required this.value,
    // Temporary ignore, see <dart-lang/sdk#49025>.
    // ignore: unused_element
    super.key,
  });

  final DeviceData value;

  @override
  Widget build(BuildContext context) {
    final platformView = switch (value.device) {
      Device.android => androidView(value),
      Device.ios => iosView(value),
      Device.other => otherView(value),
    };

    return ListView(
      children: [
        _BuildTile("Build mode:", buildMode.name),
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
