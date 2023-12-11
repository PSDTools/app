/// This library contains the Pirate Coins feature's main page.
library;

import "package:auto_route/auto_route.dart";
import "package:auto_size_text/auto_size_text.dart";
import "package:flutter/material.dart";
import "package:flutter_hooks/flutter_hooks.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../../../l10n/l10n.dart";
import "../../../../utils/hooks.dart";
import "../../../../utils/snackbar.dart";
import "../../../../widgets/big_card/big_card.dart";
import "../../../../widgets/email_form_field/email_form_field.dart";
import "../../../auth/application/auth_service.dart";
import "../../../auth/domain/account_type.dart";
import "../../../auth/domain/pirate_user_entity.dart";
import "../../application/coins_service.dart";
import "../../domain/coins_model.dart";

/// The page located at `/pirate-coins`.
@RoutePage()
class PirateCoinsPage extends ConsumerWidget {
  /// Create a new instance of [PirateCoinsPage].
  const PirateCoinsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountType = ref.watch(accountTypeProvider).valueOrNull;

    return Center(
      child: switch (accountType) {
        AccountType.student => const _StudentView(),
        AccountType.teacher => const _TeacherView(),
        AccountType.admin ||
        AccountType.dev ||
        AccountType.parent ||
        null =>
          const _TeacherView(),
      },
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
            SizedBox(
              height: 110,
              child: _ViewCoins(data: ref.watch(coinsServiceProvider(student))),
            ),
            const SizedBox(height: 10),
            _MutationBar(
              student: student,
              loaded: true, // TODO(ParkerH27): Wire this up.
            ),
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
    final data = ref.watch(currentUserCoinsProvider);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _ViewCoins(data: data),
      ],
    );
  }
}

class _MutationBar extends HookConsumerWidget {
  const _MutationBar({
    required this.student,
    required this.loaded,
    // Temporary ignore, see <dart-lang/sdk#49025>.
    // ignore: unused_element
    super.key,
  });

  final int student;
  final bool loaded;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final requestInFlight = useState(false);

    return LayoutBuilder(
      builder: (context, constraints) {
        final l10n = context.l10n;
        final isSmall = constraints.maxWidth < 400;

        return Flex(
          direction: isSmall ? Axis.vertical : Axis.horizontal,
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton.icon(
              onPressed: loaded && !requestInFlight.value
                  ? () async {
                      requestInFlight.value = true;
                      await ref
                          .read(coinsServiceProvider(student).notifier)
                          .addCoins(1);
                      requestInFlight.value = false;
                    }
                  : null,
              icon: const Icon(Icons.add),
              label: AutoSizeText(l10n.addCoins),
            ),
            const SizedBox(width: 10),
            ElevatedButton.icon(
              onPressed: loaded && !requestInFlight.value
                  ? () async {
                      requestInFlight.value = true;
                      await ref
                          .read(coinsServiceProvider(student).notifier)
                          .removeCoins(1);
                      requestInFlight.value = false;
                    }
                  : null,
              icon: const Icon(Icons.remove),
              label: AutoSizeText(l10n.removeCoins),
            ),
          ],
        );
      },
    );
  }
}

/// Teachers, pick a student to modify their coins.
class _UserForm extends HookConsumerWidget {
  const _UserForm({
    // Temporary ignore, see <dart-lang/sdk#49025>.
    // ignore: unused_element
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    // Create a key that uniquely identifies the Form widget and allows validation of the form.
    final formKey = useGlobalKey<FormState>();

    // Create a text controller and use it to retrieve the current value of the text field.
    final myController = useTextEditingController();

    // Create a scaffold feature controller, and use it to manage the snackbar.
    final snackBarController =
        useState<ScaffoldFeatureController<SnackBar, SnackBarClosedReason>?>(
      null,
    );

    return SizedBox(
      width: 300,
      child: Form(
        key: formKey,
        child: Column(
          children: [
            AutoSizeText(
              "Enter student's email:",
              style: theme.textTheme.headlineSmall,
            ),
            const SizedBox(height: 10),
            AutoSizeText(
              "An email consists of the first seven characters of student's last name, their first initial, and possibly 2 numbers, followed by \"@student.psdr3.org\"",
              style: theme.textTheme.labelMedium,
            ),
            EmailFormField(myController),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (formKey.currentState?.validate() ?? false) {
                  snackBarController.value?.close();
                  // If the form is valid, display a snackbar.
                  snackBarController.value = context.showSnackBar(
                    content: const AutoSizeText("Processing Data"),
                  );

                  ref
                      .read(currentStageProvider.notifier)
                      .goToViewCoinsStage(getId(myController.text));
                }
              },
              icon: const Icon(Icons.check),
              label: const AutoSizeText("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}

class _ViewCoins extends StatelessWidget {
  const _ViewCoins({
    required this.data,
    // Temporary ignore, see <dart-lang/sdk#49025>.
    // ignore: unused_element
    super.key,
  });

  final AsyncValue<CoinsModel> data;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Padding(
      padding: const EdgeInsets.all(8),
      child: switch (data) {
        AsyncData(:final value) => BigCard("${value.coins.coins}"),
        AsyncError(:final error) => BigCard(l10n.error("$error")),
        AsyncLoading() => Column(
            children: [
              const CircularProgressIndicator(),
              AutoSizeText(l10n.loading),
            ],
          ),
      },
    );
  }
}
