/// This library contains the GPA calculator feature's business logic.
library;

import "package:riverpod_annotation/riverpod_annotation.dart";

import "../domain/gpa_model.dart";

part "gpa_service.g.dart";

/// Get the state for the GPA calculator.
@riverpod
base class GpaService extends _$GpaService {
  @override
  Course build(int hour) {
    return Course(hour: hour, grade: defaultLetterGrade);
  }

  /// Update the course's grade.
  void updateGrade(LetterGrade grade) {
    state = state.copyWith(grade: grade);
  }
}

/// The default grade for a course.
const defaultLetterGrade = LetterGrade.a();
