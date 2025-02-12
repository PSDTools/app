import "package:auto_size_text/auto_size_text.dart";
import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../features/gpa_calculator/domain/gpa_model.dart";

/// Dropdown widget for picking your letter grade.
class LetterGradeDropdown extends ConsumerWidget {
  /// Create a new instance of [LetterGradeDropdown].
  const LetterGradeDropdown({
    required this.hour,
    required this.grade,
    required this.updateGrade,
    // Temporary ignore, see <dart-lang/sdk#49025>.
    // ignore: unused_element_parameter
    super.key,
  });

  /// The hour the course is taken.
  final int hour;

  /// The grade for the course.
  final LetterGrade grade;

  /// Update the grade for the course.
  final LetterGradeCallback updateGrade;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const a = LetterGrade.a();
    const b = LetterGrade.b();
    const c = LetterGrade.c();
    const d = LetterGrade.d();
    const f = LetterGrade.f();

    return DropdownButtonFormField(
      value: grade,
      items: [
        DropdownMenuItem(value: a, child: AutoSizeText(a.name)),
        DropdownMenuItem(value: b, child: AutoSizeText(b.name)),
        DropdownMenuItem(value: c, child: AutoSizeText(c.name)),
        DropdownMenuItem(value: d, child: AutoSizeText(d.name)),
        DropdownMenuItem(value: f, child: AutoSizeText(f.name)),
      ],
      onChanged: updateGrade,
    );
  }
}

/// Signature of callbacks that take a lettergrade and return no data.
typedef LetterGradeCallback = void Function(LetterGrade?);
