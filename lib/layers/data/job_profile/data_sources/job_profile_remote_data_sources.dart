import 'dart:convert';

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
    final response = await client.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Cookie': sharedPreferences.getString("jwt_token")!.split(';').first,
      },
      body: json.encode(jobProfileModel.toJson()),
    );
    if (response.statusCode == 200) {
      return 1;
    } else if (response.statusCode == 401) {
      throw UnauthorizedException();
    } else {
      throw ServerException();
    }
  }

  Future<JobProfileModel> _readJobProfile(String url) async {
    try {
      final response = await client.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Cookie': sharedPreferences.getString("jwt_token")!.split(';').first,
        },
      ).timeout(const Duration(seconds: 5));
      if (response.statusCode == 200) {
        return JobProfileModel.fromJson(json.decode(response.body));
      } else if (response.statusCode == 404) {
        throw NotFoundException();
      } else if (response.statusCode == 401) {
        throw UnauthorizedException();
      } else {
        throw ServerException();
      }
    } on TimeoutException {
      throw TimeoutException();
    } catch (e) {
      rethrow;
    }
  }

  Future<int> _updateJobProfile(String url, JobProfileModel jobProfileModel) async {
    final response = await client.put(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Cookie': sharedPreferences.getString("jwt_token")!.split(';').first,
      },
      body: json.encode(jobProfileModel.toJson()),
    );
    if (response.statusCode == 200) {
      return 1;
    } else {
      throw ServerException();
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
