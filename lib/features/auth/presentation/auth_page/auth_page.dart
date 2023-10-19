/// This library contains the authentication feature's login page.
library;

import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../../../app/app_router.dart";
import "../../../../l10n/l10n.dart";
import "../../application/auth_service.dart";

/// The page located at `/login/`.
@RoutePage()
class AuthPage extends ConsumerWidget {
  /// Create a new instance of [AuthPage].
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: () async {
                  await ref
                      .read(pirateAuthServiceProvider.notifier)
                      .authenticate();

                  if (context.mounted) {
                    await context.router.push(const DashboardRoute());
                  }
                },
                icon: const Icon(Icons.g_mobiledata),
                label: Text(l10n.authenticateText),
              ),
              const SizedBox(width: 10),
              ElevatedButton.icon(
                onPressed: () async {
                  await ref
                      .read(pirateAuthServiceProvider.notifier)
                      .anonymous();

                  if (context.mounted) {
                    await context.router.push(const DashboardRoute());
                  }
                },
                icon: const Icon(Icons.person),
                label: Text(l10n.anonymousAuthenticateText),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
