import 'package:flutter_test/flutter_test.dart';
import 'package:merokaam/core/errors/exceptions.dart';
import 'package:merokaam/core/errors/failures.dart';
import 'package:merokaam/core/mappers/map_exception_to_failure.dart';
// Update this path as needed

void main() {
  group('mapExceptionToFailure', () {
    test('should return ServerFailure when ServerException is provided', () {
      // arrange
      final exception = ServerException('Server error', 'server');

      // act
      final failure = mapExceptionToFailure(exception);

      // assert
      expect(failure, isA<ServerFailure>());
      expect((failure as ServerFailure).message, equals('Server error'));
      expect(failure.cause, equals('server'));
    });

    test('should return CacheFailure when CacheException is provided', () {
      // arrange
      final exception = CacheException('Cache error', 'cache');

      // act
      final failure = mapExceptionToFailure(exception);

      // assert
      expect(failure, isA<CacheFailure>());
      expect((failure as CacheFailure).message, equals('Cache error'));
      expect(failure.cause, equals('cache'));
    });

    test('should return NetworkFailure when NetworkException is provided', () {
      // arrange
      final exception = NetworkException('Network error', 'network');

      // act
      final failure = mapExceptionToFailure(exception);

      // assert
      expect(failure, isA<NetworkFailure>());
      expect((failure as NetworkFailure).message, equals('Network error'));
      expect(failure.cause, equals('network'));
    });

    test('should return TimeoutFailure when CustomTimeoutException is provided', () {
      // arrange
      final exception = CustomTimeoutException('Timeout error', 'timeout');

      // act
      final failure = mapExceptionToFailure(exception);

      // assert
      expect(failure, isA<TimeoutFailure>());
      expect((failure as TimeoutFailure).message, equals('Timeout error'));
      expect(failure.cause, equals('timeout'));
    });

    test('should return NotFoundFailure when NotFoundException is provided', () {
      // arrange
      final exception = NotFoundException('Not found error', 'not found');

      // act
      final failure = mapExceptionToFailure(exception);

      // assert
      expect(failure, isA<NotFoundFailure>());
      expect((failure as NotFoundFailure).message, equals('Not found error'));
      expect(failure.cause, equals('not found'));
    });

    test('should return UnknownFailure when an unknown exception type is provided', () {
      // arrange
      final exception = AppException('Unknown error', 'unknown');

      // act
      final failure = mapExceptionToFailure(exception);

      // assert
      expect(failure, isA<UnknownFailure>());
      expect((failure as UnknownFailure).message, equals('Unknown error'));
      expect(failure.cause, equals('unknown'));
    });

    // Add more tests for other exception types as needed.
  });
}
