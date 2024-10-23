/// This library contains utilities for the Appwrite API.
///
/// {@category Server}
library;

// cSpell:ignore realtime

import "package:appwrite/appwrite.dart";
import "package:flutter/foundation.dart";
import "package:freezed_annotation/freezed_annotation.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../env/env.dart";

part "api.freezed.dart";
part "api.g.dart";

/// Represent the Appwrite API information.
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

/// A repository for API information.
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

/// The Appwrite API information, gotten via passed in environment variables.
const ApiRepository apiInfo = Api(
  projectId: Env.projectId,
  url: Env.apiEndpoint,
  databaseId: Env.databaseId,
  collectionId: Env.collectionId,
  isSelfSigned: Env.selfSigned,
);

/// Get the Appwrite client.
@Riverpod(keepAlive: true)
Client client(Ref ref) {
  return Client()
      .setEndpoint(apiInfo.url)
      .setProject(apiInfo.projectId)
      .setSelfSigned(status: apiInfo.isSelfSigned);
}

/// Get the Appwrite session for the current account.
@Riverpod(keepAlive: true)
Account accounts(Ref ref) {
  final client = ref.watch(clientProvider);

  return Account(client);
}

/// Get the Appwrite databases.
@Riverpod(keepAlive: true)
Databases databases(Ref ref) {
  final client = ref.watch(clientProvider);

  return Databases(client);
}

/// Get the Appwrite avatars.
@Riverpod(keepAlive: true)
Avatars avatars(Ref ref) {
  final client = ref.watch(clientProvider);

  return Avatars(client);
}

/// Get the Appwrite realtime subscriptions.
@Riverpod(keepAlive: true)
Realtime realtime(Ref ref) {
  final client = ref.watch(clientProvider);

  return Realtime(client);
}
