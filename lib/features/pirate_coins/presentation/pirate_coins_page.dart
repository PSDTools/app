/// The pirate_coins feature.
library pirate_code.features.pirate_coins.page;

import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../l10n/l10n.dart";
import "../../../widgets/big_card/big_card.dart";
import "../domain/coins_domain.dart";

/// The page located at `/pirate-coins`.
@RoutePage()
class PirateCoinsPage extends ConsumerWidget {
  /// Create a new instance of [PirateCoinsPage].
  const PirateCoinsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(coinsProvider.select((value) => value.coins));
    final l10n = context.l10n;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: BigCard(
              switch (data) {
                AsyncData(:final value) => value.toString(),
                AsyncError(:final error) => l10n.error(error.toString()),
                AsyncLoading() => l10n.loading,
                _ => l10n.unknown,
              },
            ),
          ),
        ],
      ),
    );
  }
}
