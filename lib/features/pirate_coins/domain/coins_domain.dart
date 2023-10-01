/// The pirate_coins feature's domain.
library;

import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../auth/domain/auth_domain.dart";
import "../data/coins_data.dart";
import "coins_model.dart";

part "coins_domain.g.dart";

/// Get coins data from data layer.
@riverpod
class Coins extends _$Coins {
  @override
  FutureOr<CoinsModel> build(int user) async {
    return fetchCoins();
  }

  /// Get the coins of a user.
  Future<CoinsModel> fetchCoins() async {
    final getCoins = ref.watch(
      coinsDataProvider.select((value) => value.coinsData),
    );
    final coins = await getCoins(user);

    return CoinsModel(coins: coins);
  }

  /// Add coins to the database.
  Future<CoinsModel> _updateCoins(int num) async {
    final updateCoins = ref.watch(
      coinsDataProvider.select((value) => value.updateCoins),
    );

    final currentCoins = await fetchCoins();
    final coins =
        currentCoins.copyWith.coins(coins: currentCoins.coins.coins + num);

    await updateCoins(coins.coins, user);

    return fetchCoins();
  }

  /// Add coins to the database.
  Future<void> addCoins(int num) async {
    state = await AsyncValue.guard(() async => _updateCoins(num));
  }

  /// Remove coins from the database.
  Future<void> removeCoins(int num) async {
    state = await AsyncValue.guard(() async => _updateCoins(-num));
  }
}

/// Get the coins of the current user.
@riverpod
Future<CoinsModel?> currentUserCoins(CurrentUserCoinsRef ref) async {
  final user = ref.watch(
    pirateAuthProvider.select((value) => value.asData?.value),
  );
  final fetchCoins = (user != null)
      ? ref.read(coinsProvider(user.id).notifier).fetchCoins
      : null;

  return fetchCoins?.call();
}

/// Get coins data from data layer.
@riverpod
class CurrentStage extends _$CurrentStage {
  @override
  Stage build() => const PickStudentStage();

  /// Go to [ViewCoinsStage].
  // TODO(lishaduck): Make this based on URLs.
  void goToViewCoinsStage(int student) {
    state = ViewCoinsStage(student: student);
  }

  /// Reset the stage back to the default.
  void reset() {
    state = const PickStudentStage();
  }
}
