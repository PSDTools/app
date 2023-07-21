/// The api utilities.
library pirate_code.utils.data.api;

import "package:appwrite/appwrite.dart";
import "package:flutter/foundation.dart";
import "package:freezed_annotation/freezed_annotation.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "secrets.dart";

part "api.freezed.dart";
part "api.g.dart";

/// Get API information via passed in environment variables.
@freezed
@immutable
sealed class Api with _$Api implements ApiRepository {
  /// Create a new, immutable instance of [Api].
  const factory Api({
    required String projectId,
    required String url,
    required String databaseId,
    required String collectionId,
    required String documentId,
  }) = _Api;
}

/// The API information.
abstract interface class ApiRepository {
  /// The URL of the Appwrite API.
  String get url;

  /// The project ID for the Appwrite API.
  String get projectId;

  /// The database ID for the Appwrite API.
  String get databaseId;

  /// The collection ID for the Appwrite API.
  String get collectionId;

  /// The document ID for the Appwrite API.
  String get documentId;
}

/// Get the Appwrite API information.
@riverpod
ApiRepository apiInfo(ApiInfoRef ref) {
  final projectId = ref.watch(projectIdProvider);
  final apiUrl = ref.watch(apiUrlProvider);
  final databaseId = ref.watch(databaseIdProvider);
  final collectionId = ref.watch(collectionIdProvider);
  final documentId = ref.watch(documentIdProvider);

  return Api(
    projectId: projectId,
    url: apiUrl,
    databaseId: databaseId,
    collectionId: collectionId,
    documentId: documentId,
  );
}

/// Get the Appwrite client.
@riverpod
Client client(ClientRef ref) {
  final apiInfo = ref.watch(apiInfoProvider);

  return Client()
    ..setEndpoint(apiInfo.url)
    ..setProject(apiInfo.projectId);
}
