// ignore_for_file: avoid_classes_with_only_static_members

class StringUtils {
  static String enumName(String enumToString) {
    final paths = enumToString.split(".");

    return paths.last;
  }
}
