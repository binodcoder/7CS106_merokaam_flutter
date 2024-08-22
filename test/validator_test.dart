import 'package:flutter_test/flutter_test.dart';
import 'package:merokaam/validator.dart';

void main() {
  test("validate for empty email id", () {
    // arrange
    var email = "";

    // act
    var result = Validator.validateEmail(email);

    // assert
    expect(result, "Required Field");
  });

  test("validate for invalid email id", () {
    // arrange
    var email = "abcgmail.cm";

    // act
    var result = Validator.validateEmail(email);

    // assert
    expect(result, "Invalid Email");
  });

  test("validate for valid email id", () {
    // arrange
    var email = "abc@gmail.com";

    // act
    var result = Validator.validateEmail(email);

    // assert
    expect(result, null);
  });
}
