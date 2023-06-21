import "package:riverpod_annotation/riverpod_annotation.dart";

import "../dart_define.gen.dart";

part "secrets.g.dart";

@riverpod
// Required for riverpod.
// ignore: avoid-unused-parameters
Flavor flavor(FlavorRef ref) {
  return DartDefine.flavor;
}

@riverpod
// Required for riverpod.
// ignore: avoid-unused-parameters
String projectId(ProjectIdRef ref) {
  return DartDefine.projectId;
}
