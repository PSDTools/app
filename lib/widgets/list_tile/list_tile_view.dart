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
    final style = theme.textTheme.displaySmall!.copyWith(
      color: theme.colorScheme.onSurfaceVariant,
    );

    return ListTile(
      leading: IconButton(
        icon: const Icon(
          Icons.delete_outline,
          semanticLabel: "Delete",
        ),
        color: theme.colorScheme.primary,
        onPressed: () async {
          ref.read(globalAppStateProvider.notifier).toggleFavorite(pair);
        },
      ),
      title: Text(
        pair.asLowerCase,
        style: style,
        semanticsLabel: pair.asPascalCase,
      ),
    );
  }
}