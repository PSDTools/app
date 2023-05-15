import 'package:flutter/material.dart';
import "package:flutter_riverpod/flutter_riverpod.dart";

import '../../l10n/l10n.dart';
import "../../model.dart";
import '../app_router.dart';

final modelProvider = ChangeNotifierProvider<MyAppState>((ref) => MyAppState());

class App extends ConsumerWidget {
  App({super.key});
  // make sure you don't initiate your router
  // inside of the build function.
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const flutterLocale = Locale("en", "US");
    final theme = ColorScheme.fromSeed(seedColor: Colors.green);

    return MaterialApp.router(
      routerConfig: _appRouter.config(),
      title: "PSD Wallet",
      theme: ThemeData(
        appBarTheme: AppBarTheme(color: theme.primary),
        useMaterial3: true,
        colorScheme: theme,
      ),
      locale: flutterLocale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
