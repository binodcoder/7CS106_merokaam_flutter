import 'package:dartz/dartz.dart';
import 'package:merokaam/core/errors/exceptions.dart';
import 'package:merokaam/core/errors/failures.dart';
import 'package:merokaam/core/models/job_profile_model.dart';
import 'package:merokaam/core/network/network_info.dart';
import 'package:merokaam/layers/data/job_profile/data_sources/job_profile_local_data_source.dart';
import 'package:merokaam/layers/data/job_profile/data_sources/job_profile_remote_data_sources.dart';
import 'package:merokaam/layers/data/job_profile/repositories/job_profile_repository_impl.dart';

import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import 'job_profile_repositories_impl_test.mocks.dart';

class MockJobProfileLocalDataSource extends Mock implements JobProfilesLocalDataSource {}

@GenerateMocks([NetworkInfo])
@GenerateMocks([
  JobProfileRemoteDataSource
], customMocks: [
  MockSpec<JobProfileRemoteDataSource>(as: #MockJobProfileRemoteDataSourceForTest, onMissingStub: OnMissingStub.returnDefault),
])
void main() {
  late JobProfileRepositoryImpl repository;
  late MockJobProfileRemoteDataSource mockRemoteDataSource;
  late MockJobProfileLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockJobProfileRemoteDataSource();
    mockLocalDataSource = MockJobProfileLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = JobProfileRepositoryImpl(
      jobProfileRemoteDataSources: mockRemoteDataSource,
      jobProfilesLocalDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  void runTestsOnline(Function body) {
    group('device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });
      body();
    });
  }

  group('readJobProfile', () {
    final tJobProfileModel = [
      JobProfileModel(
        userAccountId: 0,
        firstName: '',
        lastName: '',
        city: '',
        state: '',
        country: '',
        workAuthorization: '',
        employmentType: '',
        resume: '',
        profilePhoto: '',
        photosImagePath: '',
      )
    ];

    test('should check if the device is online', () async {
      //arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      //act
      repository.readJobProfiles();
      //assert
      verify(mockNetworkInfo.isConnected);
    });

    runTestsOnline(() {
      test('should return remote data when the call to remote data source is successful', () async {
        //arrange
        when(mockRemoteDataSource.readJobProfile()).thenAnswer((_) async => tJobProfileModel);
        //act
        final result = await repository.readJobProfiles();
        //assert
        verify(mockRemoteDataSource.readJobProfile());
        expect(result, equals(Right(tJobProfileModel)));
      });
      test('should cache the data locally when the call to remote data source is successful', () async {
        //arrange
        when(mockRemoteDataSource.readJobProfile()).thenAnswer((_) async => tJobProfileModel);
        //act
        await repository.readJobProfiles();
        //assert
        verify(mockRemoteDataSource.readJobProfile());
        // verify(mockLocalDataSource.cacheNumberTrivia(tNumberTriviaModel));
      });
      test('should return serverfailure when the call to remote data source is successful', () async {
        //arrange
        when(mockRemoteDataSource.readJobProfile()).thenThrow(ServerException());
        //act
        final result = await repository.readJobProfiles();
        //assert
        verify(mockRemoteDataSource.readJobProfile());
        verifyZeroInteractions(mockLocalDataSource);
        expect(result, equals(Left(ServerFailure())));
      });
    });
  });
}
