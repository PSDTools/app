/// The auth feature's user [Model].
library;

import "package:flutter/foundation.dart";
import "package:freezed_annotation/freezed_annotation.dart";

import "../../../utils/models.dart";

part "auth_model.freezed.dart";
part "auth_model.g.dart";

/// A pirate user.
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
  }) = _PirateUser;

  const PirateUser._();

  /// Convert a JSON [Map] into a new, immutable instance of [PirateUser].
  factory PirateUser.fromJson(Map<String, Object?> json) =>
      _$PirateUserFromJson(json);

  /// The user's hash.
  int get id => email.hashCode;
}

/// The type of account.
enum AccountType {
  /// A student account.
  student,

  /// A teacher account.
  teacher,

  /// A parent account.
  parent,

  /// A staff account.
  admin,

  /// A development account.
  dev,
}

/// A model for authentication.
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
