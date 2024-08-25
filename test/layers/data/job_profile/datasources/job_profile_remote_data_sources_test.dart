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

  // Test Data
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

  final tJobProfileModelJson = jsonEncode(tJobProfileModel.toJson());
  final tJobProfileList = [tJobProfileModel];
  final tResponseBody = jsonEncode(tJobProfileList.map((model) => model.toJson()).toList());

  group('createJobProfile', () {
    test('should return 1 when the response code is 201 (success)', () async {
      // Arrange
      when(mockHttpClient.post(any, headers: anyNamed('headers'), body: anyNamed('body'))).thenAnswer((_) async => http.Response('', 201));

      // Act
      final result = await dataSource.createJobProfile(tJobProfileModel);

      // Assert
      expect(result, equals(1));
    });

    test('should throw ServerException when the response code is not 201', () async {
      // Arrange
      when(mockHttpClient.post(any, headers: anyNamed('headers'), body: anyNamed('body'))).thenAnswer((_) async => http.Response('', 400));

      // Act
      final call = dataSource.createJobProfile(tJobProfileModel);

      // Assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('readJobProfile', () {
    test('should return a list of JobProfileModel when the response code is 200 (success)', () async {
      // Arrange
      when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer((_) async => http.Response(tResponseBody, 200));

      when(mockSharedPreferences.getString("jwt_token")).thenReturn('token;');

      // Act
      final result = await dataSource.readJobProfile();

      // Assert
      expect(result, isA<List<JobProfileModel>>());
    });

    test('should throw ServerException when the response code is not 200', () async {
      // Arrange
      when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer((_) async => http.Response('', 404));

      when(mockSharedPreferences.getString("jwt_token")).thenReturn('token;');

      // Act
      final call = dataSource.readJobProfile();

      // Assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('updateJobProfile', () {
    test('should return 1 when the response code is 200 (success)', () async {
      // Arrange
      when(mockHttpClient.put(any, headers: anyNamed('headers'), body: anyNamed('body'))).thenAnswer((_) async => http.Response('', 200));

      // Act
      final result = await dataSource.updateJobProfile(tJobProfileModel);

      // Assert
      expect(result, equals(1));
    });

    test('should throw ServerException when the response code is not 200', () async {
      // Arrange
      when(mockHttpClient.put(any, headers: anyNamed('headers'), body: anyNamed('body'))).thenAnswer((_) async => http.Response('', 400));

      // Act
      final call = dataSource.updateJobProfile(tJobProfileModel);

      // Assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('deleteJobProfile', () {
    test('should return 1 when the response code is 200 (success)', () async {
      // Arrange
      when(mockHttpClient.delete(any, headers: anyNamed('headers'))).thenAnswer((_) async => http.Response('', 200));

      // Act
      final result = await dataSource.deleteJobProfile(1);

      // Assert
      expect(result, equals(1));
    });

    test('should throw ServerException when the response code is not 200', () async {
      // Arrange
      when(mockHttpClient.delete(any, headers: anyNamed('headers'))).thenAnswer((_) async => http.Response('', 400));

      // Act
      final call = dataSource.deleteJobProfile(1);

      // Assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
