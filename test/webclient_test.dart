library webclient_test;

import 'package:unittest/unittest.dart';

main() {
  test("works for two positive numbers", () {
    expect(1 + 2, equals(3));
  });
  test("works for two negative numbers", () {
    expect(-1 + -2, equals(-3));
  });
}