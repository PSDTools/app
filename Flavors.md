### Flavors 🍨

This project contains 3 flavors:

- development
- staging
- production

To run the desired flavor either use the launch configuration in VSCode/Android Studio or use the following commands:

```sh
# Development
$ flutter run --flavor development --target lib/main_development.dart --dart-define-from-file=dart_define.json

# Staging
$ flutter run --flavor staging --target lib/main_staging.dart --dart-define-from-file=dart_define.json

# Production
$ flutter run --flavor production --target lib/main_production.dart --dart-define-from-file=dart_define.json
```

_\*Pirate Code works on iOS, Android, Web, and Windows._
