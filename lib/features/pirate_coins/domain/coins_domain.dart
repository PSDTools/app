import "package:freezed_annotation/freezed_annotation.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../data/coins_data.dart";

part "coins_domain.freezed.dart";
part "coins_domain.g.dart";

/// A number.
@freezed
@immutable
class NumberDomain with _$NumberDomain {
  /// Create a new, immutable instance of [NumberDomain].
  const factory NumberDomain({
    /// The number.
    required int number,
  }) = _NumberDomain;
}

/// Get coins data from data layer.
@riverpod
NumberDomain coinsDomain(CoinsDomainRef ref) {
  final number = ref.watch(coinsDataProvider);
  return NumberDomain(number: number);
}
