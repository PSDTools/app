/// The app widget.
library pirate_code.app;

import "package:flutter_riverpod/flutter_riverpod.dart";

import "bootstrap.dart";
import "view/app.dart";

export "app_router.dart";

/// The app widget, with [Bootstrap]pin' capabilities.
class App extends ConsumerWidget with AppView, Bootstrap {
  /// Create a new instance of [App].
  App({super.key});
}
