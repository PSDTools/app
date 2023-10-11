import "package:flutter/foundation.dart";
import "package:freezed_annotation/freezed_annotation.dart";

import "../../../utils/json_converters.dart";
import "../../../utils/models.dart";
import "account_type.dart";

part "pirate_user.freezed.dart";
part "pirate_user.g.dart";

/// Represent a pirate user.
@freezed
@immutable
sealed class PirateUser with _$PirateUser implements Model {
  /// Create a new, immutable instance of [PirateUser].
  const factory PirateUser({
    /// The user's name.
    required String name,

    /// The user's email.
    required String email,

    /// The type of the user's account.
    required AccountType accountType,

    /// The user's avatar.
    @Uint8ListConverter() required Uint8List avatar,
  }) = _PirateUser;

  const PirateUser._();

  /// Convert a JSON [Map] into a new, immutable instance of [PirateUser].
  factory PirateUser.fromJson(Map<String, Object?> json) =>
      _$PirateUserFromJson(json);

  /// The user's hash.
  int get id => getId(email);
}

/// Get an id from an email.
int getId(String email) => email.toLowerCase().hashCode;
