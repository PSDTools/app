/// This library contains the Pirate Coins feature's business logic.
library;

import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../auth/application/auth_service.dart";
import "../data/coins_repository.dart";
import "../domain/coins_model.dart";

part "coins_service.g.dart";

/// Get coins data from data layer.
@riverpod
base class CoinsService extends _$CoinsService {
  @override
  FutureOr<CoinsModel> build(int userId) async {
    final coins = await ref.watch(coinStreamProvider(userId).future);

    return CoinsModel(coins: coins);
  }

  /// Modify coins in the database.
  Future<void> _updateCoins(int num) async {
    if (state case AsyncData(:final value)) {
      state = const AsyncValue.loading();
      await ref.read(coinsDataProvider(userId)).updateCoins(
            value.copyWith.coins(coins: value.coins.coins + num).coins,
          );
    }
  }

  /// Add coins to the database.
  Future<void> addCoins(int num) async {
    await _updateCoins(num);
  }

  /// Remove coins from the database.
  Future<void> removeCoins(int num) async {
    await _updateCoins(-num);
  }
}

/// Get the coins of the current user.
@riverpod
Future<CoinsModel> currentUserCoins(Ref ref) async {
  final userId = await ref.watch(idProvider.future);

  return ref.read(coinsServiceProvider(userId).future);
}

/// Get coins data from data layer.
@riverpod
base class CurrentStage extends _$CurrentStage {
  @override
  Stage build() => const Stage.pickStudent();

  /// Go to [Stage.viewCoins].
  // TODO(ParkerH27): Make this based on URLs.
  void goToViewCoinsStage(int student) {
    state = Stage.viewCoins(student: student);
  }

  /// Reset the stage back to the default.
  void reset() {
    state = const Stage.pickStudent();
  }
}
