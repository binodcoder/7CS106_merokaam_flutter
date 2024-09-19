import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:merokaam/core/entities/job_profile.dart';
import 'package:merokaam/core/errors/exceptions.dart';
import 'package:merokaam/core/errors/failures.dart';
import 'package:merokaam/core/models/job_profile_model.dart';
import 'package:merokaam/layers/data/job_profile/repositories/job_profile_repository_impl.dart';
import 'package:mockito/annotations.dart';
import 'package:merokaam/layers/data/job_profile/data_sources/job_profile_local_data_source.dart';
import 'package:merokaam/layers/data/job_profile/data_sources/job_profile_remote_data_sources.dart';
import 'package:merokaam/core/network/network_info.dart';
import 'package:mockito/mockito.dart';

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
      jobProfilesLocalDataSource: mockLocalDataSource,
      jobProfileRemoteDataSources: mockRemoteDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  final tJobProfileModel = JobProfileModel(
    userAccountId: 1,
    firstName: 'John',
    lastName: 'Doe',
    city: 'City',
    state: 'State',
    country: 'Country',
    workAuthorization: 'Authorization',
    employmentType: 'Full-time',
    resume: 'Resume',
    profilePhoto: 'Photo',
    photosImagePath: 'Path',
    duration: 0.1,
  );

  final tJobProfile = JobProfile(
    userAccountId: 1,
    firstName: 'John',
    lastName: 'Doe',
    city: 'City',
    state: 'State',
    country: 'Country',
    workAuthorization: 'Authorization',
    employmentType: 'Full-time',
    resume: 'Resume',
    profilePhoto: 'Photo',
    photosImagePath: 'Path',
    duration: 0.1,
  );

  final tJobProfileList = [tJobProfile];

  group('createJobProfile', () {
    test('should return Right when the call to remote data source is successful', () async {
      // Arrange
      when(mockRemoteDataSource.createJobProfile(any)).thenAnswer((_) async => 1);

      // Act
      final result = await repository.createJobProfile(tJobProfile);

      // Assert
      expect(result, const Right(1));
      verify(mockRemoteDataSource.createJobProfile(any));
      verifyNoMoreInteractions(mockRemoteDataSource);
    });

    test('should return Left(CacheFailure) when the call to remote data source fails', () async {
      // Arrange
      when(mockRemoteDataSource.createJobProfile(any)).thenThrow(CacheException());

      // Act
      final result = await repository.createJobProfile(tJobProfile);

      // Assert
      expect(result, Left(CacheFailure()));
      verify(mockRemoteDataSource.createJobProfile(any));
      verifyNoMoreInteractions(mockRemoteDataSource);
    });
  });

  group('readJobProfiles', () {
    test('should return Right with data from remote data source when there is internet connection', () async {
      // Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.readJobProfile(1)).thenAnswer((_) async => tJobProfileModel);

      // Act
      final result = await repository.readJobProfile(1);

      // Assert
      // expect(result, Right<Failure, List<JobProfile>>([tJobProfileModel] as List<JobProfile>));
      expect(result, isA<Right<Failure, List<JobProfile>>>());

      verify(mockNetworkInfo.isConnected);
      verify(mockRemoteDataSource.readJobProfile(1));
      verifyNoMoreInteractions(mockNetworkInfo);
      verifyNoMoreInteractions(mockRemoteDataSource);
    });

    test('should return Right with data from local data source when there is no internet connection', () async {
      // Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      when(mockLocalDataSource.readLastJobProfile()).thenAnswer((_) async => tJobProfileModel);

      // Act
      final result = await repository.readJobProfile(1);

      // Assert
      //expect(result, Right(tJobProfileList));
      expect(result, isA<Right<Failure, List<JobProfile>>>());
      verify(mockNetworkInfo.isConnected);
      verify(mockLocalDataSource.readLastJobProfile());
      verifyNoMoreInteractions(mockNetworkInfo);
      verifyNoMoreInteractions(mockLocalDataSource);
    });

    test('should return Left(CacheFailure) when both remote and local data sources fail', () async {
      // Arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.readJobProfile(1)).thenThrow(CacheException());

      // Act
      final result = await repository.readJobProfile(1);

      // Assert
      expect(result, const Left(CacheFailure()));
      verify(mockNetworkInfo.isConnected);
      verify(mockRemoteDataSource.readJobProfile(1));
      verifyNoMoreInteractions(mockNetworkInfo);
      verifyNoMoreInteractions(mockRemoteDataSource);
    });
  });

  group('updateJobProfile', () {
    test('should return Right when the call to remote data source is successful', () async {
      // Arrange
      when(mockRemoteDataSource.updateJobProfile(any)).thenAnswer((_) async => 1);

      // Act
      final result = await repository.updateJobProfile(tJobProfile);

      // Assert
      expect(result, const Right(1));
      verify(mockRemoteDataSource.updateJobProfile(any));
      verifyNoMoreInteractions(mockRemoteDataSource);
    });

    test('should return Left(CacheFailure) when the call to remote data source fails', () async {
      // Arrange
      when(mockRemoteDataSource.updateJobProfile(any)).thenThrow(CacheException());

      // Act
      final result = await repository.updateJobProfile(tJobProfile);

      // Assert
      expect(result, const Left(CacheFailure()));
      verify(mockRemoteDataSource.updateJobProfile(any));
      verifyNoMoreInteractions(mockRemoteDataSource);
    });
  });

  group('deleteJobProfile', () {
    test('should return Right when the call to remote data source is successful', () async {
      // Arrange
      when(mockRemoteDataSource.deleteJobProfile(any)).thenAnswer((_) async => 1);

      // Act
      final result = await repository.deleteJobProfile(tJobProfile);

      // Assert
      expect(result, const Right(1));
      verify(mockRemoteDataSource.deleteJobProfile(any));
      verifyNoMoreInteractions(mockRemoteDataSource);
    });

    test('should return Left(CacheFailure) when the call to remote data source fails', () async {
      // Arrange
      when(mockRemoteDataSource.deleteJobProfile(any)).thenThrow(CacheException());

      // Act
      final result = await repository.deleteJobProfile(tJobProfile);

      // Assert
      expect(result, Left(CacheFailure()));
      verify(mockRemoteDataSource.deleteJobProfile(any));
      verifyNoMoreInteractions(mockRemoteDataSource);
    });
  });
}
