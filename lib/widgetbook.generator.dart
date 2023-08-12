import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:widgetbook/widgetbook.dart";
import "package:widgetbook_annotation/widgetbook_annotation.dart";

import "app/app.dart" show flutterLocale, globalTheme;
import "l10n/app_localizations.dart";
import "widgetbook.generator.directories.g.dart";
import "widgets/big_card/big_card.dart";

/// A use-case for a big card.
@UseCase(name: "name", type: BigCard)
Widget bigCardUseCase(BuildContext context) {
  return Column(
    children: [
      BigCard(
        context.knobs.string(
          label: "What the text says.",
          initialValue: "This is a big card!",
        ),
      ),
    ],
  );
}

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
              data: ThemeData(colorScheme: globalTheme),
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
