import "dart:typed_data";

import "package:appwrite/appwrite.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../../../utils/api.dart";

part "avatar_data.g.dart";

/// A repository for getting avatars.
abstract interface class AvatarRepository {
  /// Get the avatar for the current user.
  Future<Uint8List> getAvatar();
}

/// The default implementation of [AvatarRepository].
class AppwriteAvatarRepository implements AvatarRepository {
  /// Create a new instance of [AppwriteAvatarRepository].
  const AppwriteAvatarRepository(Avatars avatars) : _avatars = avatars;

  final Avatars _avatars;

  @override
  Future<Uint8List> getAvatar() => _avatars.getInitials();
}

/// Get the current user's avatar.
@riverpod
AvatarRepository avatar(AvatarRef ref) {
  final avatars = ref.read(avatarsProvider);

  return AppwriteAvatarRepository(avatars);
}
