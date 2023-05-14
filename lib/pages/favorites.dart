import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../model.dart";

final modelProvider = Provider<MyAppState>();

@RoutePage()
class FavoritesPage extends ConsumerWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final appState = ref.watch<MyAppState>(modelProvider);
    final favorites = appState.favorites;

    if (favorites.isEmpty) {
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
            children: favorites
                .map(
                  (pair) => ListTile(
                    leading: IconButton(
                      icon: const Icon(
                        Icons.delete_outline,
                        semanticLabel: "Delete",
                      ),
                      color: theme.colorScheme.primary,
                      onPressed: () {
                        appState.toggleFavorite(pair);
                      },
                    ),
                    title: Text(
                      pair.asLowerCase,
                      semanticsLabel: pair.asPascalCase,
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
