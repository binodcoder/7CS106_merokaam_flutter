import 'package:merokaam/core/errors/exceptions.dart';
import 'package:merokaam/core/errors/failures.dart';
import '../../../../core/db/db_helper.dart';
import '../../../../core/models/job_profile_model.dart';

abstract class JobProfilesLocalDataSource {
  Future<JobProfileModel> readLastJobProfile(int id);

  Future<int>? cacheJobProfile(JobProfileModel jobProfileModel);
}

class JobProfilesLocalDataSourceImpl implements JobProfilesLocalDataSource {
  final DatabaseHelper dbHelper;

  JobProfilesLocalDataSourceImpl(this.dbHelper);

  @override
  Future<int> cacheJobProfile(JobProfileModel jobProfileModel) => _cacheJobProfile(jobProfileModel);

  @override
  Future<JobProfileModel> readLastJobProfile(int id) => _readJobProfileFromLocal(id);

  Future<int> _cacheJobProfile(JobProfileModel jobProfileModel) async {
    // Ensure userAccountId is not null before proceeding
    if (jobProfileModel.userAccountId == null) {
      throw ArgumentException("User Account ID cannot be null");
    }

    try {
      // Check if the job profile already exists in the local database
      //   JobProfileModel? existingProfile = await DatabaseHelper.readJobProfile(jobProfileModel.userAccountId!);
      // If it exists, update it; otherwise, insert a new profile
      // if (existingProfile != null) {
      await DatabaseHelper.updateJobProfile(jobProfileModel);
      return 1;
      // } else {
      // await DatabaseHelper.insertJobProfile(jobProfileModel);

      // }
    } on NotFoundException {
      // Handle the case when the profile is not found by inserting a new one
      await DatabaseHelper.insertJobProfile(jobProfileModel);
      return 1;
    } on ArgumentException {
      rethrow;
    } catch (e) {
      // Handle any unforeseen exceptions (optional)
      print("Error caching job profile: $e");
      throw CacheException();
    }
  }

  Future<JobProfileModel> _readJobProfileFromLocal(int id) async {
    try {
      // Attempt to read job profile from the database
      JobProfileModel jobProfileModel = await DatabaseHelper.readJobProfile(id);
      return jobProfileModel;
    } on NotFoundException {
      rethrow;
    } catch (e) {
      // Handle any unexpected errors (optional)
      print('Error reading job profile from local: $e');
      throw CacheException();
    }
  }
}
