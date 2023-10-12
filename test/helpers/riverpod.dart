/// This library contains utilities for testing with Riverpod.
///
/// {@category Testing}
library;

import "package:flutter_test/flutter_test.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:mocktail/mocktail.dart";
import "package:pirate_code/features/auth/data/auth_repository.dart";

final Overrides defaultOverrides = [
  ..._mockOverrides,
];

final Overrides _mockOverrides = [
  authProvider.overrideWithValue(MockAuthRepository()),
];

typedef Overrides = List<Override>;

/// A testing utility which creates a [ProviderContainer] and automatically
/// disposes it at the end of the test.
ProviderContainer createContainer({
  ProviderContainer? parent,
  Overrides overrides = const [],
  List<ProviderObserver>? observers,
}) {
  // Create a ProviderContainer, and optionally allow specifying parameters.
  final container = ProviderContainer(
    parent: parent,
    overrides: getOverrides(overrides),
    observers: observers,
  );

  // When the test ends, dispose the container.
  addTearDown(container.dispose);

  return container;
}

Overrides getOverrides(Overrides overrides) {
  return [
    ...overrides,
    ...defaultOverrides,
  ];
}

class MockAuthRepository extends Mock implements AuthRepository {}
