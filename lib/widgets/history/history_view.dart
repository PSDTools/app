import "dart:async";

import "package:english_words/english_words.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../model.dart";

class HistoryListView extends ConsumerStatefulWidget {
  const HistoryListView({
    super.key,
  });

  @override
  HistoryListViewState createState() => HistoryListViewState();
}

class HistoryListViewState extends ConsumerState<HistoryListView> {
  /// Used to "fade out" the history items at the top, to suggest continuation.
  static const Gradient _maskingGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Colors.transparent, Colors.black],
    stops: [0.0, 0.5],
  );

  /// Needed so that [AppState] can tell [AnimatedList] below to animate
  /// new items.
  final _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    // "ref" can be used in all life-cycles of a StatefulWidget.
    ref.read(appStateProvider);
  }

  FutureOr<void> Function() onToggle(WordPair pair) {
    return () => ref.read(appStateProvider.notifier).toggleFavorite(pair);
  }

  FutureOr<void> setKey() {
    ref.read(appStateProvider.notifier).setKey(_key);
  }

  @override
  Widget build(BuildContext context) {
    final appState = ref.watch(appStateProvider);
    Future(setKey);

    return ShaderMask(
      shaderCallback: (bounds) => _maskingGradient.createShader(bounds),
      // This blend mode takes the opacity of the shader (i.e. our gradient) and applies it to the destination (i.e. our animated list).
      blendMode: BlendMode.dstIn,
      child: AnimatedList(
        key: _key,
        itemBuilder: (context, index, animation) {
          final pair = appState.history[index];

          return SizeTransition(
            sizeFactor: animation,
            child: Center(
              child: TextButton.icon(
                onPressed: onToggle(pair),
                icon: appState.favorites.contains(pair)
                    ? const Icon(
                        Icons.favorite,
                        size: 12,
                      )
                    : const SizedBox(),
                label: Text(
                  pair.asLowerCase,
                  semanticsLabel: pair.asPascalCase,
                ),
              ),
            ),
          );
        },
        initialItemCount: appState.history.length,
        reverse: true,
        padding: const EdgeInsets.only(top: 100),
      ),
    );
  }
}
