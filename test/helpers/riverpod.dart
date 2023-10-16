/// This library contains utilities for testing with Riverpod.
///
/// {@category Testing}
library;

import "package:flutter_test/flutter_test.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "mocks.dart";

final Overrides defaultOverrides = [
  ...mockOverrides,
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
