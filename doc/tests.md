# Running Tests 🧪

To run tests use the following command:

```sh
dart run very_good_cli:very_good test --coverage --test-randomize-ordering-seed random
```

To view the generated coverage report you can use [lcov][lcov].

```sh
# Generate Coverage Report
genhtml coverage/lcov.info -o coverage/

# Open Coverage Report
open coverage/index.html
```

[lcov]: https://github.com/linux-test-project/lcov
