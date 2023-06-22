import "package:riverpod_annotation/riverpod_annotation.dart";

import "../dart_define.gen.dart";

part "secrets.g.dart";

@Riverpod()
// Required for riverpod.
// ignore: avoid-unused-parameters
Flavor flavor(FlavorRef ref) {
  return DartDefine.flavor;
}

@Riverpod()
// Required for riverpod.
// ignore: avoid-unused-parameters
String projectId(ProjectIdRef ref) {
  return DartDefine.projectId;
}
