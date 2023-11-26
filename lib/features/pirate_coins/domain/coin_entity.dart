import "package:flutter/foundation.dart";
import "package:freezed_annotation/freezed_annotation.dart";

import "../../../utils/models.dart";

part "coin_entity.freezed.dart";
part "coin_entity.g.dart";

/// Represent a number.
@freezed
@immutable
sealed class CoinEntity with _$CoinEntity implements Model {
  /// Create a new, immutable instance of [CoinEntity].
  const factory CoinEntity({
    /// The number.
    required int coins,
  }) = _Coin;

  /// Convert a JSON [Map] into a new, immutable instance of [CoinEntity].
  factory CoinEntity.fromJson(Map<String, Object?> json) =>
      _$CoinEntityFromJson(json);
}
