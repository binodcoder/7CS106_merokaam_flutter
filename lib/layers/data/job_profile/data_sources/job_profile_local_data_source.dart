import '../../../../core/db/db_helper.dart';
import '../../../../core/models/job_profile_model.dart';

abstract class JobProfilesLocalDataSource {
  Future<List<JobProfileModel>> getLastJobProfiles();
  Future<void>? cacheJobProfile(JobProfileModel jobProfileModel);
}

class JobProfilesLocalDataSourceImpl implements JobProfilesLocalDataSource {
  final DatabaseHelper dbHelper;
  JobProfilesLocalDataSourceImpl(this.dbHelper);

  @override
  Future<List<JobProfileModel>> getLastJobProfiles() => _getJobProfilesFromLocal();

  Future<List<JobProfileModel>> _getJobProfilesFromLocal() async {
    List<JobProfileModel> jobProfileModelList = await dbHelper.getJobProfiles();
    return jobProfileModelList;
  }

  @override
  Future<void>? cacheJobProfile(JobProfileModel jobProfileModel) {
    return dbHelper.insertJobProfile(jobProfileModel);
  }
}
