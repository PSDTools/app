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
  })  : _url = url,
        _projectId = projectId;

  final String _url;
  final String _projectId;

  @override
  String get url => _url;

  @override
  String get projectId => _projectId;
}

/// The API information.
abstract class ApiRepository {
  /// The URL of the Appwrite API.
  String get url;

  /// The project ID for the Appwrite API.
  String get projectId;
}

/// Get the Appwrite API information.
@riverpod
ApiRepository apiInfo(ApiInfoRef ref) {
  final projectId = ref.watch(projectIdProvider);
  final apiUrl = ref.watch(apiUrlProvider);

  return Api(
    projectId: projectId,
    url: apiUrl,
  );
}

/// Get the Appwrite client.
@riverpod
Client client(ClientRef ref) {
  final apiInfo = ref.watch(apiInfoProvider);

  return Client().setEndpoint(apiInfo.url).setProject(apiInfo.projectId);
}
