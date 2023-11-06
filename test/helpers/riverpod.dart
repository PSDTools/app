/// This library contains utilities for testing with Riverpod.
///
/// {@category Testing}
library;

import "dart:typed_data";

import "package:flutter_test/flutter_test.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:pirate_code/features/auth/application/auth_service.dart";
import "package:pirate_code/features/auth/domain/account_type.dart";
import "package:pirate_code/features/auth/domain/pirate_user.dart";

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
    overrides: overrides,
    observers: observers,
  );

  // When the test ends, dispose the container.
  addTearDown(container.dispose);

  return container;
}

final fakeUser = PirateUser(
  name: "",
  email: redactedEmail,
  accountType: AccountType.student,
  avatar: Uint8List(1),
);
