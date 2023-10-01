/// This library contains the utilities feature's development banner's business logic.
library;

import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../utils/constants.dart";
import "banner_model.dart";

part "banner_domain.g.dart";

/// Get the default fallback banner.
@riverpod
BannerConfig defaultBanner(DefaultBannerRef ref) {
  return BannerConfig(
    bannerName: buildMode.name,
    bannerColor: buildMode.color,
  );
}
