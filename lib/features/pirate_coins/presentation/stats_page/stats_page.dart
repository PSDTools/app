/// The Pirate Coins feature's statistic presentation.
library;

import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../l10n/l10n.dart";
import "../../../../widgets/big_card/big_card.dart";
import "stats_page_controller.dart";

/// The page at `/pirate-coins/stats`.
@RoutePage()
class StatsPage extends ConsumerWidget {
  /// Create a new instance of [StatsPage].
  const StatsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final (data,) = (ref.watch(statsPageControllerProvider),);
    final l10n = context.l10n;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: BigCard(
              switch (data) {
                AsyncData(:final value) => value.coins.coins > 0
                    ? l10n.howManyCoins(value.coins.coins)
                    : l10n.emptyReport,
                AsyncError(:final error) => l10n.error("$error"),
                AsyncLoading() => l10n.loading,
                _ => l10n.error(l10n.unknownState),
              },
            ),
          ),
        ],
      ),
    );
  }
}
