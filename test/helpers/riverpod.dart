/// Helper functions for testing with Riverpod.
///
/// {@category Testing}
library;

import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:pirate_code/features/auth/data/auth_data.dart";

import "mocks.dart";

final List<Override> defaultOverrides = [
  ..._mockOverrides,
];

final List<Override> _mockOverrides = [
  authProvider.overrideWithValue(MockAuthRepository()),
];

ProviderContainer createContainer(List<Override> overrides) =>
    ProviderContainer(
      overrides: [
        ...overrides,
        ...defaultOverrides,
      ],
    );
