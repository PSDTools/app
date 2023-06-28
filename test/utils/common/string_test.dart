import "package:flutter_test/flutter_test.dart";
import "package:pirate_code/utils/common/string.dart";

enum Test {
  unit,
  widget,
  e2e,
  integration,
  golden,
  benchmark,
}

void main() {
  group("string ...", () {
    test("enumName", () {
      expect(StringUtils().enumName(Test.unit.toString()), "unit");
    });
  });
}
