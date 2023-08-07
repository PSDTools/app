/// The controller for the auth page, part of the presentation layer.
library;

import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../domain/coins_domain.dart";
import "../../domain/coins_model.dart";

part "pirate_coins_page_controller.g.dart";

/// Like [CoinsModel], but just for [PirateCoinsPageController].
typedef PirateCoins = (
  AsyncValue<CoinsModel>,
  Future<void> Function(int),
  Future<void> Function(int),
);

/// The controller for the auth page.
@riverpod
class PirateCoinsPageController extends _$PirateCoinsPageController {
  @override
  PirateCoins build() {
    final model = ref.watch(
      coinsProvider.select(
        (value) => value,
      ),
    );
    final dataNotifier = ref.watch(
      coinsProvider.notifier.select(
        (value) => (
          value.addCoins,
          value.removeCoins,
        ),
      ),
    );
    final data = (model, dataNotifier.$1, dataNotifier.$2);

    return data;
  }
}
