import '../../../../core/db/db_helper.dart';
import '../../../../core/models/job_profile_model.dart';

abstract class JobProfilesLocalDataSource {
  Future<JobProfileModel> readLastJobProfile(int id);
  Future<void>? cacheJobProfile(JobProfileModel jobProfileModel);
}

class JobProfilesLocalDataSourceImpl implements JobProfilesLocalDataSource {
  final DatabaseHelper dbHelper;
  JobProfilesLocalDataSourceImpl(this.dbHelper);

  @override
  Future<JobProfileModel> readLastJobProfile(int id) => _readJobProfileFromLocal(id);

  @override
  Future<void>? cacheJobProfile(JobProfileModel jobProfileModel) {
    return dbHelper.insertJobProfile(jobProfileModel);
  }

  Future<JobProfileModel> _readJobProfileFromLocal(int id) async {
    JobProfileModel jobProfileModelList = await dbHelper.readJobProfile(id);
    return jobProfileModelList;
  }
}
