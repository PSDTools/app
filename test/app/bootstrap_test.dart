import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:flutter_test/flutter_test.dart";
import "package:pirate_code/app/bootstrap.dart";

import "../helpers/helpers.dart";

class _BootstrapMixed extends ConsumerWidget with Bootstrap {
  const _BootstrapMixed({
    // Temporary ignore, see <dart-lang/sdk#49025>.
    // ignore: unused_element
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Text("");
  }
}

void main() {
  group("Bootstrappin' Tests", () {
    testWidgets("Test the boots", (tester) async {
      await tester.pumpApp(const _BootstrapMixed());
      expect(find.text(""), findsOneWidget);
    });
  });
}
