import "package:flutter/foundation.dart";
import "package:freezed_annotation/freezed_annotation.dart";

import "../../../utils/models.dart";

part "coin.freezed.dart";
part "coin.g.dart";

/// Represent a number.
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
