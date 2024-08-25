import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:merokaam/core/errors/failures.dart';
import 'package:merokaam/core/usecases/usecase.dart';
import 'package:mockito/mockito.dart';

// Mock class to test the UseCase abstract class
class MockUseCase extends Mock implements UseCase<String, Params> {}

class Params {
  final String param;

  Params(this.param);
}

void main() {
  group('UseCase', () {
    late MockUseCase mockUseCase;
    late Params params;

    setUp(() {
      mockUseCase = MockUseCase();
      params = Params('Test');
    });

    test('should call the UseCase with the correct parameters', () async {
      // Arrange
      final tResult = Right<Failure, String>('Test Result');
      when(mockUseCase.call(params)).thenAnswer((_) async => tResult);

      // Act
      final result = await mockUseCase.call(params);

      // Assert
      verify(mockUseCase.call(params));
      expect(result, tResult);
    });

    test('should return null when UseCase call is not implemented', () async {
      // Arrange
      when(mockUseCase.call(params)).thenAnswer((_) async => null);

      // Act
      final result = await mockUseCase.call(params);

      // Assert
      expect(result, isNull);
    });
  });

  group('NoParams', () {
    test('should have an empty props list', () {
      // Act
      final noParams = NoParams();

      // Assert
      expect(noParams.props, []);
    });
  });
}
