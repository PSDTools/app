import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../model.dart";

import "../big_card/big_card.dart";
import "../history/history.dart";

@RoutePage()
class GeneratorPage extends ConsumerWidget {
  const GeneratorPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(globalAppStateProvider);
    final pair = appState.current;

    IconData icon;
    if (appState.favorites.contains(pair)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Expanded(
            flex: 3,
            child: HistoryListView(),
          ),
          const SizedBox(height: 10),
          BigCard(pair: pair),
          const SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed:
                    ref.read(globalAppStateProvider.notifier).toggleFavorite,
                icon: Icon(icon),
                label: const Text("Like"),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: ref.read(globalAppStateProvider.notifier).getNext,
                child: const Text("Next"),
              ),
            ],
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}
