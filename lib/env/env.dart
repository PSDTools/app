import "package:envied/envied.dart";

part "env.g.dart";

/// Environment variables.
@Envied(useConstantCase: true)
abstract class Env {
  /// Appwrite project ID
  @EnviedField(defaultValue: "pirate-code")
  static const String projectId = _Env.projectId;

  /// Appwrite API endpoint
  @EnviedField(defaultValue: "http://localhost:80/v1")
  static const String apiEndpoint = _Env.apiEndpoint;

  /// Appwrite database ID
  @EnviedField(defaultValue: "pirate-coins")
  static const String databaseId = _Env.databaseId;

  /// Appwrite collection ID
  @EnviedField(defaultValue: "coins")
  static const String collectionId = _Env.collectionId;

  /// If the Appwrite Server uses self-signed certificates.
  @EnviedField(defaultValue: false)
  static const bool selfSigned = _Env.selfSigned;
}
