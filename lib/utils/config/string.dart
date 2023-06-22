import "package:riverpod_annotation/riverpod_annotation.dart";

part "string.g.dart";

@Riverpod()
class StringUtils extends _$StringUtils {
  String enumName(String enumToString) {
    final paths = enumToString.split(".");

    return paths.last;
  }

  @override
  StringUtils build() {
    return StringUtils();
  }
}
