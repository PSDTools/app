/// This library contains the Pirate Coins feature's statistics page.
library;

import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../../../l10n/l10n.dart";
import "../../../../widgets/big_card/big_card.dart";
import "../../../auth/application/auth_service.dart";
import "../../application/coins_service.dart";

/// The page at `/pirate-coins/stats`.
@RoutePage()
class StatsPage extends ConsumerWidget {
  /// Create a new instance of [StatsPage].
  const StatsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(userProvider.select((value) => value?.id));
    final data = userId != null ? ref.watch(coinsProvider(userId)) : null;
    final l10n = context.l10n;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: switch (data) {
              AsyncData(:final value) => value.coins.coins > 0
                  ? BigCard(l10n.howManyCoins(value.coins.coins))
                  : BigCard(l10n.emptyReport),
              AsyncError(:final error) => BigCard(l10n.error("$error")),
              AsyncLoading() => Column(
                  children: [
                    const CircularProgressIndicator(),
                    Text(l10n.loading),
                  ],
                ),
              _ => BigCard(l10n.error(l10n.unknownState)),
            },
          ),
        ],
      ),
    );
  }
}
