/// The pirate_coins feature's domain.
library pirate_code.features.pirate_coins.domain;

import "package:flutter/foundation.dart";
import "package:freezed_annotation/freezed_annotation.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../data/coins_data.dart";

part "coins_domain.freezed.dart";
part "coins_domain.g.dart";

/// A number.
@freezed
@immutable
sealed class CoinsModel with _$CoinsModel {
  /// Create a new, immutable instance of [CoinsModel].
  const factory CoinsModel({
    /// The number.
    required AsyncValue<int> coins,
  }) = _CoinsModel;
}

/// Get coins data from data layer.
@riverpod
class Coins extends _$Coins {
  @override
  CoinsModel build() {
    final coins = ref.watch(coinsDataProvider);
    return CoinsModel(coins: coins);
  }
}
