/// This library contains the widget preview.
library;

import "package:flutter/material.dart";
import "package:hooks_riverpod/hooks_riverpod.dart";
import "package:widgetbook/widgetbook.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart";

import "app/app.dart" hide App;
import "l10n/app_localizations.dart";
import "utils/design.dart";
import "widgetbook.generator.directories.g.dart";

void main() {
  runApp(const ProviderScope(child: WidgetbookApp()));
}

/// The main Widgetbook app.
@App()
class WidgetbookApp extends StatelessWidget {
  /// Create a new instance of [WidgetbookApp].
  const WidgetbookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      // Use the generated directories variable
      directories: directories,
      addons: [
        MaterialThemeAddon(
          themes: [
            WidgetbookTheme(
              name: "Light",
              data: ThemeData(colorScheme: scheme),
            ),
          ],
        ),
        LocalizationAddon(
          locales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          initialLocale: flutterLocale,
        ),
      ],
    );
  }
}
