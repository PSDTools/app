/// The auth feature.
library pirate_code.features.auth.page;

import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "../../../l10n/l10n.dart";
import "../domain/auth_domain.dart";

/// The page located at `/login/`
@RoutePage()
class AuthPage extends ConsumerWidget {
  /// Create a new instance of [AuthPage].
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(pirateAuthProvider.notifier);
    final l10n = context.l10n;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () async => auth.authenticate(context.router),
            child: Text(l10n.authenticateText),
          ),
        ],
      ),
    );
  }
}
