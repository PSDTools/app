/// The controller for the auth page, part of the presentation layer.
library;

import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../domain/coins_domain.dart";
import "../../domain/coins_model.dart";

part "stats_page_controller.g.dart";

/// Like [CoinsModel], but just for [StatsPageController].
typedef Stats = AsyncValue<CoinsModel>;

/// The controller for the auth page.
@riverpod
class StatsPageController extends _$StatsPageController {
  @override
  Stats build() {
    final model = ref.watch(
      coinsProvider.select(
        (value) => value,
      ),
    );
    final data = model;

    return data;
  }
}
