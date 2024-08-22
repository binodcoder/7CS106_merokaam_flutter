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
}
