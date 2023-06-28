import "package:freezed_annotation/freezed_annotation.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "../data/coins_data.dart"; // Import the data layer file
part "coins_domain.freezed.dart";

@freezed
abstract class NumberDomain with _$NumberDomain {
  const factory NumberDomain({required int number}) = _NumberDomain;
}

final coinsDomainProvider = Provider<NumberDomain>((ref) {
  final number = ref.watch(coinsDataProvider);
  return NumberDomain(number: number);
});
