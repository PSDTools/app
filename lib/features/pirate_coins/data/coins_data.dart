import "package:riverpod_annotation/riverpod_annotation.dart";

part "coins_data.g.dart";

/// Get coins data.
@riverpod
int coinsData(CoinsDataRef ref) {
  return 100000;
}
