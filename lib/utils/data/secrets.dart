/// The secret utilities.
library pirate_code.utils.data.secrets;

import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../dart_define.gen.dart";

part "secrets.g.dart";

/// Get the flavor of the application.
@riverpod
Flavor flavor(FlavorRef _) => Dartdefine.flavor;

/// Get the Appwrite project ID.
@riverpod
String projectId(ProjectIdRef _) => Dartdefine.projectId;

/// Get the Appwrite Api Endpoint
@riverpod
String apiUrl(ApiUrlRef ref) => Dartdefine.apiEndpoint;
