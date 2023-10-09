/// This library contains the utilities feature's development banner.
library;

import "dart:async";

import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../../../utils/constants.dart";
import "../../domain/banner_domain.dart";
import "../../domain/banner_model.dart";
import "device_info_dialog.dart";

/// A widget that displays a banner at the top of the screen.
class DeviceBanner extends ConsumerWidget {
  /// Create a new instance of [DeviceBanner].
  const DeviceBanner({
    required this.child,
    this.bannerConfig,
    super.key,
  });

  /// The configuration for the banner.
  final BannerConfig? bannerConfig;

  /// The content under the banner.
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final defaultBanner = ref.watch(defaultBannerProvider);

    if (buildMode.isRelease) return child;

    return Stack(
      children: [
        child,
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
    Future<void> onLongPress() async {
      await showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return const DeviceInfoDialog();
        },
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
