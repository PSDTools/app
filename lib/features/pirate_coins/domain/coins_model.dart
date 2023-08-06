/// A library to represent the coins [Model].
library;

import "package:flutter/foundation.dart";
import "package:freezed_annotation/freezed_annotation.dart";

import "../../../utils/models.dart";

part "coins_model.freezed.dart";
part "coins_model.g.dart";

/// A model for coins.
@freezed
@immutable
sealed class CoinsModel with _$CoinsModel implements Model {
  /// Create a new, immutable instance of [CoinsModel].
  const factory CoinsModel({
    /// The coins.
    required Coin coins,
  }) = _CoinsModel;

  /// Convert a JSON [Map] into a new, immutable instance of [CoinsModel].
  factory CoinsModel.fromJson(Map<String, Object?> json) =>
      _$CoinsModelFromJson(json);
}

/// A number.
@freezed
@immutable
sealed class Coin with _$Coin implements Model {
  /// Create a new, immutable instance of [Coin].
  const factory Coin({
    /// The number.
    required int coins,
  }) = _Coin;

  /// Convert a JSON [Map] into a new, immutable instance of [Coin].
  factory Coin.fromJson(Map<String, Object?> json) => _$CoinFromJson(json);
}
