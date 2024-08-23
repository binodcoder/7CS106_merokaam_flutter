import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:merokaam/core/entities/login.dart';

void main() {
  group('LoginModel', () {
    test('Should correctly initialize fields via constructor', () {
      final loginModel = LoginModel(email: 'test@example.com', password: 'password123');

      expect(loginModel.email, 'test@example.com');
      expect(loginModel.password, 'password123');
    });

    test('Should correctly parse from JSON', () {
      const jsonString = '{"email": "test@example.com", "password": "password123"}';
      final loginModel = loginModelFromJson(jsonString);

      expect(loginModel.email, 'test@example.com');
      expect(loginModel.password, 'password123');
    });

    test('Should correctly serialize to JSON', () {
      final loginModel = LoginModel(email: 'test@example.com', password: 'password123');
      final jsonString = loginModelToJson(loginModel);

      expect(jsonString, '{"email":"test@example.com","password":"password123"}');
    });

    test('Should throw error if required fields are missing in JSON', () {
      const jsonString = '{"email": "test@example.com"}'; // Missing password

      expect(() => loginModelFromJson(jsonString), throwsA(isA<TypeError>()));
    });

    test('Should handle empty email and password', () {
      final loginModel = LoginModel(email: '', password: '');
      final jsonString = loginModelToJson(loginModel);

      expect(loginModel.email, '');
      expect(loginModel.password, '');
      expect(jsonString, '{"email":"","password":""}');
    });

    test('Should handle special characters in email and password', () {
      final loginModel = LoginModel(email: 'user+name@example.com', password: 'binodcoder');
      final jsonString = loginModelToJson(loginModel);

      expect(loginModel.email, 'user+name@example.com');
      expect(loginModel.password, 'binodcoder');
      expect(jsonString, '{"email":"user+name@example.com","password":"binodcoder"}');
    });

    test('Should handle incorrect data types in JSON', () {
      const jsonString = '{"email": 123, "password": true}';

      expect(() => loginModelFromJson(jsonString), throwsA(isA<TypeError>()));
    });

    test('Should handle additional fields in JSON', () {
      const jsonString = '{"email": "test@example.com", "password": "password123", "extra_field": "extra_value"}';
      final loginModel = loginModelFromJson(jsonString);

      expect(loginModel.email, 'test@example.com');
      expect(loginModel.password, 'password123');
    });

    test('toJson should generate correct map', () {
      final loginModel = LoginModel(email: 'test@example.com', password: 'password123');
      final jsonMap = loginModel.toJson();

      expect(jsonMap, {
        'email': 'test@example.com',
        'password': 'password123',
      });
    });

    test('fromJson should create LoginModel from valid map', () {
      final jsonMap = {
        'email': 'test@example.com',
        'password': 'password123',
      };
      final loginModel = LoginModel.fromJson(jsonMap);

      expect(loginModel.email, 'test@example.com');
      expect(loginModel.password, 'password123');
    });

    test('LoginModel equality test', () {
      final loginModel1 = LoginModel(email: 'test@example.com', password: 'password123');
      final loginModel2 = LoginModel(email: 'test@example.com', password: 'password123');
      final loginModel3 = LoginModel(email: 'different@example.com', password: 'password123');

      expect(loginModel1, equals(loginModel2));
      expect(loginModel1, isNot(equals(loginModel3)));
    });
  });
}
