import "package:flutter/material.dart";
import "package:flutter_web_plugins/url_strategy.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

import "app_router.dart";
import "model.dart";

final counterProvider =
    ChangeNotifierProvider<MyAppState>((ref) => MyAppState());

void main() {
  usePathUrlStrategy();
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  MyApp({super.key});
  // make sure you don't initiate your router
  // inside of the build function.
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const flutterLocale = Locale("en", "US");
    final theme = ColorScheme.fromSeed(seedColor: Colors.green);

    return MaterialApp.router(
      routerConfig: _appRouter.config(),
      title: "Namer App",
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: theme,
      ),
      locale: flutterLocale,
    );
  }
}
