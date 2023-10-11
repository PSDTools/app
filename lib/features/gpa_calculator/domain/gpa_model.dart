/// This library contains the GPA calculator feature's models.
library;

import "package:flutter/foundation.dart";
import "package:freezed_annotation/freezed_annotation.dart";

part "gpa_model.freezed.dart";
part "gpa_model.g.dart";

/// Represent a course.
@freezed
@immutable
sealed class Course with _$Course {
  /// Create a new, immutable instance of [Course].
  const factory Course({
    /// The hour that this course takes place.
    required int hour,

    /// The grade of the course.
    required LetterGrade grade,

    /// The name of the course.
    String? name,
  }) = _Course;

  /// Convert a JSON [Map] into a new, immutable instance of [Course].
  factory Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);
}

/// Represent a letter grade.
@freezed
sealed class LetterGrade with _$LetterGrade implements Comparable<LetterGrade> {
  /// Convert from a percentage grade to a letter grade.
  factory LetterGrade.fromGrade(double grade, {bool isHonors = false}) {
    return switch (grade) {
      >= 90 => LetterGrade.a(isHonors: isHonors),
      >= 80 => LetterGrade.b(isHonors: isHonors),
      >= 70 => LetterGrade.c(isHonors: isHonors),
      >= 60 => LetterGrade.d(isHonors: isHonors),
      _ => LetterGrade.f(isHonors: isHonors),
    };
  }

  const LetterGrade._();

  /// Convert a JSON [Map] into a new, immutable instance of [LetterGrade].
  factory LetterGrade.fromJson(Map<String, dynamic> json) =>
      _$LetterGradeFromJson(json);

  /// Represent an 'A'.
  const factory LetterGrade.a({@Default(false) bool isHonors}) = _A;

  /// Represent a 'B'.
  const factory LetterGrade.b({@Default(false) bool isHonors}) = _B;

  /// Represent a 'C'.
  const factory LetterGrade.c({@Default(false) bool isHonors}) = _C;

  /// Represent a 'D'.
  const factory LetterGrade.d({@Default(false) bool isHonors}) = _D;

  /// Represent an 'F'.
  const factory LetterGrade.f({@Default(false) bool isHonors}) = _F;

  /// The GPA value for the letter grade.
  int get value => switch (this) {
        _A(:final isHonors) => isHonors ? 5 : 4,
        _B(:final isHonors) => isHonors ? 4 : 3,
        _C(:final isHonors) => isHonors ? 3 : 2,
        _D() => 1,
        _F() => 0,
      };

  /// The letter grade's name.
  String get name => switch (this) {
        _A() => "A",
        _B() => "B",
        _C() => "C",
        _D() => "D",
        _F() => "F",
      };

  @override
  int compareTo(LetterGrade other) => value.compareTo(other.value);

  /// Whether this letter grade's [value] is numerically greater than [other].
  bool operator >(LetterGrade other) => compareTo(other) > 0;

  /// Whether this letter grade's [value] is numerically greater than or equal to [other].
  bool operator >=(LetterGrade other) => compareTo(other) >= 0;

  /// Whether this letter grade's [value] is numerically less than [other].
  bool operator <(LetterGrade other) => compareTo(other) < 0;

  /// Whether this letter grade's [value] is numerically less than or equal to [other].
  bool operator <=(LetterGrade other) => compareTo(other) <= 0;
}
