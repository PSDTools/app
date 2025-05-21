import "package:flutter/foundation.dart";
import "package:freezed_annotation/freezed_annotation.dart";

import "../../../utils/json_converters.dart";
import "../../../utils/models.dart";
import "account_type.dart";

part "pirate_user_entity.freezed.dart";
part "pirate_user_entity.g.dart";

/// Represent a pirate user.
@freezed
@immutable
sealed class PirateUserEntity with _$PirateUserEntity implements Model {
  /// Create a new, immutable instance of [PirateUserEntity].
  const factory PirateUserEntity({
    /// The user's name.
    required String name,

    /// The user's email.
    required String email,

    /// The type of the user's account.
    required AccountType accountType,

    /// The user's avatar.
    @Uint8ListConverter() required Uint8List avatar,
  }) = _PirateUser;

  const PirateUserEntity._();

  /// Convert a JSON [Map] into a new, immutable instance of [PirateUserEntity].
  factory PirateUserEntity.fromJson(Map<String, Object?> json) =>
      _$PirateUserEntityFromJson(json);

  /// The user's hash.
  int get id => getId(email);

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty("id", id));
  }
}

/// Get an id from an email.
int getId(String email) => email.toLowerCase().hashCode;
