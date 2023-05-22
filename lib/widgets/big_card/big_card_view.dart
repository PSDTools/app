import "package:english_words/english_words.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

class BigCard extends ConsumerWidget {
  const BigCard({
    required this.pair,
    super.key,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium?.copyWith(
      color: theme.colorScheme.onPrimary,
    );
    const elevation = 2.0;

    return Card(
      color: theme.colorScheme.primary,
      elevation: elevation,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: AnimatedSize(
          duration: const Duration(milliseconds: 200),
          child: MergeSemantics(
            child: Wrap(
              children: [
                Text(
                  pair.first,
                  style: style?.copyWith(fontWeight: FontWeight.w200),
                ),
                Text(
                  pair.second,
                  style: style?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
