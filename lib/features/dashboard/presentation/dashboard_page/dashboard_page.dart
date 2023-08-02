/// The auth feature.
library pirate_code.features.dashboard.page;

import "package:auto_route/auto_route.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import '../../../../../app/app_router.dart';
import '../../../../../l10n/l10n.dart';
import '../../domain/dashboard_domain.dart';

/// The page located at `/login/`
@RoutePage()
class DashboardPage extends ConsumerWidget {
  /// Create a new instance of [DashboardPage].
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () async {
              print("Nothing to see here, move along.");
            },
            child: Text("Cool button"),
          ),
        ],
      ),
    );
  }
}
