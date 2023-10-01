/// This library contains the GPA calculator's page.
library;

import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../../../utils/snackbar.dart";
import "../../domain/gpa_domain.dart";
import "../../domain/gpa_model.dart";

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
                    _Dropdown(
                      hour: hour,
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
                  final grade = ref.read(gpaProvider(hour)).grade;
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

/// Dropdown widget for picking your letter grade.
class _Dropdown extends ConsumerWidget {
  /// Create a new instance of [_Dropdown].
  const _Dropdown({
    required this.hour,
    // Temporary ignore, see <dart-lang/sdk#49025>.
    // ignore: unused_element
    super.key,
  });

  /// The hour the course is taken.
  final int hour;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(gpaProvider(hour));

    return DropdownButtonFormField(
      value: value.grade,
      items: const [
        DropdownMenuItem(value: LetterGrade.a(), child: Text("A")),
        DropdownMenuItem(value: LetterGrade.b(), child: Text("B")),
        DropdownMenuItem(value: LetterGrade.c(), child: Text("C")),
        DropdownMenuItem(value: LetterGrade.d(), child: Text("D")),
        DropdownMenuItem(value: LetterGrade.f(), child: Text("F")),
      ],
      onChanged: ref.read(gpaProvider(hour).notifier).updateGrade,
    );
  }
}
