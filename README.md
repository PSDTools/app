# Pirate Code 3.0

![coverage][coverage_badge]
[![style: very good analysis][very_good_analysis_badge]][very_good_analysis_link]
[![License: MIT][license_badge]][license_link]
[![Dart](https://github.com/PSDTools/app/actions/workflows/dart.yml/badge.svg?branch=main)](https://github.com/PSDTools/app/actions/workflows/dart.yml)
[![Netlify Status](https://api.netlify.com/api/v1/badges/25b0c44e-21b7-423c-a914-32aa4b23b708/deploy-status)](https://app.netlify.com/sites/pattonville-wallet/deploys)

Generated by the [Very Good CLI][very_good_cli_link] 🤖

A Very Good Project created by Very Good CLI.

---

A new Flutter project.

## Getting Started 🚀

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

### Flavors

This project contains 3 flavors:

- development
- staging
- production

To run the desired flavor either use the launch configuration in VSCode/Android Studio or use the following commands:

```sh
# Development
$ flutter run --flavor development --target lib/main_development.dart

# Staging
$ flutter run --flavor staging --target lib/main_staging.dart

# Production
$ flutter run --flavor production --target lib/main_production.dart
```

_\*Pirate Code works on iOS, Android, Web, and Windows._

---

## Running Tests 🧪

To run all unit and widget tests use the following command:

```sh
flutter test --coverage --test-randomize-ordering-seed random
```

To view the generated coverage report you can use [lcov](https://github.com/linux-test-project/lcov).

```sh
# Generate Coverage Report
$ genhtml coverage/lcov.info -o coverage/

# Open Coverage Report
$ open coverage/index.html
```

---

## Working with Translations 🌐

This project relies on [flutter_localizations][flutter_localizations_link] and follows the [official internationalization guide for Flutter][internationalization_link].

### Adding Strings

1. To add a new localizable string, open the `app_en.arb` file at `lib/l10n/arb/app_en.arb`.

```arb
{
    "@@locale": "en",
    "counterAppBarTitle": "Counter",
    "@counterAppBarTitle": {
        "description": "Text shown in the AppBar of the Counter Page"
    }
}
```

1. Then add a new key/value and description

```arb
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
import 'package:pirate_code_3/l10n/l10n.dart';

@override
Widget build(BuildContext context) {
  final l10n = context.l10n;
  return Text(l10n.helloWorld);
}
```

### Adding Supported Locales

Update the `CFBundleLocalizations` array in the `Info.plist` at `ios/Runner/Info.plist` to include the new locale.

```xml
    ...

    <key>CFBundleLocalizations</key>
 <array>
  <string>en</string>
  <string>es</string>
 </array>

    ...
```

### Adding Translations

1. For each supported locale, add a new ARB file in `lib/l10n/arb`.

```console
├── l10n
│   ├── arb
│   │   ├── app_en.arb
│   │   └── app_es.arb
```

1. Add the translated strings to each `.arb` file:

`app_en.arb`

```arb
{
    "@@locale": "en",
    "counterAppBarTitle": "Counter",
    "@counterAppBarTitle": {
        "description": "Text shown in the AppBar of the Counter Page"
    }
}
```

`app_es.arb`

```arb
{
    "@@locale": "es",
    "counterAppBarTitle": "Contador",
    "@counterAppBarTitle": {
        "description": "Texto mostrado en la AppBar de la página del contador"
    }
}
```

## C4 Diagram

```mermaid
C4Context
  title System Context diagram

  Enterprise_Boundary(b0, "Pattonville") {
    Person(customerA, "Admin", "A school/district admin, one who can can see trends as well as give tokens.")
    Person(customerB, "Teachers", "A teacher, the one giving tokens.")
    Person_Ext(customerC, "Stuco", "The ones removing tokens.")
    Person_Ext(customerD, "Student", "The ones using tokens.")
    Person_Ext(customerE, "Devs", "@PSDTools")


    %% System(SystemAA, "Internet Banking System", "Allows customers to view information about their bank accounts, and make payments.")

    %% Enterprise_Boundary(b1, "BankBoundary") {

      %% SystemDb_Ext(SystemE, "Mainframe Banking System", "Stores all of the core banking information about customers, accounts, transactions, etc.")

      %% System_Boundary(b2, "BankBoundary2") {
        %% System(SystemA, "Banking System A")
        %% System(SystemB, "Banking System B", "A system of the bank, with personal bank accounts. next line.")
      %% }

      %% System_Ext(SystemC, "E-mail system", "The internal Microsoft Exchange e-mail system.")
      %% SystemDb(SystemD, "Banking System D Database", "A system of the bank, with personal bank accounts.")

      %% Boundary(b3, "BankBoundary3", "boundary") {
        %% SystemQueue(SystemF, "Banking System F Queue", "A system of the bank.")
        %% SystemQueue_Ext(SystemG, "Banking System G Queue", "A system of the bank, with personal bank accounts.")
      %% }
    %% }

  }


  Enterprise_Boundary(b4, "Instructure") {
    Person(instructure, "Devs")

    System_Boundary(b5, "Canvas") {
      System(CanvasApp, "Canvas Application")
    }
  }


  %% BiRel(customerA, SystemAA, "Uses")
  Rel(instructure, CanvasApp, "Makes")
  %% BiRel(SystemAA, SystemE, "Uses")
  %% Rel(SystemAA, SystemC, "Sends e-mails", "SMTP")
  %% Rel(SystemC, customerA, "Sends e-mails to")

  %% UpdateElementStyle(customerA, $fontColor="red", $bgColor="grey", $borderColor="red")
  %% UpdateRelStyle(customerA, SystemAA, $textColor="blue", $lineColor="blue", $offsetX="5")
  %% UpdateRelStyle(SystemAA, SystemE, $textColor="blue", $lineColor="blue", $offsetY="-10")
  %% UpdateRelStyle(SystemAA, SystemC, $textColor="blue", $lineColor="blue", $offsetY="-40", $offsetX="-50")
  %% UpdateRelStyle(SystemC, customerA, $textColor="red", $lineColor="red", $offsetX="-50", $offsetY="20")

  %% UpdateLayoutConfig($c4ShapeInRow="3", $c4BoundaryInRow="1")
```

[coverage_badge]: coverage_badge.svg
[flutter_localizations_link]: https://api.flutter.dev/flutter/flutter_localizations/flutter_localizations-library.html
[internationalization_link]: https://flutter.dev/docs/development/accessibility-and-localization/internationalization
[license_badge]: https://img.shields.io/badge/license-MIT-blue.svg
[license_link]: https://opensource.org/licenses/MIT
[very_good_analysis_badge]: https://img.shields.io/badge/style-very_good_analysis-B22C89.svg
[very_good_analysis_link]: https://pub.dev/packages/very_good_analysis
[very_good_cli_link]: https://github.com/VeryGoodOpenSource/very_good_cli
