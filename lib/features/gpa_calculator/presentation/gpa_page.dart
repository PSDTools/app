/// The auth feature.
library;

import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../utils/snackbar.dart";
import "../domain/gpa_domain.dart";
import "../domain/gpa_model.dart";

/// The page located at `/login/`
@RoutePage()
class GpaPage extends ConsumerStatefulWidget {
  /// Create a new instance of [GpaPage].
  const GpaPage({super.key});

  @override
  ConsumerState<GpaPage> createState() => _GpaPageState();
}

class _GpaPageState extends ConsumerState<GpaPage> {
  final _formKey = GlobalKey<FormState>();
  final _hours = 7;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 300,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  for (var hour = 0; hour < _hours; hour++)
                    Dropdown(
                      hour: hour,
                    ),
                ],
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState?.validate.call() ?? false) {
                var total = 0;
                for (var hour = 0; hour < _hours; hour++) {
                  final grade = ref.read(gpaProvider(hour)).grade;
                  total += grade.value;
                }

                final gpa = total / _hours;

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
class Dropdown extends ConsumerStatefulWidget {
  /// Create a new instance of [Dropdown].
  const Dropdown({required this.hour, super.key});

  /// The hour the course is taken.
  final int hour;

  @override
  ConsumerState<Dropdown> createState() => _DropdownState();
}

class _DropdownState extends ConsumerState<Dropdown> {
  @override
  Widget build(BuildContext context) {
    final value = ref.watch(gpaProvider(widget.hour));

    return DropdownButtonFormField(
      value: value.grade,
      items: const [
        DropdownMenuItem(value: LetterGrade.a(), child: Text("A")),
        DropdownMenuItem(value: LetterGrade.b(), child: Text("B")),
        DropdownMenuItem(value: LetterGrade.c(), child: Text("C")),
        DropdownMenuItem(value: LetterGrade.d(), child: Text("D")),
        DropdownMenuItem(value: LetterGrade.f(), child: Text("F")),
      ],
      onChanged: ref.read(gpaProvider(widget.hour).notifier).updateGrade,
    );
  }
}
