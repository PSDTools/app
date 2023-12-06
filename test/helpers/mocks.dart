import "package:mocktail/mocktail.dart";
import "package:pirate_code/features/auth/data/auth_repository.dart";
import "package:pirate_code/features/pirate_coins/data/coins_repository.dart";

import "riverpod.dart";

final Overrides mockOverrides = [
  authProvider.overrideWithValue(MockAuthRepository()),
  coinsDataProvider.overrideWith((_) => MockCoinsRepository()),
];

class MockAuthRepository extends Mock implements AuthRepository {}

class MockCoinsRepository extends Mock implements CoinsRepository {}
