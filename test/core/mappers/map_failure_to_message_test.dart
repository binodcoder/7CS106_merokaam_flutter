import 'package:flutter_test/flutter_test.dart';
import 'package:merokaam/core/errors/failures.dart';
import 'package:merokaam/core/mappers/map_failure_to_message.dart';
import 'package:merokaam/resources/strings_manager.dart';

void main() {
  group('mapFailureToMessage', () {
    test('should return server failure message for ServerFailure', () {
      // Arrange
      final failure = ServerFailure();

      // Act
      final result = mapFailureToMessage(failure);

      // Assert
      expect(result, AppStrings.serverFailureMessage);
    });

    test('should return cache failure message for CacheFailure', () {
      // Arrange
      final failure = CacheFailure();

      // Act
      final result = mapFailureToMessage(failure);

      // Assert
      expect(result, AppStrings.cacheFailureMessage);
    });

    test('should return login failure message for LoginFailure', () {
      // Arrange
      final failure = LoginFailure();

      // Act
      final result = mapFailureToMessage(failure);

      // Assert
      expect(result, AppStrings.loginFailureMessage);
    });

    test('should return default unexpected error message for unknown Failure type', () {
      // Arrange
      final failure = UnknownFailure();

      // Act
      final result = mapFailureToMessage(failure);

      // Assert
      expect(result, 'Unexpected error');
    });
  });
}
