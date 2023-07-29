/// The stats feature.
library pirate_code.features.stats.page;

import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../l10n/l10n.dart";
import "../../../widgets/big_card/big_card.dart";

/// The page at `/pirate-coins/stats`.
@RoutePage()
class StatsPage extends ConsumerWidget {
  /// Create a new instance of [StatsPage].
  const StatsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: BigCard(l10n.emptyReport),
          ),
        ],
      ),
    );
  }
}
