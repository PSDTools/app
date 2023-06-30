/// The api utilities.
library pirate_code.utils.data.api;

import "package:appwrite/appwrite.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "secrets.dart";

part "api.g.dart";

/// Get API information via passed in environment variables.
class Api implements ApiRepository {
  /// Create a new instance of [Api].
  Api({
    required String projectId,
    required String url,
    required String databaseId,
    required String collectionId,
    required String documentId,
  })  : _url = url,
        _projectId = projectId,
        _databaseId = databaseId,
        _collectionId = collectionId,
        _documentId = documentId;

  final String _url;
  final String _projectId;
  final String _databaseId;
  final String _collectionId;
  final String _documentId;

  @override
  String get url => _url;

  @override
  String get projectId => _projectId;

  @override
  String get databaseId => _databaseId;

  @override
  String get collectionId => _collectionId;

  @override
  String get documentId => _documentId;
}

/// The API information.
abstract class ApiRepository {
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
      .setEndpoint(apiInfo.url)
      .setProject(apiInfo.projectId)
      .setSelfSigned();
}
