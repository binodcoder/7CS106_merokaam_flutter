import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:merokaam/core/errors/exceptions.dart';
import 'package:merokaam/core/models/job_profile_model.dart';
import 'package:merokaam/layers/data/job_profile/data_sources/job_profile_remote_data_sources.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'job_profile_remote_data_sources_test.mocks.dart';

@GenerateMocks([http.Client, SharedPreferences])
void main() {
  late JobProfileRemoteDataSourceImpl dataSource;
  late MockClient mockHttpClient;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockHttpClient = MockClient();
    mockSharedPreferences = MockSharedPreferences();
    dataSource = JobProfileRemoteDataSourceImpl(
      client: mockHttpClient,
      sharedPreferences: mockSharedPreferences,
    );
  });

  group('readJobProfile', () {
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

    test('should perform a GET request and return JobProfileModel when successful', () async {
      // Arrange
      when(mockSharedPreferences.getString('jwt_token')).thenReturn('valid_jwt_token;');

      when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
        (_) async => http.Response(json.encode(tJobProfileModel.toJson()), 200),
      );

      // Act
      final result = await dataSource.readJobProfile(1);

      // Assert
      expect(result.userAccountId, equals(tJobProfileModel.userAccountId));
      verify(mockHttpClient.get(any, headers: anyNamed('headers')));
    });

    test('should throw UnauthorizedException when the response code is 401', () async {
      // Arrange
      when(mockSharedPreferences.getString('jwt_token')).thenReturn('valid_jwt_token;');
      when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
        (_) async => http.Response('Unauthorized', 401),
      );

      // Act & Assert
      expect(() => dataSource.readJobProfile(1), throwsA(isA<UnauthorizedException>()));
    });

    test('should throw ServerException when the response code is 500 or other', () async {
      // Arrange
      when(mockSharedPreferences.getString('jwt_token')).thenReturn('valid_jwt_token;');
      when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
        (_) async => http.Response('Server Error', 500),
      );

      // Act & Assert
      expect(() => dataSource.readJobProfile(1), throwsA(isA<ServerException>()));
    });
  });

  group('createJobProfile', () {
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

    test('should perform a POST request and return 1 when successful', () async {
      // Arrange
      when(mockSharedPreferences.getString('jwt_token')).thenReturn('valid_jwt_token;');
      when(mockHttpClient.post(any, headers: anyNamed('headers'), body: anyNamed('body'))).thenAnswer((_) async => http.Response('Success', 200));

      // Act
      final result = await dataSource.createJobProfile(tJobProfileModel);

      // Assert
      expect(result, equals(1));
      verify(mockHttpClient.post(any, headers: anyNamed('headers'), body: anyNamed('body')));
    });

    test('should throw UnauthorizedException when the response code is 401', () async {
      // Arrange
      when(mockSharedPreferences.getString('jwt_token')).thenReturn('valid_jwt_token;');
      when(mockHttpClient.post(any, headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response('Unauthorized', 401));

      // Act & Assert
      expect(() => dataSource.createJobProfile(tJobProfileModel), throwsA(isA<UnauthorizedException>()));
    });
  });

  // Similarly, write tests for updateJobProfile and deleteJobProfile methods
}
