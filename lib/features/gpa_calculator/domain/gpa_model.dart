/// This library contains the GPA calculator feature's models.
library;

import "package:freezed_annotation/freezed_annotation.dart";

part "gpa_model.freezed.dart";

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
}

/// A grade.
sealed class LetterGrade {
  /// An 'A'.
  const factory LetterGrade.a({bool isHonors}) = _A;

  /// A 'B'.
  const factory LetterGrade.b({bool isHonors}) = _B;

  /// A 'C'.
  const factory LetterGrade.c({bool isHonors}) = _C;

  /// A 'D'.
  const factory LetterGrade.d({bool isHonors}) = _D;

  /// An 'F'.
  const factory LetterGrade.f({bool isHonors}) = _F;

  /// The GPA value for the letter grade.
  int get value;
}

/// An 'A'.
@freezed
@immutable
class _A with _$_A implements LetterGrade {
  /// Create a new, immutable [LetterGrade.a].
  const factory _A({
    @Default(false) bool isHonors,
  }) = __A;

  const _A._();

  @override
  int get value => isHonors ? 5 : 4;
}

/// A 'B'.
@freezed
@immutable
class _B with _$_B implements LetterGrade {
  /// Create a new, immutable [LetterGrade.b].
  const factory _B({
    @Default(false) bool isHonors,
  }) = __B;

  const _B._();

  @override
  int get value => isHonors ? 4 : 3;
}

/// A 'C'.
@freezed
@immutable
class _C with _$_C implements LetterGrade {
  /// Create a new, immutable [LetterGrade.c].
  const factory _C({
    @Default(false) bool isHonors,
  }) = __C;

  const _C._();

  @override
  int get value => isHonors ? 3 : 2;
}

/// A 'D'.
@freezed
@immutable
class _D with _$_D implements LetterGrade {
  /// Create a new, immutable [LetterGrade.d].
  const factory _D({
    @Default(false) bool isHonors,
  }) = __D;

  const _D._();

  @override
  int get value => 1;
}

/// An 'F'.
@freezed
@immutable
class _F with _$_F implements LetterGrade {
  /// Create a new, immutable [LetterGrade.f].
  const factory _F({
    @Default(false) bool isHonors,
  }) = __F;

  const _F._();

  @override
  int get value => 0;
}
