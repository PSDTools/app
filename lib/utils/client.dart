import "package:appwrite/appwrite.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../utils/api.dart";

part "client.g.dart";

@riverpod
Client client(ClientRef ref) {
  final apiInfo = ref.watch(apiInfoProvider);

  return Client()
      .setEndpoint(apiInfo.url)
      .setProject(apiInfo.projectId)
      .setSelfSigned();
}
