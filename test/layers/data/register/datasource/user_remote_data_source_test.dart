import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:merokaam/core/errors/exceptions.dart';
import 'package:merokaam/core/models/user_model.dart';
import 'package:merokaam/layers/data/register/datasources/user_remote_data_source.dart';
import 'package:merokaam/resources/url.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../job_profile/datasources/job_profile_remote_data_sources_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late UserRemoteDataSourceImpl dataSource;
  late MockClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockClient();
    dataSource = UserRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('addUser', () {
    final tUserModel = UserModel(
      id: 1,
      email: 'test@example.com',
      password: 'password123',
    );

    void setUpMockHttpClientSuccess200() {
      when(mockHttpClient.post(
        any,
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response(
            '',
            200,
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
            },
          ));
    }

    void setUpMockHttpClientSuccess201() {
      when(mockHttpClient.post(
        any,
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response(
            '',
            201,
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
            },
          ));
    }

    test('should perform a POST request with the correct URL and headers', () async {
      // Arrange
      setUpMockHttpClientSuccess200();

      // Act
      await dataSource.addUser(tUserModel);

      // Assert
      verify(mockHttpClient.post(
        Uri.parse(AppUrl.signup),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(tUserModel.toMap()),
      ));
    });

    test('should return 1 when the response code is 200', () async {
      // Arrange
      setUpMockHttpClientSuccess200();

      // Act
      final result = await dataSource.addUser(tUserModel);

      // Assert
      expect(result, equals(1));
    });

    test('should return 1 when the response code is 201', () async {
      // Arrange
      setUpMockHttpClientSuccess201();

      // Act
      final result = await dataSource.addUser(tUserModel);

      // Assert
      expect(result, equals(1));
    });

    test('should throw BadRequestException when the response code is 400', () async {
      // Arrange
      when(mockHttpClient.post(any, headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response('{"message": "Bad Request"}', 400));

      // Act
      final call = dataSource.addUser;

      // Assert
      expect(() => call(tUserModel), throwsA(isA<BadRequestException>()));
    });

    test('should throw UnauthorizedException when the response code is 401', () async {
      // Arrange
      when(mockHttpClient.post(any, headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response('{"message": "Unauthorized"}', 401));

      // Act
      final call = dataSource.addUser;

      // Assert
      expect(() => call(tUserModel), throwsA(isA<UnauthorizedException>()));
    });

    test('should throw UnauthorizedException when the response code is 403', () async {
      // Arrange
      when(mockHttpClient.post(any, headers: anyNamed('headers'), body: anyNamed('body'))).thenAnswer((_) async => http.Response('Forbidden', 403));

      // Act
      final call = dataSource.addUser;

      // Assert
      expect(() => call(tUserModel), throwsA(isA<UnauthorizedException>()));
    });

    test('should throw NotFoundException when the response code is 404', () async {
      // Arrange
      when(mockHttpClient.post(any, headers: anyNamed('headers'), body: anyNamed('body'))).thenAnswer((_) async => http.Response('Not Found', 404));

      // Act
      final call = dataSource.addUser;

      // Assert
      expect(() => call(tUserModel), throwsA(isA<NotFoundException>()));
    });

    test('should throw CustomTimeoutException when the response code is 408', () async {
      // Arrange
      when(mockHttpClient.post(any, headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response('Request Timeout', 408));

      // Act
      final call = dataSource.addUser;

      // Assert
      expect(() => call(tUserModel), throwsA(isA<CustomTimeoutException>()));
    });

    test('should throw ServerException when the response code is 500', () async {
      // Arrange
      when(mockHttpClient.post(any, headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response('Internal Server Error', 500));

      // Act
      final call = dataSource.addUser;

      // Assert
      expect(() => call(tUserModel), throwsA(isA<ServerException>()));
    });

    test('should throw UnknownException for unexpected status codes', () async {
      // Arrange
      when(mockHttpClient.post(any, headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response('Unexpected Error', 520));

      // Act
      final call = dataSource.addUser;

      // Assert
      expect(() => call(tUserModel), throwsA(isA<UnknownException>()));
    });

    test('should throw NetworkException when there is a SocketException', () async {
      // Arrange
      when(mockHttpClient.post(any, headers: anyNamed('headers'), body: anyNamed('body'))).thenThrow(SocketException('No Internet'));

      // Act
      final call = dataSource.addUser;

      // Assert
      expect(() => call(tUserModel), throwsA(isA<NetworkException>()));
    });

    test('should throw CustomTimeoutException when there is a TimeoutException', () async {
      // Arrange
      when(mockHttpClient.post(any, headers: anyNamed('headers'), body: anyNamed('body'))).thenThrow(TimeoutException('Request Timed Out'));

      // Act
      final call = dataSource.addUser;

      // Assert
      expect(() => call(tUserModel), throwsA(isA<CustomTimeoutException>()));
    });

    test('should throw DataFormatException when there is a FormatException', () async {
      // Arrange
      when(mockHttpClient.post(any, headers: anyNamed('headers'), body: anyNamed('body'))).thenThrow(FormatException('Invalid Format'));

      // Act
      final call = dataSource.addUser;

      // Assert
      expect(() => call(tUserModel), throwsA(isA<DataFormatException>()));
    });

    test('should throw UnknownException for any other exceptions', () async {
      // Arrange
      when(mockHttpClient.post(any, headers: anyNamed('headers'), body: anyNamed('body'))).thenThrow(Exception('Unknown Error'));

      // Act
      final call = dataSource.addUser;

      // Assert
      expect(() => call(tUserModel), throwsA(isA<UnknownException>()));
    });
  });
}
