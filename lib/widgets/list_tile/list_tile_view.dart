import "package:english_words/english_words.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../model.dart";

class FavListTile extends ConsumerWidget {
  const FavListTile({
    required this.pair,
    super.key,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displaySmall?.copyWith(
      color: theme.colorScheme.onSurfaceVariant,
    );

    return ListTile(
      leading: IconButton(
        color: theme.colorScheme.primary,
        onPressed: () =>
            ref.read(appStateProvider.notifier).toggleFavorite(pair),
        icon: const Icon(
          Icons.delete_outline,
          semanticLabel: "Delete",
        ),
      ),
      title: Text(
        pair.asLowerCase,
        style: style,
        semanticsLabel: pair.asPascalCase,
      ),
    );
  }
}
