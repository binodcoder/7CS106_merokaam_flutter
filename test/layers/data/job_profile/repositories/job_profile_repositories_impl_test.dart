import 'package:flutter_test/flutter_test.dart';
import 'package:merokaam/core/entities/job_profile.dart';
import 'package:merokaam/core/errors/exceptions.dart';
import 'package:merokaam/core/errors/failures.dart';
import 'package:merokaam/core/models/job_profile_model.dart';
import 'package:merokaam/core/network/network_info.dart';
import 'package:merokaam/layers/data/job_profile/data_sources/job_profile_local_data_source.dart';
import 'package:merokaam/layers/data/job_profile/data_sources/job_profile_remote_data_sources.dart';
import 'package:merokaam/layers/data/job_profile/repositories/job_profile_repository_impl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

import 'job_profile_repositories_impl_test.mocks.dart';

@GenerateMocks([
  JobProfilesLocalDataSource,
  JobProfileRemoteDataSource,
  NetworkInfo,
])
void main() {
  late JobProfileRepositoryImpl repository;
  late MockJobProfilesLocalDataSource mockLocalDataSource;
  late MockJobProfileRemoteDataSource mockRemoteDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockLocalDataSource = MockJobProfilesLocalDataSource();
    mockRemoteDataSource = MockJobProfileRemoteDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = JobProfileRepositoryImpl(
      jobProfileRemoteDataSources: mockRemoteDataSource,
      jobProfilesLocalDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  final tJobProfile = JobProfile(
    userAccountId: 1,
    firstName: 'John',
    lastName: 'Doe',
    city: 'City',
    state: 'State',
    country: 'Country',
    workAuthorization: 'Authorized',
    employmentType: 'Full-Time',
  );

  final tJobProfileModel = JobProfileModel(
    userAccountId: 1,
    firstName: 'John',
    lastName: 'Doe',
    city: 'City',
    state: 'State',
    country: 'Country',
    workAuthorization: 'Authorized',
    employmentType: 'Full-Time',
  );

  group('createJobProfile', () {
    test('should check if the device is online', () async {
      // Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.createJobProfile(any)).thenAnswer((_) async => 1);

      // Act
      repository.createJobProfile(tJobProfile);

      // Assert
      verify(mockNetworkInfo.isConnected);
    });

    test('should return Left(NetworkFailure) when device is offline', () async {
      // Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      // Act
      final result = await repository.createJobProfile(tJobProfile);

      // Assert
      verifyNever(mockRemoteDataSource.createJobProfile(any));
      expect(result, equals(Left(NetworkFailure())));
    });
  });

  group('readJobProfile', () {
    test('should return Left(ServerFailure) when remote data source fails', () async {
      // Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.readJobProfile(1)).thenThrow(ServerException());

      // Act
      final result = await repository.readJobProfile(1);

      // Assert
      verify(mockRemoteDataSource.readJobProfile(1));
      expect(result, isA<Left<Failure, JobProfile>>());
      result.fold(
        (failure) => expect(failure, isA<ServerFailure>()),
        (_) => fail('Expected a Left containing ServerFailure'),
      );
    });

    test('should return Left(CacheFailure) when local data source fails', () async {
      // Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      when(mockLocalDataSource.readLastJobProfile(1)).thenThrow(CacheException());

      // Act
      final result = await repository.readJobProfile(1);

      // Assert
      verify(mockLocalDataSource.readLastJobProfile(1));
      expect(result, isA<Left<Failure, JobProfile>>());
      result.fold(
        (failure) => expect(failure, isA<CacheFailure>()),
        (_) => fail('Expected a Left containing CacheFailure'),
      );
    });
  });

  group('updateJobProfile', () {
    test('should return Left(NetworkFailure) when device is offline', () async {
      // Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      // Act
      final result = await repository.updateJobProfile(tJobProfile);

      // Assert
      verifyNever(mockRemoteDataSource.updateJobProfile(any));
      expect(result, equals(Left(NetworkFailure())));
    });
  });

  group('deleteJobProfile', () {
    test('should return Right(int) when remote data source succeeds', () async {
      // Arrange
      when(mockRemoteDataSource.deleteJobProfile(1)).thenAnswer((_) async => 1);

      // Act
      final result = await repository.deleteJobProfile(tJobProfile);

      // Assert
      verify(mockRemoteDataSource.deleteJobProfile(1));
      expect(result, equals(Right(1)));
    });

    test('should return Left(ServerFailure) when remote data source fails', () async {
      // Arrange
      when(mockRemoteDataSource.deleteJobProfile(1)).thenThrow(ServerException());

      // Act
      final result = await repository.deleteJobProfile(tJobProfile);

      // Assert
      verify(mockRemoteDataSource.deleteJobProfile(1));
      expect(result, isA<Left<Failure, int>>());
      result?.fold(
        (failure) => expect(failure, isA<ServerFailure>()),
        (_) => fail('Expected a Left containing ServerFailure'),
      );
    });
  });
}
