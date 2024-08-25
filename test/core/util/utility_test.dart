import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:merokaam/core/util/utility.dart';

void main() {
  group('Utility', () {
    const base64StringExample = 'SGVsbG8gV29ybGQ='; // "Hello World" in Base64
    final dataExample = Uint8List.fromList([72, 101, 108, 108, 111, 32, 87, 111, 114, 108, 100]); // "Hello World" as bytes

    test('imageFromBase64String should return an Image widget', () {
      // Act
      final image = Utility.imageFromBase64String(base64StringExample);

      // Assert
      expect(image, isA<Image>());
    });

    test('dataFromBase64String should return correct Uint8List', () {
      // Act
      final data = Utility.dataFromBase64String(base64StringExample);

      // Assert
      expect(data, dataExample);
    });

    test('base64String should return correct Base64 encoded string', () {
      // Act
      final base64String = Utility.base64String(dataExample);

      // Assert
      expect(base64String, base64StringExample);
    });
  });
}
