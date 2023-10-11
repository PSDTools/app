/// This library contains the authentication feature's user [Model].
library;

import "package:flutter/foundation.dart";
import "package:freezed_annotation/freezed_annotation.dart";

import "../../../utils/models.dart";
import "pirate_user.dart";

part "pirate_auth_model.freezed.dart";
part "pirate_auth_model.g.dart";

/// Represent the [Model] for authentication.
@freezed
@immutable
sealed class PirateAuthModel with _$PirateAuthModel implements Model {
  /// Create a new, immutable instance of [PirateAuthModel].
  const factory PirateAuthModel({
    /// The user.
    PirateUser? user,
  }) = _PirateAuthModel;

  /// Convert a JSON [Map] into a new, immutable instance of [PirateAuthModel].
  factory PirateAuthModel.fromJson(Map<String, Object?> json) =>
      _$PirateAuthModelFromJson(json);
}
