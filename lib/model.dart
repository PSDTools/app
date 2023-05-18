import "package:english_words/english_words.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:freezed_annotation/freezed_annotation.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

part "model.g.dart";
part "model.freezed.dart";

@freezed
class Model with _$Model {
  factory Model({
    required WordPair current,
    required List<WordPair> history,
    required Set<WordPair> favorites,
    GlobalKey? historyListKey,
  }) = _Model;
}

@riverpod
class AppState extends _$AppState {
  @override
  Model build() {
    return Model(
      current: WordPair.random(),
      history: [],
      favorites: {},
    );
  }

  FutureOr<void> getNext() {
    final newCurrent = WordPair.random();
    final animatedList =
        state.historyListKey?.currentState as AnimatedListState?;
    animatedList?.insertItem(0);
    state = state.copyWith(
      current: newCurrent,
      history: [state.current, ...state.history],
    );
  }

  FutureOr<void> toggleFavorite([WordPair? pair]) {
    pair = pair ?? state.current;
    final favorites = state.favorites.contains(pair)
        ? {
            for (final favorite in state.favorites)
              if (favorite != pair) favorite,
          }
        : {...state.favorites, pair};

    state = state.copyWith(favorites: favorites);
  }

  void setKey(GlobalKey? historyListKey) {
    state = state.copyWith(historyListKey: historyListKey);
  }
}
