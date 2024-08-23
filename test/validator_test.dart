import 'package:flutter_test/flutter_test.dart';
import 'package:merokaam/validator.dart';

void main() {
  //Pretest
  setUp(() => null);
  setUpAll(() => null);

  // setup is called before every test
  // setupall is called before all the tests

  // Setup -> test -> setup -> test -> setup -> test
  // SetupAll -> test -> test -> test

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

  test("validate for empty password", () {
    // arrange
    var password = "";

    // act
    var result = Validator.validatePassword(password);

    // assert
    expect(result, "Required Field");
  });

  test("validate for invalid password", () {
    // arrange
    var pass = "123";
    // act
    String result = Validator.validatePassword(pass);
    // assert
    expect(result,
        "Password must be at least 8 characters long and include an uppercase letter, a lowercase letter, a number, and a special character.");
  });

  test("validate for valid password", () {
    // arrange
    var pass = "P@ssw0rd123!";

    // act
    var result = Validator.validatePassword(pass);

    // assert
    expect(result, null);
  });

  // Posttest
  tearDown(() => null);
  tearDownAll(() => null);

  // test -> teardown -> test -> teardown
  // test -> test -> test ->  teardownall
}
