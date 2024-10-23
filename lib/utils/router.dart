import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:riverpod_annotation/riverpod_annotation.dart";

import "../app/app_router.dart";

part "router.g.dart";

/// Get the app's router.
@Riverpod(keepAlive: true)
Raw<AppRouter> router(Ref ref) {
  return AppRouter(ref: ref);
}
