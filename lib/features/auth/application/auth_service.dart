/// This library contains the authentication feature's business logic.
library;

import "dart:typed_data";

import "package:riverpod_annotation/riverpod_annotation.dart";

import "../data/auth_repository.dart";
import "../domain/account_type.dart";
import "../domain/pirate_auth_model.dart";
import "../domain/pirate_user.dart";

part "auth_service.g.dart";

/// Get the current user.
@Riverpod(keepAlive: true)
class PirateAuthService extends _$PirateAuthService {
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

    return PirateAuthModel(
      user: account,
    );
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
PirateUser? user(UserRef ref) => ref.watch(
      pirateAuthServiceProvider.select((value) => value.valueOrNull?.user),
    );

/// The email address used in case things go wrong.
const redactedEmail = "redacted@example.com";

/// Get the current user's name.
@riverpod
String? name(NameRef ref) =>
    ref.watch(userProvider.select((value) => value?.name));

/// Get the current user's email address.
@riverpod
String? email(EmailRef ref) =>
    ref.watch(userProvider.select((value) => value?.email));

/// Get the current user's avatar.
@riverpod
Uint8List? avatar(AvatarRef ref) =>
    ref.watch(userProvider.select((value) => value?.avatar));

/// Get the current user's account type.
@riverpod
AccountType? accountType(AccountTypeRef ref) =>
    ref.watch(userProvider.select((value) => value?.accountType));

/// Get the current user's ID.
@riverpod
int? id(IdRef ref) => ref.watch(userProvider.select((value) => value?.id));
