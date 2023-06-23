import "package:appwrite/appwrite.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "secrets.dart";

part "api.g.dart";

class ApiInfos implements Api {
  ApiInfos({
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

abstract class Api {
  String get url;
  String get projectId;
}

@Riverpod(dependencies: [projectId])
class ApiInfo extends _$ApiInfo {
  @override
  Api build() {
    final projectId = ref.watch(projectIdProvider);

    return ApiInfos(
      projectId: projectId,
      url: "https://cloud.appwrite.io/v1",
    );
  }
}

@Riverpod(dependencies: [ApiInfo])
Client client(ClientRef ref) {
  final apiInfo = ref.watch(apiInfoProvider);

  return Client().setEndpoint(apiInfo.url).setProject(apiInfo.projectId);
}
