import "package:riverpod_annotation/riverpod_annotation.dart";

import "../dart_define.gen.dart";

part "api.g.dart";

class ApiInfos implements Api {
  @override
  String get url => "https://cloud.appwrite.io/v1";

  @override
  String get projectId => DartDefine.projectId;
}

abstract class Api {
  String get url;
  String get projectId;
}

@riverpod
class ApiInfo extends _$ApiInfo {
  @override
  Api build() {
    return ApiInfos();
  }
}
