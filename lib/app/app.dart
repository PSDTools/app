import "package:flutter_riverpod/flutter_riverpod.dart";

import "bootstrap.dart";
import "view/app.dart";

export "app_router.dart";

class App extends ConsumerWidget with AppView, Bootstrap {
  App({super.key});
}
