/// The api utilities.
///
/// {@Category Server}
library;

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
    required bool isSelfSigned,
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

  /// Wether or not the Appwrite Server uses self-signed certificates.
  bool get isSelfSigned;
}

/// The Appwrite API information.
const ApiRepository apiInfo = Api(
  projectId: DartDefine.projectId,
  url: DartDefine.apiEndpoint,
  databaseId: DartDefine.databaseId,
  collectionId: DartDefine.collectionId,
  isSelfSigned: DartDefine.selfSigned,
);

/// Get the Appwrite client.
@Riverpod(keepAlive: true)
Client client(ClientRef ref) {
  return Client()
      .setEndpoint(apiInfo.url)
      .setProject(apiInfo.projectId)
      .setSelfSigned(status: apiInfo.isSelfSigned);
}

/// Get the Appwrite session for the current account.
@Riverpod(keepAlive: true)
Account accounts(AccountsRef ref) {
  final client = ref.watch(clientProvider);

  return Account(client);
}

/// Get the Appwrite databases.
@riverpod
Databases databases(DatabasesRef ref) {
  final client = ref.watch(clientProvider);

  return Databases(client);
}

/// Get the Appwrite avatars.
@Riverpod(keepAlive: true)
Avatars avatars(AvatarsRef ref) {
  final client = ref.watch(clientProvider);

  return Avatars(client);
}
