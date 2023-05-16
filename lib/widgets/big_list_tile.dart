import "package:english_words/english_words.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../model.dart";

final modelProvider = ChangeNotifierProvider<MyAppState>((ref) => MyAppState());

class BigListTile extends ConsumerWidget {
  const BigListTile({
    required this.pair,
    super.key,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch<MyAppState>(modelProvider);
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return ListTile(
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
      title: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          pair.asLowerCase,
          style: style,
          semanticsLabel: pair.asPascalCase,
        ),
      ),
    );
  }
}
