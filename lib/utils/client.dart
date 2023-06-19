import "package:appwrite/appwrite.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";
import "../utils/api.dart";

part "client.g.dart";

@riverpod
Client clientProvider() {
  return Client()
      .setEndpoint(ApiInfo.url)
      .setProject(ApiInfo.projectId)
      .setSelfSigned();
}
