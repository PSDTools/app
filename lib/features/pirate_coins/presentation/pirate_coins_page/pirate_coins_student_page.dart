/// This library contains the Pirate Coins feature's main page.
library;

import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../../../l10n/l10n.dart";
import "../../../../widgets/big_card/big_card.dart";
// import "../../../auth/domain/account_type.dart";
import "../../application/coins_service.dart";
import "../../domain/coins_model.dart";

/// The page located at `/pirate-coins`.
@RoutePage()
class PirateCoinsStudentPage extends ConsumerWidget {
  /// Create a new instance of [PirateCoinsStudentPage].
  const PirateCoinsStudentPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final accountType = ref.watch(accountTypeProvider).valueOrNull;

    return const Center(
      /// If the user is not a teacher, redirect them to the student page.
      child: _StudentView(),
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
              Text(l10n.loading),
            ],
          ),
      },
    );
  }
}
