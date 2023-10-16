/// This library contains the Pirate Coins feature's main page.
library;

import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../../../l10n/l10n.dart";
import "../../../../utils/snackbar.dart";
import "../../../../widgets/big_card/big_card.dart";
import "../../../../widgets/email_form_field/email_form_field.dart";
import "../../../auth/application/auth_service.dart";
import "../../../auth/domain/account_type.dart";
import "../../../auth/domain/pirate_user.dart";
import "../../application/coins_service.dart";
import "../../domain/coins_model.dart";

/// The page located at `/pirate-coins`.
@RoutePage()
class PirateCoinsPage extends ConsumerWidget {
  /// Create a new instance of [PirateCoinsPage].
  const PirateCoinsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountType = ref.watch(accountTypeProvider);
    final id = ref.watch(idProvider);

    final child = accountType == AccountType.student
        ? _StudentView(id: id ?? 0)
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
            _UserForm(),
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

class _StudentView extends StatelessWidget {
  const _StudentView({
    required this.id,
    // Temporary ignore, see <dart-lang/sdk#49025>.
    // ignore: unused_element
    super.key,
  });

  final int id;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _ViewCoins(student: id),
      ],
    );
  }
}

class _MutationBar extends HookConsumerWidget {
  const _MutationBar({
    required this.student,
    // Temporary ignore, see <dart-lang/sdk#49025>.
    // ignore: unused_element
    super.key,
  });

  final int student;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final requestIsInflight = useState(false);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ElevatedButton.icon(
          onPressed: () async {
            if (!requestIsInflight.value) {
              requestIsInflight.value = true;
              await ref
                  .read(coinsServiceProvider(student).notifier)
                  .addCoins(1);
              requestIsInflight.value = false;
            }
          },
          icon: requestIsInflight.value
              ? const Icon(Icons.rotate_left)
              : const Icon(Icons.add),
          label: Text(l10n.addCoins),
        ),
        const SizedBox(width: 10),
        ElevatedButton.icon(
          onPressed: () async {
            if (!requestIsInflight.value) {
              requestIsInflight.value = true;
              await ref
                  .read(coinsServiceProvider(student).notifier)
                  .removeCoins(1);
              requestIsInflight.value = false;
            }
          },
          icon: requestIsInflight.value
              ? const Icon(Icons.rotate_right)
              : const Icon(Icons.remove),
          label: Text(l10n.removeCoins),
        ),
      ],
    );
  }
}

/// Teachers, pick a student to modify their coins.
class _UserForm extends HookConsumerWidget {
  _UserForm({
    // Temporary ignore, see <dart-lang/sdk#49025>.
    // ignore: unused_element
    super.key,
  });

  /// Create a [GlobalKey] that uniquely identifies the Form widget and allows validation of the form.
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    // Create a text controller and use it to retrieve the current value of the text field.
    final myController = useTextEditingController();

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
    final data = ref.watch(coinsServiceProvider(student));

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
