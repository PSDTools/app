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
    required int coins,
  }) = _CoinsModel;
}

/// Get coins data from data layer.
@riverpod
class Coins extends _$Coins {
  @override
  FutureOr<CoinsModel> build() async {
    return _fetchCoins();
  }

  Future<CoinsModel> _fetchCoins() async {
    final getCoins =
        ref.watch(coinsDataProvider.select((value) => value.coinsData));
    final coins = await getCoins();

    return CoinsModel(coins: coins);
  }

  /// Add coins to the database.
  Future<CoinsModel> _updateCoins(int num) async {
    final updateCoins =
        ref.watch(coinsDataProvider.select((value) => value.updateCoins));

    final currentCoins = await _fetchCoins();
    final coins = currentCoins.coins + num;

    await updateCoins(coins);

    return _fetchCoins();
  }

  /// Add coins to the database.
  Future<void> addCoins(int num) async {
    state = await AsyncValue.guard(() async {
      return _updateCoins(num);
    });
  }

  /// Remove coins from the database.
  Future<void> removeCoins(int num) async {
    state = await AsyncValue.guard(() async => _updateCoins(-num));
  }
}
