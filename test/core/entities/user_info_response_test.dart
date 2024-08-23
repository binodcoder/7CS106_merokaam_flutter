import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:merokaam/core/entities/user_info_response.dart';

void main() {
  group('UserInfoResponse', () {
    test('Should correctly initialize fields via constructor', () {
      final userInfo = UserInfoResponse(
        id: 1,
        jwtToken: 'some.jwt.token',
        username: 'user123',
        userTypeName: 'admin',
      );

      expect(userInfo.id, 1);
      expect(userInfo.jwtToken, 'some.jwt.token');
      expect(userInfo.username, 'user123');
      expect(userInfo.userTypeName, 'admin');
    });

    test('Should correctly parse from JSON', () {
      const jsonString = '{"id": 1, "jwtToken": "some.jwt.token", "username": "user123", "userTypeName": "admin"}';
      final userInfo = userInfoResponseFromJson(jsonString);

      expect(userInfo.id, 1);
      expect(userInfo.jwtToken, 'some.jwt.token');
      expect(userInfo.username, 'user123');
      expect(userInfo.userTypeName, 'admin');
    });

    test('Should correctly serialize to JSON', () {
      final userInfo = UserInfoResponse(
        id: 1,
        jwtToken: 'some.jwt.token',
        username: 'user123',
        userTypeName: 'admin',
      );
      final jsonMap = userInfo.toJson();

      expect(jsonMap, {
        'id': 1,
        'jwtToken': 'some.jwt.token',
        'username': 'user123',
        'userTypeName': 'admin',
      });
    });

    test('Should throw error if required fields are missing in JSON', () {
      const jsonString = '{"id": 1, "jwtToken": "some.jwt.token", "username": "user123"}'; // Missing userTypeName

      expect(() => userInfoResponseFromJson(jsonString), throwsA(isA<TypeError>()));
    });

    test('Should handle empty strings for jwtToken, username, and userTypeName', () {
      final userInfo = UserInfoResponse(
        id: 1,
        jwtToken: '',
        username: '',
        userTypeName: '',
      );
      final jsonMap = userInfo.toJson();

      expect(userInfo.jwtToken, '');
      expect(userInfo.username, '');
      expect(userInfo.userTypeName, '');
      expect(jsonMap, {
        'id': 1,
        'jwtToken': '',
        'username': '',
        'userTypeName': '',
      });
    });

    test('Should handle large integers for id', () {
      final userInfo = UserInfoResponse(
        id: 9223372036854775807, // Max value for a signed 64-bit integer
        jwtToken: 'some.jwt.token',
        username: 'user123',
        userTypeName: 'admin',
      );
      final jsonMap = userInfo.toJson();

      expect(userInfo.id, 9223372036854775807);
      expect(jsonMap['id'], 9223372036854775807);
    });

    test('Should handle additional fields in JSON', () {
      const jsonString = '{"id": 1, "jwtToken": "some.jwt.token", "username": "user123", "userTypeName": "admin", "extra_field": "extra_value"}';
      final userInfo = userInfoResponseFromJson(jsonString);

      expect(userInfo.id, 1);
      expect(userInfo.jwtToken, 'some.jwt.token');
      expect(userInfo.username, 'user123');
      expect(userInfo.userTypeName, 'admin');
    });

    test('Should handle incorrect data types in JSON', () {
      const jsonString = '{"id": "one", "jwtToken": 123, "username": true, "userTypeName": []}';

      expect(() => userInfoResponseFromJson(jsonString), throwsA(isA<TypeError>()));
    });

    test('Should handle null values in JSON gracefully', () {
      const jsonString = '{"id": null, "jwtToken": null, "username": null, "userTypeName": null}';

      final parsedJson = json.decode(jsonString);
      expect(() => UserInfoResponse.fromJson(parsedJson), throwsA(isA<TypeError>()));
    });

    test('Should throw error when id is missing in JSON', () {
      const jsonString = '{"jwtToken": "some.jwt.token", "username": "user123", "userTypeName": "admin"}'; // Missing id

      expect(() => userInfoResponseFromJson(jsonString), throwsA(isA<TypeError>()));
    });

    test('toJson should generate correct map', () {
      final userInfo = UserInfoResponse(
        id: 1,
        jwtToken: 'some.jwt.token',
        username: 'user123',
        userTypeName: 'admin',
      );
      final jsonMap = userInfo.toJson();

      expect(jsonMap, {
        'id': 1,
        'jwtToken': 'some.jwt.token',
        'username': 'user123',
        'userTypeName': 'admin',
      });
    });

    test('fromJson should create UserInfoResponse from valid map', () {
      final jsonMap = {
        'id': 1,
        'jwtToken': 'some.jwt.token',
        'username': 'user123',
        'userTypeName': 'admin',
      };
      final userInfo = UserInfoResponse.fromJson(jsonMap);

      expect(userInfo.id, 1);
      expect(userInfo.jwtToken, 'some.jwt.token');
      expect(userInfo.username, 'user123');
      expect(userInfo.userTypeName, 'admin');
    });
  });
}
