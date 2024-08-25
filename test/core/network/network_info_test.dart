import 'package:flutter_test/flutter_test.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:merokaam/core/network/network_info.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'network_info_test.mocks.dart';

@GenerateMocks([InternetConnectionChecker])
void main() {
  late NetworkInfoImpl networkInfo;
  late MockInternetConnectionChecker mockInternetConnectionChecker;

  setUp(() {
    mockInternetConnectionChecker = MockInternetConnectionChecker();
    networkInfo = NetworkInfoImpl(mockInternetConnectionChecker);
  });

  group('isConnected', () {
    test('should forward the call to InternetConnectionChecker.hasConnection', () async {
      // Arrange
      when(mockInternetConnectionChecker.hasConnection).thenAnswer((_) async => true);

      // Act
      final result = networkInfo.isConnected;

      // Assert
      verify(mockInternetConnectionChecker.hasConnection);
      expect(result, isA<Future<bool>>());
    });

    test('should return true when there is an internet connection', () async {
      // Arrange
      when(mockInternetConnectionChecker.hasConnection).thenAnswer((_) async => true);

      // Act
      final result = await networkInfo.isConnected;

      // Assert
      expect(result, true);
    });

    test('should return false when there is no internet connection', () async {
      // Arrange
      when(mockInternetConnectionChecker.hasConnection).thenAnswer((_) async => false);

      // Act
      final result = await networkInfo.isConnected;

      // Assert
      expect(result, false);
    });
  });
}
