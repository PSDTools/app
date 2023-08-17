/// The auth feature.
library;

import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "../../../../app/app_router.dart";
import "../../../../l10n/l10n.dart";
import "../../domain/auth_domain.dart";

/// The page located at `/login/`
@RoutePage()
class AuthPage extends ConsumerWidget {
  /// Create a new instance of [AuthPage].
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authenticate = ref.watch(
      pirateAuthProvider.notifier.select(
        (value) => value.authenticate,
      ),
    );
    final l10n = context.l10n;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () async {
              await authenticate();

              if (context.mounted) {
                await context.router.push(const DashboardRoute());
              }
            },
            child: Text(l10n.authenticateText),
          ),
        ],
      ),
    );
  }
}
