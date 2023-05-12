import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:provider/provider.dart';
import "../model.dart";

class BigListTile extends StatelessWidget {
  const BigListTile({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return ListTile(
      leading: IconButton(
        icon: Icon(
          Icons.delete_outline,
          semanticLabel: 'Delete',
        ),
        color: theme.colorScheme.primary,
        onPressed: () {
          appState.toggleFavorite(pair);
        },
      ),
      title: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          pair.asLowerCase,
          style: style,
          semanticsLabel: pair.asPascalCase,
        ),
      ),
    );
  }
}
