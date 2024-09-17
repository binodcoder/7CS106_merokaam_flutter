import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import '../../../../core/errors/exceptions.dart';
import '../../../../core/models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<int> addUser(UserModel userModel);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final http.Client client;

  UserRemoteDataSourceImpl({required this.client});

  Future<int> _addUser(String url, UserModel userModel) async {
    try {
      final response = await client.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(userModel.toMap()),
      );

      switch (response.statusCode) {
        case 200:
        case 201:
          // Assuming the user was successfully created
          return 1;
        case 400:
          throw BadRequestException(json.decode(response.body)["message"] ?? "");
        case 401:
          throw UnauthorizedException(json.decode(response.body)["message"] ?? "");
        case 403:
          throw UnauthorizedException('Forbidden access.');
        case 404:
          throw NotFoundException('Endpoint not found.');
        case 408:
          throw CustomTimeoutException('Request timeout.');
        case 500:
          throw ServerException('Internal server error.');
        default:
          throw UnknownException(
            'Unexpected error occurred. Status code: ${response.statusCode}',
            response.body,
          );
      }
    } on SocketException {
      // Handles network issues
      throw NetworkException('No internet connection.');
    } on TimeoutException {
      // Handles timeout exceptions
      throw CustomTimeoutException('Connection timeout.');
    } on FormatException catch (e) {
      // Handles JSON format exceptions
      throw DataFormatException('Invalid response format.', e);
    } on BadRequestException catch (e) {
      rethrow;
    } on UnauthorizedException catch (e) {
      rethrow;
    } on NotFoundException catch (e) {
      rethrow;
    } on CustomTimeoutException catch (e) {
      rethrow;
    } on ServerException catch (e) {
      rethrow;
    } on UnknownException catch (e) {
      rethrow;
    } catch (e) {
      // Catches any other exceptions
      throw UnknownException('An unexpected error occurred.', e);
    }
  }

  @override
  Future<int> addUser(UserModel userModel) => _addUser("http://192.168.1.180:5000/api/auth/signup", userModel);
}
