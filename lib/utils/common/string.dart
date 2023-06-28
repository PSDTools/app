/// The string utilities.
library pirate_code.utils.string;

import "package:riverpod_annotation/riverpod_annotation.dart";

part "string.g.dart";

/// Utilities for manipulating strings.
@riverpod
class StringUtils extends _$StringUtils {
  /// Get an enum member's name from its enum's `.toString()` method.
  String enumName(String enumToString) {
    final paths = enumToString.split(".");

    return paths.last;
  }

  @override
  StringUtils build() {
    return StringUtils();
  }
}
