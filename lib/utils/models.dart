/// This library contains the [Model] class.
library;

/// Abstract interface class all _serializable_ models implement.
abstract interface class Model {
  /// Convert this model into a JSON [Map].
  Map<String, Object?> toJson();
}
