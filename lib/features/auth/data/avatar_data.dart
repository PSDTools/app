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
base class _AppwriteAvatarRepository implements AvatarRepository {
  /// Create a new instance of [_AppwriteAvatarRepository].
  const _AppwriteAvatarRepository(Avatars avatars) : _avatars = avatars;

  final Avatars _avatars;

  @override
  Future<Uint8List> getAvatar() => _avatars.getInitials();
}

/// Get the current user's avatar.
@Riverpod(keepAlive: true)
AvatarRepository avatar(AvatarRef ref) {
  final avatars = ref.watch(avatarsProvider);

  return _AppwriteAvatarRepository(avatars);
}
