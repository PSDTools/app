/// This library contains the Pirate Coins feature's representations of coins as [Model]s.
library;

import "package:flutter/foundation.dart";
import "package:freezed_annotation/freezed_annotation.dart";

import "../../../utils/models.dart";
import "coin_entity.dart";

part "coins_model.freezed.dart";
part "coins_model.g.dart";

/// Represent the [Model] for coins.
@freezed
@immutable
sealed class CoinsModel with _$CoinsModel implements Model {
  /// Create a new, immutable instance of [CoinsModel].
  const factory CoinsModel({
    /// The coins.
    required CoinEntity coins,
  }) = _CoinsModel;

  /// Convert a JSON [Map] into a new, immutable instance of [CoinsModel].
  factory CoinsModel.fromJson(Map<String, Object?> json) =>
      _$CoinsModelFromJson(json);
}

/// Represent the [Stage]s of the coins page.
@freezed
@immutable
sealed class Stage with _$Stage {
  /// Represent the initial stage of the coins page.
  const factory Stage.pickStudent() = PickStudentStage;

  /// Represent the stage of the coins page where the teacher can view and add to a student's [CoinEntity]s.
  const factory Stage.viewCoins({required int student}) = ViewCoinsStage;
}
