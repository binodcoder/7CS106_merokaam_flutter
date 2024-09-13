import 'package:flutter_test/flutter_test.dart';
import 'package:merokaam/core/errors/exceptions.dart';
import 'package:merokaam/core/models/job_profile_model.dart';
import 'package:merokaam/layers/data/job_profile/data_sources/job_profile_local_data_source.dart';
import 'package:mockito/annotations.dart';
import 'package:merokaam/core/db/db_helper.dart';
import 'package:mockito/mockito.dart';
import 'job_profiles_local_data_source_test.mocks.dart';

@GenerateMocks([DatabaseHelper])
void main() {
  late JobProfilesLocalDataSourceImpl dataSource;
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    dataSource = JobProfilesLocalDataSourceImpl(mockDatabaseHelper);
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
  );

  final tJobProfileList = [tJobProfileModel];

  group('readLastJobProfiles', () {
    test('should return a list of JobProfileModel when the call to database is successful', () async {
      // Arrange
      when(mockDatabaseHelper.readJobProfiles()).thenAnswer((_) async => tJobProfileList);

      // Act
      final result = await dataSource.readLastJobProfile(1);

      // Assert
      expect(result, equals(tJobProfileList));
    });

    test('should throw CacheException when the call to database fails', () async {
      // Arrange
      when(mockDatabaseHelper.readJobProfiles()).thenThrow(CacheException());

      // Act
      final call = dataSource.readLastJobProfile(1);

      // Assert
      expect(() => call, throwsA(isA<CacheException>()));
    });
  });

  group('cacheJobProfile', () {
    test('should call dbHelper.insertJobProfile with correct parameters', () async {
      // Arrange
      // No need to mock the return value for this test

      // Act
      await dataSource.cacheJobProfile(tJobProfileModel);

      // Assert
      verify(mockDatabaseHelper.insertJobProfile(tJobProfileModel));
    });

    test('should handle exceptions if dbHelper.insertJobProfile fails', () async {
      // Arrange
      when(mockDatabaseHelper.insertJobProfile(tJobProfileModel)).thenThrow(CacheException());

      // Act
      final call = dataSource.cacheJobProfile(tJobProfileModel);

      // Assert
      expect(() => call, throwsA(isA<CacheException>()));
    });
  });
}
