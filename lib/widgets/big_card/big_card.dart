/// This library contains a widget for a...um...big card!
library;

import "package:auto_size_text/auto_size_text.dart";
import "package:flutter/material.dart";
import "package:widgetbook/widgetbook.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart";

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
      fontWeight: FontWeight.bold,
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
                AutoSizeText(text, style: style),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// A [UseCase] for a [BigCard].
@UseCase(name: "name", type: BigCard)
Widget bigCardUseCase(BuildContext context) {
  return Column(
    children: [
      BigCard(
        context.knobs.string(
          label: "What the text says.",
          initialValue: "This is a big card!",
        ),
      ),
    ],
  );
}
