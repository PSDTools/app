/// This library contains utilities for testing with Riverpod.
///
/// {@category Testing}
library;

import "dart:typed_data";

import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:pirate_code/features/auth/data/auth_data.dart";
import "package:pirate_code/features/auth/domain/auth_model.dart";

final List<Override> defaultOverrides = [
  ..._mockOverrides,
];

final List<Override> _mockOverrides = [
  authProvider.overrideWithValue(_MockAuthRepository()),
];

ProviderContainer createContainer(List<Override> overrides) =>
    ProviderContainer(
      overrides: [
        ...overrides,
        ...defaultOverrides,
      ],
    );

base class _MockAuthRepository implements AuthRepository {
  @override
  Future<PirateUser> authenticate({required bool anonymous}) => Future.value(
        PirateUser(
          name: "Mock User",
          email: "redacted@example.com",
          accountType: AccountType.student,
          avatar: Uint8List(0),
        ),
      );
}
