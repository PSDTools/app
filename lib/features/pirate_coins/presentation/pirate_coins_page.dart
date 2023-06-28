/// The pirate_coins feature.
library pirate_code.features.pirate_coins.page;

import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "./data/coins_data.dart";
import "./domain/coins_domain.dart";

// import "../../../utils/data/api.dart";
import "../../../widgets/big_card/big_card.dart";

/// The page located at `/pirate-coins`.
@RoutePage()
class PirateCoinsPage extends ConsumerWidget {
  /// Create a new instance of [PirateCoinsPage].
  const PirateCoinsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final appState = ref.watch(clientProvider);
    // final data = appState.coins;
    final data = ref.watch(coinsDomainProvider).number;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: BigCard(data.toString()),
          ),
        ],
      ),
    );
  }
}
