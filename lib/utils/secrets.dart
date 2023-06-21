import "package:riverpod_annotation/riverpod_annotation.dart";

import "../dart_define.gen.dart";

part "secrets.g.dart";

@riverpod
Flavor flavor() {
  return DartDefine.flavor;
}
