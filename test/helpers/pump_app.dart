/// Extension method for configuring [WidgetTester].
library pirate_code.test.helpers.pump_app;

import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter_test/flutter_test.dart";
import "package:pirate_code/app/app.dart";
import "package:pirate_code/app/app_router.dart";
import "package:pirate_code/features/auth/data/auth_data.dart";
import "package:pirate_code/features/auth/domain/auth_domain.dart";
import "package:pirate_code/l10n/l10n.dart";

/// Extension method for [WidgetTester.pumpWidget].
extension PumpApp on WidgetTester {
  /// Pump a [Widget] in a [ProviderScope].
  Future<void> pumpApp(
    Widget widget, {
    List<Override>? overrides,
  }) async {
    final container = ProviderContainer(
      overrides: [
        ...?overrides,
        ...defaultOverrides,
      ],
    );

    appRouter = AppRouter(container: container);

    return pumpWidget(
      _Widget(
        container: container,
        child: widget,
      ),
    );
  }
}

class _Widget extends StatelessWidget {
  const _Widget({
    required this.child,
    required this.container,
    // Temporary ignore, see <dart-lang/sdk#49025>.
    // ignore: unused_element
    super.key,
  });

  final Widget child;
  final ProviderContainer container;

  @override
  Widget build(BuildContext context) {
    return UncontrolledProviderScope(
      container: container,
      child: MaterialApp.router(
        routerConfig: appRouter?.config(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
      ),
    );
  }
}

final List<Override> defaultOverrides = [
  authProvider.overrideWithValue(MockAuthRepository()),
];

class MockAuthRepository implements AuthRepository {
  // @override
  Future<PirateUser> anonymous() {
    return Future.value(
      const PirateUser(
        // name: anonymousName,
        name: "anonymous",
      ),
    );
  }

  @override
  Future<PirateUser> authenticate() {
    throw UnimplementedError("This is a mock!");
  }
}
