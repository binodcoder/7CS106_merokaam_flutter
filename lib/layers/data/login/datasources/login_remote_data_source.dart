import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import '../../../../core/entities/login.dart';
import '../../../../core/entities/user_info_response.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/models/user_model.dart';
import '../../../../resources/url.dart';

abstract class LoginRemoteDataSource {
  Future<UserInfoResponse> login(LoginModel loginModel);
}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  final http.Client client;

  LoginRemoteDataSourceImpl({required this.client});

  Future<UserInfoResponse> _login(String url, LoginModel loginModel) async {
    try {
      // Make the HTTP POST request
      final response = await client.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: loginModelToJson(loginModel),
      );

      // Handle different status codes
      if (response.statusCode == 200) {
        try {
          // Attempt to parse the response body
          return userInfoResponseFromJson(response.body);
        } catch (e) {
          throw ParsingException('Error parsing response: ${e.toString()}');
        }
      } else if (response.statusCode == 400) {
        throw BadRequestException('Invalid login details provided.');
      } else if (response.statusCode == 404) {
        throw NotFoundException(json.decode(response.body)["message"] ?? "");
      } else if (response.statusCode == 401) {
        throw UnauthorizedException('Unauthorized access. Please check your credentials.');
      } else if (response.statusCode == 500) {
        throw ServerException('Server error. Please try again later.');
      } else {
        throw HttpException('Unexpected HTTP status code: ${response.statusCode}');
      }
    } on ParsingException {
      rethrow;
    } on BadRequestException {
      rethrow;
    } on NotFoundException {
      rethrow;
    } on UnauthorizedException {
      rethrow;
    } on ServerException {
      rethrow;
    } on HttpException {
      rethrow;
    } on SocketException {
      // Handle network-related exceptions
      throw NetworkException('No internet connection. Please check your network settings.');
    } on TimeoutException {
      // Handle timeout exceptions
      throw TimeoutException('The request timed out. Please try again later.');
    } catch (e) {
      // Catch any other errors that were not specifically handled
      throw UnknownException('An unknown error occurred: ${e.toString()}');
    }
  }

  @override
  Future<UserInfoResponse> login(LoginModel loginModel) => _login(AppUrl.signin, loginModel);
}
