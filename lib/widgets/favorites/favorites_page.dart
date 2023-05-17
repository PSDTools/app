import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../model.dart";
import "../list_tile/list_tile.dart";

@RoutePage()
class FavoritesPage extends ConsumerWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(globalAppStateProvider);

    if (appState.favorites.isEmpty) {
      return const Center(
        child: Text("No favorites yet."),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(30),
          child: Text("You have "
              "${appState.favorites.length} favorites:"),
        ),
        Expanded(
          // Make better use of wide windows with a grid.
          child: GridView(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 400,
              childAspectRatio: 400 / 80,
            ),
            children: [
              for (final pair in appState.favorites) FavListTile(pair: pair),
            ],
          ),
        ),
      ],
    );
  }
}
