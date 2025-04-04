/// This library contains the authentication feature's business logic.
library;

import "dart:typed_data";

import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../data/auth_repository.dart";
import "../domain/account_type.dart";
import "../domain/pirate_auth_model.dart";
import "../domain/pirate_user_entity.dart";

part "auth_service.g.dart";

/// Get the current user.
@Riverpod(keepAlive: true)
base class PirateAuthService extends _$PirateAuthService {
  @override
  FutureOr<PirateAuthModel> build() async {
    return _createSession(anonymous: true);
  }

  /// Authenticate the current user.
  Future<void> authenticate() async {
    state = await AsyncValue.guard(_createSession);
  }

  Future<PirateAuthModel> _createSession({bool anonymous = false}) async {
    final auth = ref.read(authProvider);
    final account = await auth.authenticate(anonymous: anonymous);

    return PirateAuthModel(user: account);
  }

  /// Create a new anonymous session for the user.
  Future<void> anonymous() async {
    state = await AsyncValue.guard(() => _createSession(anonymous: true));
  }
}

/// Get the current user with minimal fuss.
///
/// Use [pirateAuthServiceProvider] for more granular output.
@Riverpod(keepAlive: true)
Future<PirateUserEntity> user(Ref ref) async => await ref.watch(
  pirateAuthServiceProvider.selectAsync((value) => value.user),
);

/// Get the current user's name.
///
/// Named as such to prevent a naming conflict with riverpod.
@riverpod
Future<String> username(Ref ref) async =>
    await ref.watch(userProvider.selectAsync((value) => value.name));

/// Get the current user's email address.
@riverpod
Future<String> email(Ref ref) async =>
    await ref.watch(userProvider.selectAsync((value) => value.email));

/// Get the current user's avatar.
@riverpod
Future<Uint8List> avatar(Ref ref) async =>
    await ref.watch(userProvider.selectAsync((value) => value.avatar));

/// Get the current user's account type.
@riverpod
Future<AccountType> accountType(Ref ref) async =>
    await ref.watch(userProvider.selectAsync((value) => value.accountType));

/// Get the current user's ID.
@riverpod
Future<int> id(Ref ref) async =>
    await ref.watch(userProvider.selectAsync((value) => value.id));
