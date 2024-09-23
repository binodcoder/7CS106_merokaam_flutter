import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

import 'package:merokaam/layers/data/login/datasources/login_remote_data_source.dart';
import 'package:merokaam/resources/url.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:merokaam/core/entities/login.dart';
import 'package:merokaam/core/entities/user_info_response.dart';
import 'package:merokaam/core/errors/exceptions.dart';

import 'login_remote_data_source_test.mocks.dart';

import 'dart:convert';
import 'dart:io';

@GenerateMocks([http.Client])
void main() {
  late LoginRemoteDataSourceImpl dataSource;
  late MockClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockClient();
    dataSource = LoginRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('login', () {
    final tLoginModel = LoginModel(
      email: 'test@example.com',
      password: 'password123',
    );

    final tUserInfoResponse = UserInfoResponse(
      id: 1,
      jwtToken: '',
      username: '',
      userTypeName: '',
    );

    void setUpMockHttpClientSuccess200() {
      when(mockHttpClient.post(
        any,
        headers: anyNamed('headers'),
        body: anyNamed('body'),
      )).thenAnswer((_) async => http.Response(
            json.encode(tUserInfoResponse.toJson()),
            200,
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json; charset=utf-8',
            },
          ));
    }

    test('should perform a POST request with the correct URL and headers', () async {
      // Arrange
      setUpMockHttpClientSuccess200();

      // Act
      await dataSource.login(tLoginModel);

      // Assert
      verify(mockHttpClient.post(
        Uri.parse(AppUrl.signin),
        headers: {'Content-Type': 'application/json'},
        body: loginModelToJson(tLoginModel),
      ));
    });

    test('should return UserInfoResponse when the response code is 200 (success)', () async {
      // Arrange
      setUpMockHttpClientSuccess200();

      // Act
      final result = await dataSource.login(tLoginModel);

      // Assert
      expect(result, isA<UserInfoResponse>());
    });

    test('should throw BadRequestException when the response code is 400', () async {
      // Arrange
      when(mockHttpClient.post(any, headers: anyNamed('headers'), body: anyNamed('body'))).thenAnswer((_) async => http.Response('Bad Request', 400));

      // Act
      final call = dataSource.login;

      // Assert
      expect(() => call(tLoginModel), throwsA(isA<BadRequestException>()));
    });

    test('should throw UnauthorizedException when the response code is 401', () async {
      // Arrange
      when(mockHttpClient.post(any, headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response('Unauthorized', 401));

      // Act
      final call = dataSource.login;

      // Assert
      expect(() => call(tLoginModel), throwsA(isA<UnauthorizedException>()));
    });

    test('should throw ServerException when the response code is 500', () async {
      // Arrange
      when(mockHttpClient.post(any, headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response('Server Error', 500));

      // Act
      final call = dataSource.login;

      // Assert
      expect(() => call(tLoginModel), throwsA(isA<ServerException>()));
    });

    test('should throw NetworkException when there is a SocketException', () async {
      // Arrange
      when(mockHttpClient.post(any, headers: anyNamed('headers'), body: anyNamed('body'))).thenThrow(SocketException('No Internet'));

      // Act
      final call = dataSource.login;

      // Assert
      expect(() => call(tLoginModel), throwsA(isA<NetworkException>()));
    });

    test('should throw TimeoutException when there is a TimeoutException', () async {
      // Arrange
      when(mockHttpClient.post(any, headers: anyNamed('headers'), body: anyNamed('body'))).thenThrow(TimeoutException('Request Timed Out'));

      // Act
      final call = dataSource.login;

      // Assert
      expect(() => call(tLoginModel), throwsA(isA<TimeoutException>()));
    });

    test('should throw UnknownException for any other exceptions', () async {
      // Arrange
      when(mockHttpClient.post(any, headers: anyNamed('headers'), body: anyNamed('body'))).thenThrow(Exception('Unknown Error'));

      // Act
      final call = dataSource.login;

      // Assert
      expect(() => call(tLoginModel), throwsA(isA<UnknownException>()));
    });
  });
}

// test('should return UserInfoResponse when the response code is 200 (success)', () async {
// // Arrange
// when(mockHttpClient.post(any, headers: anyNamed('headers'), body: anyNamed('body'))).thenAnswer((_) async => http.Response(tResponseBody, 200));
//
// // Act
// final result = await dataSource.login(tLoginModel);
//
// // Assert
// expect(result, isA<UserInfoResponse>());
// });
