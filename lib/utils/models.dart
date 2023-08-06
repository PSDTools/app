/// A library containing the abstract model class.
library;

/// Abstract interface class all models implement.
// ignore: one_member_abstracts
abstract interface class Model {
  /// Convert this model into a JSON [Map].
  Map<String, Object?> toJson();
}
