/// The utils feature's flavor presentation.
library pirate_code.features.utils.presentation.flavor;

import "dart:async";

import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../data/banner.dart";
import "../data/flavor.dart";
import "device_info_dialog.dart";

/// A widget that displays a banner at the top of the screen.
class FlavorBanner extends ConsumerWidget {
  /// Create a new instance of [FlavorBanner].
  const FlavorBanner({
    required this.child,
    this.bannerConfig,
    super.key,
  });

  /// The configuration for the banner.
  final BannerConfig? bannerConfig;

  /// The content under the banner.
  final Widget? child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final flavorConfig = ref.watch(flavorConfigProvider);
    final defaultBanner = ref.watch(defaultBannerProvider);

    if (flavorConfig.isProduction) return child ?? const Text("");

    return Stack(
      children: [
        child ?? const Text(""),
        _BuildBanner(
          bannerConfig: bannerConfig ?? defaultBanner,
        ),
      ],
    );
  }
}

class _BuildBanner extends StatelessWidget {
  const _BuildBanner({
    required this.bannerConfig,
    // Temporary ignore, see <dart-lang/sdk#49025>.
    // ignore: unused_element
    super.key,
  });

  final BannerConfig bannerConfig;

  @override
  Widget build(BuildContext context) {
    void onLongPress() {
      return unawaited(
        showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return const DeviceInfoDialog();
          },
        ),
      );
    }

    final direction = Directionality.of(context);
    const size = 50.0;

    return GestureDetector(
      onLongPress: onLongPress,
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
