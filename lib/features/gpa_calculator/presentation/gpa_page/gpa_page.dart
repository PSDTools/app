/// This library contains the GPA calculator's page.
library;

import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../../../utils/hooks.dart";
import "../../../../utils/snackbar.dart";
import "../../../../widgets/letter_grade_dropdown/letter_grade_dropdown.dart";
import "../../application/gpa_service.dart";
import "../../domain/gpa_model.dart";

/// The page located at `/gpa-calculator/`.
@RoutePage()
class GpaPage extends HookConsumerWidget {
  /// Create a new instance of [GpaPage].
  const GpaPage({super.key});

  static void _noOp(LetterGrade? _) {}

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useGlobalKey<FormState>();
    final hours = useState(7); // TODO(ParkerH27): Make this configurable.
    final scrollController = useScrollController();
    final snackBarController =
        useState<ScaffoldFeatureController<SnackBar, SnackBarClosedReason>?>(
      null,
    );

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 300,
            child: Form(
              key: formKey,
              child: SizedBox(
                height: 500,
                child: Scrollbar(
                  controller: scrollController,
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return LetterGradeDropdown(
                        hour: index,
                        grade: ref.watch(gpaServiceProvider(index)).grade,
                        updateGrade: (grade) => ref
                            .read(gpaServiceProvider(index).notifier)
                            .updateGrade(grade ?? defaultLetterGrade),
                      );
                    },
                    itemCount: hours.value,
                    prototypeItem: const LetterGradeDropdown(
                      hour: 0,
                      grade: LetterGrade.a(),
                      updateGrade: _noOp,
                    ),
                  ),
                ),
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {
              if (formKey.currentState?.validate() ?? false) {
                var total = 0;
                for (var hour = 0; hour < hours.value; hour++) {
                  final grade = ref.read(gpaServiceProvider(hour)).grade.value;
                  total += grade;
                }

                final gpa = total / hours.value;

                snackBarController.value?.close();
                snackBarController.value = context.showSnackBar(
                  content: Text("Calculated GPA: $gpa"),
                );
              }
            },
            icon: const Icon(Icons.calculate),
            label: const Text("Calculate GPA"),
          ),
        ],
      ),
    );
  }
}
