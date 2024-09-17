import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:merokaam/core/models/job_profile_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/errors/exceptions.dart';

abstract class JobProfileRemoteDataSource {
  Future<JobProfileModel> readJobProfile(int id);

  Future<int> deleteJobProfile(int userAccountId);

  Future<int> createJobProfile(JobProfileModel postModel);

  Future<int> updateJobProfile(JobProfileModel postModel);
}

class JobProfileRemoteDataSourceImpl implements JobProfileRemoteDataSource {
  final http.Client client;
  final SharedPreferences sharedPreferences;

  JobProfileRemoteDataSourceImpl({required this.client, required this.sharedPreferences});

  Future<int> _createJobProfile(String url, JobProfileModel jobProfileModel) async {
    try {
      final jwtToken = sharedPreferences.getString("jwt_token");
      if (jwtToken == null || jwtToken.isEmpty) {
        throw UnauthorizedException('JWT token not found or empty.');
      }
      final cookie = jwtToken.split(';').first;

      final response = await client
          .post(
            Uri.parse(url),
            headers: {
              'Content-Type': 'application/json',
              'Cookie': cookie,
            },
            body: json.encode(jobProfileModel.toJson()),
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        return 1;
      } else if (response.statusCode == 401) {
        throw UnauthorizedException('Unauthorized access.');
      } else if (response.statusCode == 400) {
        throw BadRequestException('Bad request.');
      } else if (response.statusCode == 404) {
        throw NotFoundException('Resource not found.');
      } else {
        throw ServerException('Server error: ${response.statusCode}.');
      }
    } on TimeoutException catch (e) {
      throw CustomTimeoutException('Request timed out.', e);
    } on SocketException catch (e) {
      throw NetworkException('No Internet connection.', e);
    } on FormatException catch (e) {
      throw InvalidFormatException('Invalid response format.', e);
    } on UnauthorizedException {
      rethrow; // Already handled
    } on BadRequestException {
      rethrow; // Already handled
    } on NotFoundException {
      rethrow; // Already handled
    } on ServerException {
      rethrow; // Already handled
    } catch (e) {
      throw UnknownException('An unexpected error occurred.', e);
    }
  }

  Future<JobProfileModel> _readJobProfile(String url) async {
    try {
      final jwtToken = sharedPreferences.getString("jwt_token");
      if (jwtToken == null || jwtToken.isEmpty) {
        throw UnauthorizedException('JWT token not found or empty.');
      }
      final cookie = jwtToken.split(';').first;

      final response = await client.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Cookie': cookie,
        },
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        try {
          final data = json.decode(response.body);
          return JobProfileModel.fromJson(data);
        } on FormatException catch (e) {
          throw InvalidFormatException('Invalid response format.', e);
        }
      } else if (response.statusCode == 404) {
        throw NotFoundException('Resource not found.');
      } else if (response.statusCode == 401) {
        throw UnauthorizedException('Unauthorized access.');
      } else if (response.statusCode == 400) {
        throw BadRequestException('Bad request.');
      } else {
        throw ServerException('Server error: ${response.statusCode}.');
      }
    } on TimeoutException catch (e) {
      throw CustomTimeoutException('Request timed out.', e);
    } on SocketException catch (e) {
      throw NetworkException('No Internet connection.', e);
    } on InvalidFormatException {
      rethrow; // Already handled
    } on UnauthorizedException {
      rethrow; // Already handled
    } on BadRequestException {
      rethrow; // Already handled
    } on NotFoundException {
      rethrow; // Already handled
    } on ServerException {
      rethrow; // Already handled
    } catch (e) {
      throw UnknownException('An unexpected error occurred.', e);
    }
  }

  Future<int> _updateJobProfile(String url, JobProfileModel jobProfileModel) async {
    try {
      final jwtToken = sharedPreferences.getString("jwt_token");
      if (jwtToken == null || jwtToken.isEmpty) {
        throw UnauthorizedException('JWT token not found or empty.');
      }
      final cookie = jwtToken.split(';').first;

      final response = await client
          .put(
            Uri.parse(url),
            headers: {
              'Content-Type': 'application/json',
              'Cookie': cookie,
            },
            body: json.encode(jobProfileModel.toJson()),
          )
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        return 1;
      } else if (response.statusCode == 401) {
        throw UnauthorizedException('Unauthorized access.');
      } else if (response.statusCode == 404) {
        throw NotFoundException('Resource not found.');
      } else if (response.statusCode == 400) {
        throw BadRequestException('Bad request.');
      } else {
        throw ServerException('Server error: ${response.statusCode}.');
      }
    } on TimeoutException catch (e) {
      throw CustomTimeoutException('Request timed out.', e);
    } on SocketException catch (e) {
      throw NetworkException('No Internet connection.', e);
    } on UnauthorizedException {
      rethrow; // Already handled
    } on NotFoundException {
      rethrow; // Already handled
    } on BadRequestException {
      rethrow; // Already handled
    } on ServerException {
      rethrow; // Already handled
    } catch (e) {
      throw UnknownException('An unexpected error occurred.', e);
    }
  }

  Future<int> _deleteJobProfile(String url) async {
    final response = await client.delete(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return 1;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<int> createJobProfile(JobProfileModel jobProfileModel) =>
      _createJobProfile("http://192.168.1.180:5000/api/job-profile/create", jobProfileModel);

  @override
  Future<JobProfileModel> readJobProfile(int id) => _readJobProfile("http://192.168.1.180:5000/api/job-profile/profile/$id");

  @override
  Future<int> updateJobProfile(JobProfileModel jobProfileModel) =>
      _updateJobProfile("http://192.168.1.180:5000/api/job-profile/profile/${sharedPreferences.getInt("id")}", jobProfileModel);

  @override
  Future<int> deleteJobProfile(int userAccountId) => _deleteJobProfile("");
}
