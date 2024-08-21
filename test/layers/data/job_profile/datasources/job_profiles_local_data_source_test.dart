import 'dart:convert';
import 'package:merokaam/core/db/db_helper.dart';
import 'package:merokaam/core/errors/exceptions.dart';
import 'package:merokaam/core/models/job_profile_model.dart';
import 'package:merokaam/layers/data/job_profile/data_sources/job_profile_local_data_source.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../../fixtures/fixture_reader.dart';
import 'job_profile_local_data_source_test.mocks.dart';

@GenerateMocks([
  DatabaseHelper
], customMocks: [
  MockSpec<DatabaseHelper>(as: #MockDatabaseHelperForTest, onMissingStub: OnMissingStub.returnDefault),
])
void main() {
  late JobProfilesLocalDataSourceImpl dataSource;
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    dataSource = JobProfilesLocalDataSourceImpl(mockDatabaseHelper);
  });

  group('getLastJobProfile', () {
    final tJobProfileModel = JobProfileModel.fromJson(json.decode(fixture('JobProfile_cached.json')));
    // const tJobProfileModel = null;
    test('should return JobProfile from Local db when there is one in the cache', () async {
      //arrange
      when(await mockDatabaseHelper.readJobProfiles()).thenReturn([tJobProfileModel]);
      //act
      final result = await dataSource.readLastJobProfiles();
      //assert
      verify(mockDatabaseHelper.readJobProfiles());
      expect(result, equals(tJobProfileModel));
    });

    test('should throw a CacheException when there is not a cached value', () async {
      //arrange
      when(await mockDatabaseHelper.readJobProfiles()).thenReturn([tJobProfileModel]);
      //act
      final call = dataSource.readLastJobProfiles;
      //assert
      expect(() => call(), throwsA(const TypeMatcher<CacheException>()));
    });
  });

  group('cacheJobProfileModel', () {
    final tJobProfileModel = JobProfileModel(
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
    );
    test('should call local db to cache the data', () async {
      //act
      dataSource.cacheJobProfile(tJobProfileModel);
      //assert
      //final expectedJsonString = json.encode(tJobProfileModel.toJson());
      verify(mockDatabaseHelper.insertJobProfile(tJobProfileModel));
    });
  });
}
