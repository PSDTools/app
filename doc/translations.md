# Working with Translations 🌐

This project relies on [flutter_localizations][flutter_localizations_link] and follows the [official internationalization guide for Flutter][internationalization_link].

## Adding Strings

1. To add a new localizable string, open the `app_en.arb` file at `lib/l10n/arb/app_en.arb`.

   ```json
   {
     "@@locale": "en",
     "counterAppBarTitle": "Counter",
     "@counterAppBarTitle": {
       "description": "Text shown in the AppBar of the Counter Page"
     }
   }
   ```

1. Then add a new key/value and description

   ```json
   {
     "@@locale": "en",
     "counterAppBarTitle": "Counter",
     "@counterAppBarTitle": {
       "description": "Text shown in the AppBar of the Counter Page"
     },
     "helloWorld": "Hello World",
     "@helloWorld": {
       "description": "Hello World Text"
     }
   }
   ```

1. Use the new string

   ```dart
   import "../../../l10n/l10n.dart";

   @override
   Widget build(BUildContext context) {
     final l10n = context.l10n;
     return Text(l10n.helloWorld);
   }
   ```

## Generating Translations

To use the latest translations changes, you will need to generate them my using the Flutter CLI to generate the updated localizations:

```sh
flutter gen-l10n
```

## L10nization

Alternatively, you can use the [L10nization](https://marketplace.visualstudio.com/items?itemName=lsaudon.l10nization) VS Code extension, which offers quick fixes for non-localized text. To use it, highlight the text from quote-to-shining-quote, and follow the prompts.

[flutter_localizations_link]: https://api.flutter.dev/flutter/flutter_localizations/flutter_localizations-library.html
[internationalization_link]: https://flutter.dev/docs/development/accessibility-and-localization/internationalization
