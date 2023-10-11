/// This library contains the utilities feature's development banner.
library;

import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../../../utils/constants.dart";
import "../../application/banner_service.dart";
import "device_info_dialog.dart";

/// A widget that displays a banner at the top of the screen.
class DeviceBanner extends ConsumerWidget {
  /// Create a new instance of [DeviceBanner].
  const DeviceBanner({
    required this.child,
    super.key,
  });

  /// The content under the banner.
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (buildMode.isRelease) return child;

    final banner = ref.watch(bannerConfigProvider);
    final direction = Directionality.of(context);

    return Material(
      child: InkWell(
        onLongPress: () async => showDialog<void>(
          context: context,
          builder: (BuildContext context) => const DeviceInfoDialog(),
        ),
        // This banner widget is excluded from semantics because it's only meant to be used in development, and,
        // anyway, it's redundant with the information already exposed in the banner.
        excludeFromSemantics: true,
        child: Banner(
          message: banner.name,
          location: BannerLocation.topStart,
          color: banner.color,
          textDirection: direction,
          layoutDirection: direction,
          child: child,
        ),
      ),
    );
  }
}
