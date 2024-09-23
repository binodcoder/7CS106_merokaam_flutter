import 'package:flutter_test/flutter_test.dart';
import 'package:merokaam/core/entities/login.dart';
import 'package:merokaam/core/entities/user_info_response.dart';
import 'package:merokaam/core/errors/exceptions.dart';
import 'package:merokaam/core/errors/failures.dart';
import 'package:merokaam/core/network/network_info.dart';
import 'package:merokaam/layers/data/login/datasources/login_remote_data_source.dart';
import 'package:merokaam/layers/data/login/repositories/login_repositories_impl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

import 'login_repositories_impl_test.mocks.dart';

@GenerateMocks([LoginRemoteDataSource, NetworkInfo])
void main() {
  late LoginRepositoryImpl repository;
  late MockLoginRemoteDataSource mockRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockLoginRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = LoginRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  final tLoginModel = LoginModel(
    email: 'test@example.com',
    password: 'password123',
  );

  final tUserInfoResponse = UserInfoResponse(
    id: 1,
    jwtToken: '',
    username: '',
    userTypeName: '',
  );

  group('login', () {
    test('should check if the device is online', () async {
      // Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.login(any)).thenAnswer((_) async => tUserInfoResponse);

      // Act
      repository.login(tLoginModel);

      // Assert
      verify(mockNetworkInfo.isConnected);
    });

    test('should return UserInfoResponse when the call to remote data source is successful', () async {
      // Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.login(tLoginModel)).thenAnswer((_) async => tUserInfoResponse);

      // Act
      final result = await repository.login(tLoginModel);

      // Assert
      verify(mockRemoteDataSource.login(tLoginModel));
      expect(result, equals(Right(tUserInfoResponse)));
    });

    test('should return ServerFailure when the call to remote data source is unsuccessful', () async {
      // Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.login(tLoginModel)).thenThrow(ServerException('Server error occurred.'));

      // Act
      final result = await repository.login(tLoginModel);

      // Assert
      verify(mockRemoteDataSource.login(tLoginModel));

      // Check that result is a Left containing a ServerFailure
      expect(result, isA<Left<Failure, UserInfoResponse>>());
      result?.fold(
        (failure) {
          // Check that the failure is a ServerFailure
          expect(failure, isA<ServerFailure>());
          // Optionally check the failure message
          expect((failure as ServerFailure).message, 'Server error occurred.');
        },
        (_) => fail('Expected a Left containing ServerFailure'),
      );
    });

    test('should return NetworkFailure when device is offline', () async {
      // Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      // Act
      final result = await repository.login(tLoginModel);

      // Assert
      verifyNever(mockRemoteDataSource.login(any));
      expect(result, equals(Left(NetworkFailure())));
    });
  });
}
