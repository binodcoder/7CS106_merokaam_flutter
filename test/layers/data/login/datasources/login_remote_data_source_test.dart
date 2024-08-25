import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

import 'package:merokaam/layers/data/login/datasources/login_remote_data_source.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:merokaam/core/entities/login.dart';
import 'package:merokaam/core/entities/user_info_response.dart';
import 'package:merokaam/core/errors/exceptions.dart';

import 'login_remote_data_source_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late LoginRemoteDataSourceImpl dataSource;
  late MockClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockClient();
    dataSource = LoginRemoteDataSourceImpl(client: mockHttpClient);
  });

  final tLoginModel = LoginModel(email: 'test@test.com', password: 'password123');
  final tUserInfoResponse = UserInfoResponse(
    id: 1,
    jwtToken: 'token123',
    username: 'testuser',
    userTypeName: 'User',
  );
  final tUrl = "http://192.168.1.180:8080/api/auth/signin";
  final tResponseBody = '{"id": 1, "jwtToken": "token123", "username": "testuser", "userTypeName": "User"}';

  group('login', () {
    test('should perform a POST request with the correct URL and headers', () async {
      // Arrange
      when(mockHttpClient.post(any, headers: anyNamed('headers'), body: anyNamed('body'))).thenAnswer((_) async => http.Response(tResponseBody, 200));

      // Act
      await dataSource.login(tLoginModel);

      // Assert
      verify(mockHttpClient.post(
        Uri.parse(tUrl),
        headers: {'Content-Type': 'application/json'},
        body: loginModelToJson(tLoginModel),
      ));
    });

    test('should return UserInfoResponse when the response code is 200 (success)', () async {
      // Arrange
      when(mockHttpClient.post(any, headers: anyNamed('headers'), body: anyNamed('body'))).thenAnswer((_) async => http.Response(tResponseBody, 200));

      // Act
      final result = await dataSource.login(tLoginModel);

      // Assert
      expect(result, isA<UserInfoResponse>());
    });

    test('should throw LoginException when the response code is not 200', () async {
      // Arrange
      when(mockHttpClient.post(any, headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => http.Response('Something went wrong', 404));

      // Act
      final call = dataSource.login;

      // Assert
      expect(() => call(tLoginModel), throwsA(isA<LoginException>()));
    });
  });
}
