/// This library contains the authentication feature's login page.
library;

import "package:auto_route/auto_route.dart";
import "package:auto_size_text/auto_size_text.dart";
import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";

import "../../../../app/app_router.dart";
import "../../../../l10n/l10n.dart";
import "../../application/auth_service.dart";

/// The page located at `/login/`.
@RoutePage<bool>()
class AuthPage extends ConsumerWidget {
  /// Create a new instance of [AuthPage].
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              final l10n = context.l10n;
              final isSmall = constraints.maxWidth > 200;

              return Flex(
                direction: isSmall ? Axis.vertical : Axis.horizontal,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton.icon(
                    onPressed: () async {
                      await ref
                          .read(pirateAuthServiceProvider.notifier)
                          .authenticate();

                      if (context.mounted) {
                        await context.go();
                      }
                    },
                    icon: const Icon(Icons.g_mobiledata),
                    label: AutoSizeText(l10n.authenticateText),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton.icon(
                    onPressed: () async {
                      await ref
                          .read(pirateAuthServiceProvider.notifier)
                          .anonymous();

                      if (context.mounted) {
                        await context.go();
                      }
                    },
                    icon: const Icon(Icons.person),
                    label: AutoSizeText(l10n.anonymousAuthenticateText),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

extension _Go on BuildContext {
  Future<void> go() async {
    // if we were redirected here, go back to the right page.
    await router.pop<bool>(true);
    if (mounted) {
      // otherwise, go to the dashboard.
      await router.push(const DashboardRoute());
    }
  }
}
