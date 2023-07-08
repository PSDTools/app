/// The pirate_coins feature.
library pirate_code.features.auth.page;

import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "../domain/auth_domain.dart";

///
@RoutePage()
class AuthPage extends ConsumerWidget {
  ///
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider.notifier);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: auth.authenticate,
            child: const Text("Authenticate with Google!"),
          ),
        ],
      ),
    );
  }
}
