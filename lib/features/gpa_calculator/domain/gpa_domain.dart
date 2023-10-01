/// This library contains the GPA calculator feature's business logic.
library;

import "package:riverpod_annotation/riverpod_annotation.dart";

import "gpa_model.dart";

part "gpa_domain.g.dart";

/// Get the state for the GPA calculator.
@riverpod
class Gpa extends _$Gpa {
  @override
  Course build(int hour) {
    return Course(hour: hour, grade: _defaultGrade);
  }

  final _defaultGrade = const LetterGrade.a();

  /// Update the course's grade.
  void updateGrade(LetterGrade? grade) {
    state = state.copyWith(grade: grade ?? _defaultGrade);
  }
}
