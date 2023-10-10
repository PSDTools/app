/// This library contains the utilities feature's development banner's business logic.
library;

import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../utils/constants.dart";
import "banner_model.dart";

part "banner_domain.g.dart";

/// Get the banner's current state.
@riverpod
BannerConfig bannerConfig(BannerConfigRef ref) {
  return BannerConfig(
    name: buildMode.name,
    color: buildMode.color,
  );
}
