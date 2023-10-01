/// This library contains the Pirate Coins feature's main page.
library;

import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../l10n/l10n.dart";
import "../../../../utils/snackbar.dart";
import "../../../../widgets/big_card/big_card.dart";
import "../../../../widgets/email_form_field/email_form_field.dart";
import "../../../auth/domain/auth_domain.dart";
import "../../../auth/domain/auth_model.dart";
import "../../domain/coins_domain.dart";
import "../../domain/coins_model.dart";

/// The page located at `/pirate-coins`.
@RoutePage()
class PirateCoinsPage extends ConsumerWidget {
  /// Create a new instance of [PirateCoinsPage].
  const PirateCoinsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(
      pirateAuthProvider.select((value) => value),
    );

    final child = user.asData?.value.user?.accountType == AccountType.student
        ? const _StudentView()
        : const _TeacherView();

    return Center(
      child: child,
    );
  }
}

class _TeacherView extends ConsumerWidget {
  const _TeacherView({
    // Temporary ignore, see <dart-lang/sdk#49025>.
    // ignore: unused_element
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(currentStageProvider);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: switch (mode) {
        PickStudentStage() => [
            const _UserForm(),
          ],
        ViewCoinsStage(:final student) => [
            _ViewCoins(student: student),
            const SizedBox(height: 10),
            _MutationBar(student: student),
          ],
      },
    );
  }
}

class _StudentView extends ConsumerWidget {
  const _StudentView({
    // Temporary ignore, see <dart-lang/sdk#49025>.
    // ignore: unused_element
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final student = ref.watch(
      pirateAuthProvider.select((value) => value.asData?.value.user?.id),
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _ViewCoins(student: student ?? 0),
      ],
    );
  }
}

class _MutationBar extends ConsumerStatefulWidget {
  const _MutationBar({
    required this.student,
    // Temporary ignore, see <dart-lang/sdk#49025>.
    // ignore: unused_element
    super.key,
  });

  final int student;

  @override
  ConsumerState<_MutationBar> createState() => _MutationBarState();
}

class _MutationBarState extends ConsumerState<_MutationBar> {
  bool _requestIsInflight = false;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ElevatedButton.icon(
          onPressed: () async {
            if (!_requestIsInflight) {
              setState(() => _requestIsInflight = true);
              await ref
                  .read(coinsProvider(widget.student).notifier)
                  .addCoins(1);
              setState(() => _requestIsInflight = false);
            }
          },
          icon: _requestIsInflight
              ? const Icon(Icons.rotate_left)
              : const Icon(Icons.add),
          label: Text(l10n.addCoins),
        ),
        const SizedBox(width: 10),
        ElevatedButton.icon(
          onPressed: () async {
            if (!_requestIsInflight) {
              setState(() => _requestIsInflight = true);
              await ref
                  .read(coinsProvider(widget.student).notifier)
                  .removeCoins(1);
              setState(() => _requestIsInflight = false);
            }
          },
          icon: _requestIsInflight
              ? const Icon(Icons.rotate_right)
              : const Icon(Icons.remove),
          label: Text(l10n.removeCoins),
        ),
      ],
    );
  }
}

/// Pick a student to modify their coins, teachers.
class _UserForm extends ConsumerStatefulWidget {
  const _UserForm({
    // Temporary ignore, see <dart-lang/sdk#49025>.
    // ignore: unused_element
    super.key,
  });

  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends ConsumerState<_UserForm> {
  /// Create a [GlobalKey] that uniquely identifies the Form widget and allows validation of the form.
  ///
  /// Note: This is a [GlobalKey]<[FormState]>, not a [GlobalKey]<[_UserFormState]>.
  final _formKey = GlobalKey<FormState>();

  /// Create a text controller and use it to retrieve the current value of the [TextField].
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: 300,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Text(
              "Enter student's email:",
              style: theme.textTheme.headlineSmall,
            ),
            const SizedBox(height: 10),
            Text(
              "An email consists of the first seven characters of student's last name, their first initial, and possibly 2 numbers, followed by \"@student.psdr3.org\"",
              style: theme.textTheme.labelMedium,
            ),
            EmailFormField(myController),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState?.validate.call() ?? false) {
                  // If the form is valid, display a snackbar.
                  context.showSnackBar(
                    content: const Text("Processing Data"),
                  );

                  ref
                      .read(currentStageProvider.notifier)
                      .goToViewCoinsStage(getId(myController.text));
                }
              },
              child: const Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}

class _ViewCoins extends ConsumerWidget {
  const _ViewCoins({
    required this.student,
    // Temporary ignore, see <dart-lang/sdk#49025>.
    // ignore: unused_element
    super.key,
  });

  final int student;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final data = ref.watch(
      coinsProvider(student).select((value) => value),
    );

    return Padding(
      padding: const EdgeInsets.all(8),
      child: switch (data) {
        AsyncData(:final value) => BigCard("${value.coins.coins}"),
        AsyncError(:final error) => BigCard(l10n.error("$error")),
        AsyncLoading() => Column(
            children: [
              const CircularProgressIndicator(),
              Text(l10n.loading),
            ],
          ),
        _ => BigCard(l10n.error(l10n.unknownState)),
      },
    );
  }
}
