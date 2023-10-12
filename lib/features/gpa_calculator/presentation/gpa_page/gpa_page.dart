/// This library contains the GPA calculator's page.
library;

import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../../../utils/snackbar.dart";
import "../../../../widgets/letter_grade_dropdown/letter_grade_dropdown.dart";
import "../../application/gpa_service.dart";

/// The page located at `/gpa-calculator/`.
@RoutePage()
class GpaPage extends HookConsumerWidget {
  /// Create a new instance of [GpaPage].
  const GpaPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useState(GlobalKey<FormState>());
    final hours = useState(7);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 300,
            child: Form(
              key: formKey.value,
              child: Column(
                children: [
                  for (var hour = 0; hour < hours.value; hour++)
                    LetterGradeDropdown(
                      hour: hour,
                      grade: ref.read(gpaServiceProvider(hour)).grade,
                      updateGrade: ref
                          .read(gpaServiceProvider(hour).notifier)
                          .updateGrade,
                    ),
                ],
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (formKey.value.currentState?.validate.call() ?? false) {
                var total = 0;
                for (var hour = 0; hour < hours.value; hour++) {
                  final grade = ref.read(gpaServiceProvider(hour)).grade;
                  total += grade.value;
                }

                final gpa = total / hours.value;

                context.showSnackBar(
                  content: Text("Calculated GPA: $gpa"),
                );
              }
            },
            child: const Text("Calculate GPA"),
          ),
        ],
      ),
    );
  }
}
