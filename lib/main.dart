import "package:flutter/material.dart";
import "package:flutter_web_plugins/url_strategy.dart";
import "package:provider/provider.dart";

import "app_router.dart";
import "model.dart";

void main() {
  usePathUrlStrategy();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  // make sure you don't initiate your router
  // inside of the build function.
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    const flutterLocale = Locale("en", "US");
    final theme = ColorScheme.fromSeed(seedColor: Colors.green);

    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp.router(
        routerConfig: _appRouter.config(),
        title: "Namer App",
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: theme,
        ),
        locale: flutterLocale,
      ),
    );
  }
}
