/// The auth feature.
library;

import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../app/app_router.dart";
import "../../../../l10n/l10n.dart";
import "auth_page_controller.dart";

/// The page located at `/login/`
@RoutePage()
class AuthPage extends ConsumerWidget {
  /// Create a new instance of [AuthPage].
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final (authenticate,) = (ref.watch(authPageControllerProvider),);
    final l10n = context.l10n;
    final router = context.router;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () async {
              await authenticate();
              await router.push(const PirateCoinsRoute());
            },
            child: Text(l10n.authenticateText),
          ),
        ],
      ),
    );
  }
}
