import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter_test/flutter_test.dart";
import "package:pirate_code/app/app.dart";
import "package:pirate_code/app/app_router.dart";
import "package:pirate_code/features/auth/data/auth_data.dart";
import "package:pirate_code/features/auth/domain/auth_domain.dart";

void main() {
  group("App", () {
    testWidgets("Renders a Material App.", (tester) async {
      final container = ProviderContainer(
        overrides: [
          authProvider.overrideWithValue(MockAuthRepository()),
        ],
      );

      appRouter = AppRouter(container: container);

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: const App(),
        ),
      );
      expect(find.byType(MaterialApp), findsOneWidget);
    });
  });
  group("Bootstrappin' Tests!", () {
    test("Test the boots...", () async {
      const tested = App();
      await expectLater(
        () async {
          await tested.bootstrap();
        },
        returnsNormally,
      );
    });
  });
}

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
