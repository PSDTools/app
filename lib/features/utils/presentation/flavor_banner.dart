import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../data/flavor.dart";
import "device_info_dialog.dart";

class FlavorBanner extends ConsumerWidget {
  const FlavorBanner({
    required this.child,
    this.bannerConfig,
    super.key,
  });

  final BannerConfig? bannerConfig;
  final Widget? child;

  BannerConfig _getDefaultBanner({required FlavorConfig flavorConfig}) {
    return BannerConfig(
      bannerName: flavorConfig.name,
      bannerColor: flavorConfig.color,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final flavorConfig = ref.watch(flavorConfigProvider);

    if (flavorConfig.isProduction) return child ?? const Text("");

    return Stack(
      children: [
        child ?? const Text(""),
        _BuildBanner(
          bannerConfig:
              bannerConfig ?? _getDefaultBanner(flavorConfig: flavorConfig),
        ),
      ],
    );
  }
}

class _BuildBanner extends StatelessWidget {
  const _BuildBanner({
    required this.bannerConfig,
  });

  final BannerConfig bannerConfig;

  @override
  Widget build(BuildContext context) {
    Future<void> onLongPress() async {
      return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return const DeviceInfoDialog();
        },
      );
    }

    final direction = Directionality.of(context);
    const size = 50.0;

    return GestureDetector(
      onLongPress: () => unawaited(onLongPress()),
      behavior: HitTestBehavior.translucent,
      child: SizedBox(
        width: size,
        height: size,
        child: CustomPaint(
          painter: BannerPainter(
            message: bannerConfig.bannerName,
            textDirection: direction,
            location: BannerLocation.topStart,
            layoutDirection: direction,
            color: bannerConfig.bannerColor,
          ),
        ),
      ),
    );
  }
}

class BannerConfig {
  BannerConfig({
    required this.bannerName,
    required this.bannerColor,
  });

  final String bannerName;
  final Color bannerColor;
}
