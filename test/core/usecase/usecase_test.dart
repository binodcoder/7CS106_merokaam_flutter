import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:merokaam/core/errors/failures.dart';
import 'package:merokaam/core/usecases/usecase.dart';

// A simple example use case to test the abstract class.
class TestUseCase extends UseCase<String, NoParams> {
  @override
  Future<Either<Failure, String>> call(NoParams params) async {
    // Simulate a successful response
    return const Right('Test UseCase Success');
  }
}

void main() {
  late TestUseCase useCase;

  setUp(() {
    useCase = TestUseCase();
  });

  group('UseCase', () {
    test('should return a successful result when called with NoParams', () async {
      // Arrange
      final params = NoParams();

      // Act
      final result = await useCase(params);

      // Assert
      expect(result, equals(const Right('Test UseCase Success')));
    });
  });

  group('NoParams', () {
    test('should have an empty props list', () {
      // Arrange
      final noParams = NoParams();

      // Assert
      expect(noParams.props, isEmpty);
    });

    test('should compare two instances as equal', () {
      // Arrange
      final noParams1 = NoParams();
      final noParams2 = NoParams();

      // Assert
      expect(noParams1, equals(noParams2));
    });
  });
}
