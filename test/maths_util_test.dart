import 'package:flutter_test/flutter_test.dart';
import 'package:merokaam/maths_util.dart';

void main() {
  test("check for two number addition", () {
    //Arrange
    int a = 5;
    int b = 5;

    //Act
    int sum = add(a, b);
    //Assert
    expect(sum, 10);
  });

  test("check for two numbers subtraction", () {
    //Arrange
    int a = 10;
    int b = 5;

    //Act
    int sub = subtract(a, b);
    //Assert
    expect(sub, 5);
  });

  test("check for two numbers multiplication", () {
    //Arrange
    int a = 10;
    int b = 5;

    //Act
    int mul = multiply(a, b);
    //Assert
    expect(mul, 50);
  });
}
