import 'package:http/http.dart' as http;

import 'package:merokaam/core/models/job_profile_model.dart';

import '../../../../core/errors/exceptions.dart';

abstract class JobProfileRemoteDataSources {
  Future<List<JobProfileModel>> readJobProfile();

  Future<int> deleteJobProfile(int userAccountId);

  Future<int> createJobProfile(JobProfileModel postModel);

  Future<int> updateJobProfile(JobProfileModel postModel);
}

class JobProfileRemoteDataSourcesImpl implements JobProfileRemoteDataSources {
  final http.Client client;

  JobProfileRemoteDataSourcesImpl({required this.client});

  Future<int> _createJobProfile(String url, JobProfileModel jobProfileModel) async {
    final response = await client.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jobProfileModel.toMap(),
    );
    if (response.statusCode == 201) {
      return 1;
    } else {
      throw ServerException();
    }
  }

  Future<List<JobProfileModel>> _readJobProfile(String url) async {
    final response = await client.get(Uri.parse(url), headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      return jobProfileModelsFromMap(response.body);
    } else {
      throw ServerException();
    }
  }

  Future<int> _updateJobProfile(String url, JobProfileModel jobProfileModel) async {
    final response = await client.put(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jobProfileModel.toMap(),
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
  Future<int> createJobProfile(JobProfileModel jobProfileModel) => _createJobProfile("", jobProfileModel);

  @override
  Future<List<JobProfileModel>> readJobProfile() => _readJobProfile("");

  @override
  Future<int> updateJobProfile(JobProfileModel jobProfileModel) => _updateJobProfile("", jobProfileModel);

  @override
  Future<int> deleteJobProfile(int userAccountId) => _deleteJobProfile("");
}
