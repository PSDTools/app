/// A widget for a...um...big card!
library pirate_code.widgets.big_card.view;

import "package:flutter/material.dart";

/// A, well, big card!
class BigCard extends StatelessWidget {
  /// Create a new instance of [BigCard].
  const BigCard(
    this.text, {
    super.key,
  });

  /// The text to display on the [BigCard].
  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium?.copyWith(
      color: theme.colorScheme.onPrimary,
    );
    const elevation = 2.0;

    final boldStyle = style?.copyWith(fontWeight: FontWeight.bold);

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
                Text(text, style: boldStyle),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
