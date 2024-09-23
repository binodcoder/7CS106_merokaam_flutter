import 'package:flutter_test/flutter_test.dart';
import 'package:merokaam/layers/data/job_profile/data_sources/job_profile_local_data_source.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:merokaam/core/db/db_helper.dart';
import 'package:merokaam/core/errors/exceptions.dart';
import 'package:merokaam/core/errors/failures.dart';
import 'package:merokaam/core/models/job_profile_model.dart';

import 'job_profiles_local_data_source_test.mocks.dart';

@GenerateMocks([DatabaseHelper])
void main() {
  late JobProfilesLocalDataSourceImpl dataSource;
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    dataSource = JobProfilesLocalDataSourceImpl(mockDatabaseHelper);
  });

  group('readLastJobProfile', () {
    final tJobProfileModel = JobProfileModel(
      userAccountId: 1,
      firstName: 'John',
      lastName: 'Doe',
      city: 'City',
      state: 'State',
      country: 'Country',
      workAuthorization: 'Authorized',
      employmentType: 'Full-Time',
      resume: 'Resume Link',
      profilePhoto: 'Profile Photo Link',
      photosImagePath: 'Image Path',
    );

    test('should return JobProfileModel when found in local database', () async {
      // Arrange
      when(mockDatabaseHelper.readJobProfile(any)).thenAnswer((_) async => tJobProfileModel);

      // Act
      final result = await dataSource.readLastJobProfile(1);

      // Assert
      expect(result, equals(tJobProfileModel));
      verify(mockDatabaseHelper.readJobProfile(1));
    });

    test('should throw NotFoundException when job profile is not found', () async {
      // Arrange
      when(mockDatabaseHelper.readJobProfile(any)).thenThrow(NotFoundException());

      // Act & Assert
      expect(() => dataSource.readLastJobProfile(1), throwsA(isA<NotFoundException>()));
      verify(mockDatabaseHelper.readJobProfile(1));
    });

    test('should throw CacheException on unexpected error', () async {
      // Arrange
      when(mockDatabaseHelper.readJobProfile(any)).thenThrow(Exception());

      // Act & Assert
      expect(() => dataSource.readLastJobProfile(1), throwsA(isA<CacheException>()));
    });
  });

  group('cacheJobProfile', () {
    final tJobProfileModel = JobProfileModel(
      userAccountId: 1,
      firstName: 'John',
      lastName: 'Doe',
      city: 'City',
      state: 'State',
      country: 'Country',
      workAuthorization: 'Authorized',
      employmentType: 'Full-Time',
      resume: 'Resume Link',
      profilePhoto: 'Profile Photo Link',
      photosImagePath: 'Image Path',
    );

    test('should update the job profile in local database when it exists', () async {
      // Arrange
      when(mockDatabaseHelper.updateJobProfile(any)).thenAnswer((_) async => 1);

      // Act
      final result = await dataSource.cacheJobProfile(tJobProfileModel);

      // Assert
      expect(result, equals(1));
      verify(mockDatabaseHelper.updateJobProfile(tJobProfileModel));
    });

    test('should insert new job profile when profile is not found', () async {
      // Arrange
      when(mockDatabaseHelper.updateJobProfile(any)).thenThrow(NotFoundException());
      when(mockDatabaseHelper.insertJobProfile(any)).thenAnswer((_) async => 1);

      // Act
      final result = await dataSource.cacheJobProfile(tJobProfileModel);

      // Assert
      expect(result, equals(1));
      verify(mockDatabaseHelper.insertJobProfile(tJobProfileModel));
    });

    test('should throw ArgumentException when userAccountId is null', () async {
      // Arrange
      final invalidJobProfile = JobProfileModel(
        userAccountId: null, // Invalid
        firstName: 'John',
        lastName: 'Doe',
        city: 'City',
        state: 'State',
        country: 'Country',
        workAuthorization: 'Authorized',
        employmentType: 'Full-Time',
        resume: 'Resume Link',
        profilePhoto: 'Profile Photo Link',
        photosImagePath: 'Image Path',
      );

      // Act & Assert
      expect(() => dataSource.cacheJobProfile(invalidJobProfile), throwsA(isA<ArgumentException>()));
    });

    test('should throw CacheException on unexpected error', () async {
      // Arrange
      when(mockDatabaseHelper.updateJobProfile(any)).thenThrow(Exception());

      // Act & Assert
      expect(() => dataSource.cacheJobProfile(tJobProfileModel), throwsA(isA<CacheException>()));
    });
  });
}
