/// The secret utilities.
library pirate_code.utils.data.secrets;

import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../dart_define.gen.dart";

part "secrets.g.dart";

/// Get the flavor of the application.
@riverpod
Flavor flavor(FlavorRef _) {
  return Dartdefine.flavor;
}

/// Get the AppWrite project ID.
@riverpod
String projectId(ProjectIdRef _) {
  return Dartdefine.projectId;
}
