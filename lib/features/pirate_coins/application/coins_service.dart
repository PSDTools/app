/// This library contains the Pirate Coins feature's business logic.
library;

import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../auth/application/auth_service.dart";
import "../data/coins_repository.dart";
import "../domain/coin.dart";
import "../domain/coins_model.dart";

part "coins_service.g.dart";

/// Get coins data from data layer.
@riverpod
class CoinsService extends _$CoinsService {
  @override
  FutureOr<CoinsModel> build(int userId) async {
    return fetchCoins();
  }

  /// Get the coins of a user.
  Future<CoinsModel> fetchCoins() async {
    final getCoins = ref.read(
      coinsDataProvider.select((value) => value.coinsData),
    );
    final coins = await getCoins(userId);

    return CoinsModel(coins: coins);
  }

  /// Modify coins in the database.
  Future<void> _updateCoins(int num) async {
    final updateCoins = ref.read(
      coinsDataProvider.select((value) => value.updateCoins),
    );

    ref.invalidateSelf();
    await future;

    final currentCoins = state.asData?.value;

    if (currentCoins != null) {
      final coins = currentCoins.copyWith.coins(
        coins: currentCoins.coins.coins + num,
      );
      await updateCoins(coins.coins, userId);
    }

    ref.invalidateSelf();
    await future;
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
Future<CoinsModel?> currentUserCoins(CurrentUserCoinsRef ref) async {
  final userId = ref.watch(pirateAuthProvider.future);
  final fetchCoins =
      ref.read(coinsServiceProvider(await userId).notifier).fetchCoins;

  return fetchCoins();
}

/// Get coins data from data layer.
@riverpod
class CurrentStage extends _$CurrentStage {
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
