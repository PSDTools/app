/// The api utilities.
library pirate_code.utils.api;

import "package:appwrite/appwrite.dart";
import "package:flutter/foundation.dart";
import "package:freezed_annotation/freezed_annotation.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "constants.dart";

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

/// The Appwrite API information.
const ApiRepository apiInfo = Api(
  projectId: DartDefine.projectId,
  url: DartDefine.apiEndpoint,
  databaseId: DartDefine.databaseId,
  collectionId: DartDefine.collectionId,
  documentId: DartDefine.documentId,
);

/// Get the Appwrite client.
@riverpod
Client client(ClientRef ref) {
  return Client()
    ..setEndpoint(apiInfo.url)
    ..setProject(apiInfo.projectId);
}

/// Get the Appwrite session for the current account.
@riverpod
Account accounts(AccountsRef ref) {
  final client = ref.read(clientProvider);

  return Account(client);
}

/// Get the Appwrite databases.
@riverpod
Databases databases(DatabasesRef ref) {
  final client = ref.read(clientProvider);

  return Databases(client);
}
