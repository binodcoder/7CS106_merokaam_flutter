import 'package:flutter_test/flutter_test.dart';
import 'package:merokaam/core/errors/exceptions.dart';
import 'package:merokaam/core/errors/failures.dart';
import 'package:merokaam/core/models/user_model.dart';
import 'package:merokaam/core/network/network_info.dart';
import 'package:merokaam/layers/data/register/datasources/user_remote_data_source.dart';
import 'package:merokaam/layers/data/register/repositories/user_repositories_impl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

import 'user_repositories_impl_test.mocks.dart';

@GenerateMocks([UserRemoteDataSource, NetworkInfo])
void main() {
  late UserRepositoriesImpl repository;
  late MockUserRemoteDataSource mockRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockUserRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = UserRepositoriesImpl(
      addUserRemoteDataSource: mockRemoteDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  final tUserModel = UserModel(
    id: 1,
    email: 'test@example.com',
    password: 'password123',
  );

  group('addUser', () {
    test('should check if the device is online', () async {
      // Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.addUser(any)).thenAnswer((_) async => 1);

      // Act
      repository.addUser(tUserModel);

      // Assert
      verify(mockNetworkInfo.isConnected);
    });

    test('should return Right(int) when the call to remote data source is successful', () async {
      // Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.addUser(tUserModel)).thenAnswer((_) async => 1);

      // Act
      final result = await repository.addUser(tUserModel);

      // Assert
      verify(mockRemoteDataSource.addUser(tUserModel));
      expect(result, equals(Right(1)));
    });

    test('should return Left(ServerFailure) when remote data source fails', () async {
      // Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.addUser(tUserModel)).thenThrow(ServerException());

      // Act
      final result = await repository.addUser(tUserModel);

      // Assert
      verify(mockRemoteDataSource.addUser(tUserModel));
      expect(result, isA<Left<Failure, int>>());
      expect((result as Left).value, isA<ServerFailure>());
    });

    test('should return Left(NetworkFailure) when the device is offline', () async {
      // Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      // Act
      final result = await repository.addUser(tUserModel);

      // Assert
      verifyNever(mockRemoteDataSource.addUser(any));
      expect(result, equals(Left(NetworkFailure())));
    });
  });
}
