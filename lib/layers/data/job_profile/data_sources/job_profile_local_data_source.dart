import 'package:merokaam/core/errors/exceptions.dart';
import 'package:merokaam/core/errors/failures.dart';
import '../../../../core/db/db_helper.dart';
import '../../../../core/models/job_profile_model.dart';

abstract class JobProfilesLocalDataSource {
  Future<JobProfileModel?> readLastJobProfile(int id);

  Future<int>? cacheJobProfile(JobProfileModel jobProfileModel);
}

class JobProfilesLocalDataSourceImpl implements JobProfilesLocalDataSource {
  final DatabaseHelper dbHelper;

  JobProfilesLocalDataSourceImpl(this.dbHelper);

  @override
  Future<int> cacheJobProfile(JobProfileModel jobProfileModel) => _cacheJobProfile(jobProfileModel);

  @override
  Future<JobProfileModel?> readLastJobProfile(int id) => _readJobProfileFromLocal(id);

  Future<int> _cacheJobProfile(JobProfileModel jobProfileModel) async {
    // Ensure userAccountId is not null before proceeding
    if (jobProfileModel.userAccountId == null) {
      throw ArgumentError("User Account ID cannot be null");
    }

    try {
      // Check if the job profile already exists in the local database
      JobProfileModel? existingProfile = await DatabaseHelper.readJobProfile(jobProfileModel.userAccountId!);
      // If it exists, update it; otherwise, insert a new profile
      if (existingProfile != null) {
        return await DatabaseHelper.updateJobProfile(jobProfileModel);
      } else {
        return await DatabaseHelper.insertJobProfile(jobProfileModel);
      }
    } catch (e) {
      // Handle any unforeseen exceptions (optional)
      print("Error caching job profile: $e");
      throw CacheException();
    }
  }

  Future<JobProfileModel?> _readJobProfileFromLocal(int id) async {
    try {
      // Attempt to read job profile from the database
      JobProfileModel? jobProfileModel = await DatabaseHelper.readJobProfile(id);

      // Return the result if found, otherwise handle null case
      if (jobProfileModel != null) {
        return jobProfileModel;
      } else {
        // If no job profile is found, we throw a CacheException
        throw NotFoundException();
      }
    } on NotFoundException {
      throw NotFoundException();
    } catch (e) {
      // Handle any unexpected errors (optional)
      print('Error reading job profile from local: $e');
      throw CacheException();
    }
  }
}
