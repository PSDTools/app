/// This library contains the authentication feature's business logic.
library;

import "dart:typed_data";

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
    return _fetchSession();
  }

  /// Authenticate the current user.
  Future<void> authenticate() async {
    state = await AsyncValue.guard(_createSession);
  }

  Future<PirateAuthModel> _createSession({bool anonymous = false}) async {
    final auth = ref.read(authProvider);
    await auth.authenticate(anonymous: anonymous);
    final account = await auth.getData();

    return PirateAuthModel(
      user: account,
    );
  }

  Future<PirateAuthModel> _fetchSession() async {
    final auth = ref.read(authProvider);
    try {
      final account = await auth.getData();

      return PirateAuthModel(user: account);
    } catch (e) {
      return const PirateAuthModel(user: null);
    }
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
Future<PirateUserEntity> user(UserRef ref) async => await ref.watch(
      pirateAuthServiceProvider.selectAsync((value) {
        return value.user ?? fakeUser;
      }),
    );

/// A fake user, for use when all else fails.
final fakeUser = PirateUserEntity(
  name: redactedName,
  email: redactedEmail,
  accountType: AccountType.student,
  avatar: redactedAvatar,
  isLoggedIn: false,
);

/// Get the current user's name.
///
/// Named as such to prevent a naming conflict with riverpod.
@riverpod
Future<String> username(UsernameRef ref) async =>
    await ref.watch(userProvider.selectAsync((value) => value.name));

/// Get the current user's email address.
@riverpod
Future<String> email(EmailRef ref) async =>
    await ref.watch(userProvider.selectAsync((value) => value.email));

/// Get the current user's avatar.
@riverpod
Future<Uint8List> avatar(AvatarRef ref) async =>
    await ref.watch(userProvider.selectAsync((value) => value.avatar));

/// Get the current user's account type.
@riverpod
Future<AccountType> accountType(AccountTypeRef ref) async =>
    await ref.watch(userProvider.selectAsync((value) => value.accountType));

/// Get the current user's ID.
@riverpod
Future<int> id(IdRef ref) async =>
    await ref.watch(userProvider.selectAsync((value) => value.id));
