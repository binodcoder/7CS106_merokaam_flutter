import '../../../../core/db/db_helper.dart';
import '../../../../core/models/job_profile_model.dart';

abstract class JobProfilesLocalDataSource {
  Future<List<JobProfileModel>> readLastJobProfiles();
  Future<void>? cacheJobProfile(JobProfileModel jobProfileModel);
}

class JobProfilesLocalDataSourceImpl implements JobProfilesLocalDataSource {
  final DatabaseHelper dbHelper;
  JobProfilesLocalDataSourceImpl(this.dbHelper);

  @override
  Future<List<JobProfileModel>> readLastJobProfiles() => _readJobProfilesFromLocal();

  @override
  Future<void>? cacheJobProfile(JobProfileModel jobProfileModel) {
    return dbHelper.insertJobProfile(jobProfileModel);
  }

  Future<List<JobProfileModel>> _readJobProfilesFromLocal() async {
    List<JobProfileModel> jobProfileModelList = await dbHelper.readJobProfiles();
    return jobProfileModelList;
  }
}
