/// This library contains utilities for testing with Riverpod.
///
/// {@category Testing}
library;

import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:mocktail/mocktail.dart";
import "package:pirate_code/features/auth/data/auth_data.dart";

final List<Override> defaultOverrides = [
  ..._mockOverrides,
];

final List<Override> _mockOverrides = [
  authProvider.overrideWithValue(MockAuthRepository()),
];

class MockAuthRepository extends Mock implements AuthRepository {}
