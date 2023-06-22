import "package:appwrite/appwrite.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../utils/api.dart";

part "client.g.dart";

@Riverpod(dependencies: [ApiInfo])
Client client(ClientRef ref) {
  final apiInfo = ref.watch(apiInfoProvider);

  return Client().setEndpoint(apiInfo.url).setProject(apiInfo.projectId);
}
