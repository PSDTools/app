import "package:english_words/english_words.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:freezed_annotation/freezed_annotation.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

part "model.g.dart";
part "model.freezed.dart";

@freezed
class AppState with _$AppState {
  factory AppState({
    required WordPair current,
    required List<WordPair> history,
    required Set<WordPair> favorites,
    GlobalKey? historyListKey,
  }) = _AppState;
}

@riverpod
class GlobalAppState extends _$GlobalAppState {
  @override
  AppState build() {
    return AppState(
      current: WordPair.random(),
      history: [],
      favorites: {},
    );
  }

  FutureOr<void> getNext() async {
    final newCurrent = WordPair.random();
    final animatedList =
        state.historyListKey?.currentState as AnimatedListState?;
    animatedList?.insertItem(0);
    state = state.copyWith(
      current: newCurrent,
      history: [state.current, ...state.history],
    );
  }

  FutureOr<void> toggleFavorite([WordPair? pair]) async {
    pair = pair ?? state.current;
    Set<WordPair> favorites;
    if (state.favorites.contains(pair)) {
      favorites = {
        for (final favorite in state.favorites)
          if (favorite != pair) favorite,
      };
    } else {
      favorites = {...state.favorites, pair};
    }

    state = state.copyWith(favorites: favorites);
  }

  void setKey(GlobalKey? historyListKey) {
    state = state.copyWith(historyListKey: historyListKey);
  }
}
