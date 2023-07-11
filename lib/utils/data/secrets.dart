/// The secret utilities.
library pirate_code.utils.data.secrets;

import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../dart_define.gen.dart";

part "secrets.g.dart";

/// Get the flavor of the application.
@riverpod
Flavor flavor(FlavorRef _) => DartDefine.flavor;

/// Get the Appwrite project ID.
@riverpod
String projectId(ProjectIdRef _) => DartDefine.projectId;

/// Get the Appwrite Api Endpoint
@riverpod
String apiUrl(ApiUrlRef ref) => DartDefine.apiEndpoint;

/// Get the Appwrite database ID.
@riverpod
String databaseId(DatabaseIdRef _) => DartDefine.databaseId;

/// Get the Appwrite collection ID.
@riverpod
String collectionId(CollectionIdRef _) => DartDefine.collectionId;

/// Get the Appwrite document ID.
@riverpod
String documentId(DocumentIdRef _) => DartDefine.documentId;
