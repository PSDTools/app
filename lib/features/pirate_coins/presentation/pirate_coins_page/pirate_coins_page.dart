/// The Pirate Coins feature's main presentation.
library;

import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../l10n/l10n.dart";
import "../../../../widgets/big_card/big_card.dart";
import "../../domain/coins_domain.dart";

/// The page located at `/pirate-coins`.
@RoutePage()
class PirateCoinsPage extends ConsumerWidget {
  /// Create a new instance of [PirateCoinsPage].
  const PirateCoinsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(coinsProvider);
    final dataNotifier = ref.watch(coinsProvider.notifier);
    final l10n = context.l10n;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: BigCard(
              switch (data) {
                AsyncData(:final value) => value.coins.toString(),
                AsyncError(:final error) => l10n.error(error.toString()),
                AsyncLoading() => l10n.loading,
                _ => l10n.error("Unknown state"),
              },
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: () async => dataNotifier.addCoins(1),
                icon: const Icon(Icons.add),
                label: Text(l10n.addCoins),
              ),
              const SizedBox(width: 10),
              ElevatedButton.icon(
                onPressed: () async => dataNotifier.removeCoins(1),
                icon: const Icon(Icons.remove),
                label: Text(l10n.removeCoins),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
