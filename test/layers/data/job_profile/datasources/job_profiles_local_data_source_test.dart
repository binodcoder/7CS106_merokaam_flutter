import 'package:flutter_test/flutter_test.dart';
import 'package:merokaam/layers/data/job_profile/data_sources/job_profile_local_data_source.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:merokaam/core/db/db_helper.dart';
import 'package:merokaam/core/errors/exceptions.dart';
import 'package:merokaam/core/models/job_profile_model.dart';

import 'job_profiles_local_data_source_test.mocks.dart';

@GenerateMocks([DatabaseHelper])
void main() {
  late JobProfilesLocalDataSourceImpl dataSource;
  late MockDatabaseHelper mockDbHelper;

  setUp(() {
    mockDbHelper = MockDatabaseHelper();
    dataSource = JobProfilesLocalDataSourceImpl(mockDbHelper);
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

    test('should call DatabaseHelper to update job profile when caching', () async {
      // arrange
      when(mockDbHelper.updateJobProfile(any)).thenAnswer((_) async => 1);
      // act
      final result = await dataSource.cacheJobProfile(tJobProfileModel);
      // assert
      verify(mockDbHelper.updateJobProfile(tJobProfileModel));
      expect(result, equals(1));
    });

    test('should throw ArgumentException if userAccountId is null', () async {
      // arrange
      final tInvalidJobProfile = tJobProfileModel.copyWith(userAccountId: null);
      // act
      expect(() => dataSource.cacheJobProfile(tInvalidJobProfile), throwsA(isA<ArgumentException>()));
      // assert
      verifyNever(mockDbHelper.updateJobProfile(any));
    });

    test('should throw CacheException when there is an unexpected error', () async {
      // arrange
      when(mockDbHelper.updateJobProfile(any)).thenThrow(Exception());
      // act
      expect(() => dataSource.cacheJobProfile(tJobProfileModel), throwsA(isA<CacheException>()));
      // assert
      verify(mockDbHelper.updateJobProfile(tJobProfileModel));
    });

    test('should insert a new job profile if NotFoundException occurs', () async {
      // arrange
      when(mockDbHelper.updateJobProfile(any)).thenThrow(NotFoundException());
      when(mockDbHelper.insertJobProfile(any)).thenAnswer((_) async => 1);
      // act
      final result = await dataSource.cacheJobProfile(tJobProfileModel);
      // assert
      verify(mockDbHelper.insertJobProfile(tJobProfileModel));
      expect(result, equals(1));
    });
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

    test('should return JobProfileModel when the data is found', () async {
      // arrange
      when(mockDbHelper.readJobProfile(any)).thenAnswer((_) async => tJobProfileModel);
      // act
      final result = await dataSource.readLastJobProfile(1);
      // assert
      verify(mockDbHelper.readJobProfile(1));
      expect(result, equals(tJobProfileModel));
    });

    test('should throw NotFoundException when the profile is not found', () async {
      // arrange
      when(mockDbHelper.readJobProfile(any)).thenThrow(NotFoundException());
      // act
      expect(() => dataSource.readLastJobProfile(1), throwsA(isA<NotFoundException>()));
      // assert
      verify(mockDbHelper.readJobProfile(1));
    });

    test('should throw CacheException for unexpected errors', () async {
      // arrange
      when(mockDbHelper.readJobProfile(any)).thenThrow(Exception());
      // act
      expect(() => dataSource.readLastJobProfile(1), throwsA(isA<CacheException>()));
      // assert
      verify(mockDbHelper.readJobProfile(1));
    });
  });
}
