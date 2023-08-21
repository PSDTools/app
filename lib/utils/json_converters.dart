import "dart:typed_data";

import "package:flutter/material.dart";
import "package:json_annotation/json_annotation.dart";

/// Converts to and from [Uint8List] and [List]<[int]>.
///
/// With a good deal of thanks to:
/// - [Json_Serializable](https://pub.dev/packages/json_serializable),
/// - [Freezed](https://pub.dev/packages/freezed), and
/// - [StackOverflow](https://stackoverflow.com/a/49835615).
class Uint8ListConverter implements JsonConverter<Uint8List, List<int>> {
  /// Create a new instance of [Uint8ListConverter].
  const Uint8ListConverter();

  @override
  Uint8List fromJson(List<int> json) => Uint8List.fromList(json);

  @override
  List<int> toJson(Uint8List object) => object.toList();
}

/// Converts to and from [Color] and [String].
///
/// With lots and lots and lots and lots of thanks to many, including:
/// - [Json_Serializable](https://pub.dev/packages/json_serializable),
/// - [Freezed](https://pub.dev/packages/freezed), and
/// - [StackOverflow](https://stackoverflow.com/a/49835615).
class ColorConverter implements JsonConverter<Color, String> {
  /// Create a new instance of [ColorConverter].
  const ColorConverter();

  @override
  Color fromJson(String json) {
    final valueString = json.split("(0x")[1].split(")")[0];
    final value = int.parse(valueString, radix: 16);

    return Color(value);
  }

  @override
  String toJson(Color data) => data.toString();
}
