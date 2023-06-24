# Running Tests 🧪

To run tests use the following command:

```sh
flutter test --coverage --test-randomize-ordering-seed random --dart-define-from-file=dart_define.json
```

To view the generated coverage report you can use [lcov][lcov].

```sh
# Generate Coverage Report
genhtml coverage/lcov.info -o coverage/

# Open Coverage Report
open coverage/index.html
```
