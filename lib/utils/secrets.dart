import "package:riverpod_annotation/riverpod_annotation.dart";

import "../dart_define.gen.dart";

part "secrets.g.dart";

@riverpod
Flavor flavor(FlavorRef _) {
  return Dartdefine.flavor;
}

@riverpod
String projectId(ProjectIdRef _) {
  return Dartdefine.projectId;
}
