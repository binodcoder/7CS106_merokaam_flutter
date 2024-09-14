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
  Future<JobProfileModel?> readLastJobProfile(int id) => _readJobProfileFromLocal(id);

  @override
  Future<int>? cacheJobProfile(JobProfileModel jobProfileModel) => _cacheJobProfile(jobProfileModel);

  Future<int>? _cacheJobProfile(JobProfileModel jobProfileModel) async {
    JobProfileModel? result = await readLastJobProfile(jobProfileModel.userAccountId!);

    if (result != null) {
      return DatabaseHelper.updateJobProfile(jobProfileModel);
    } else {
      return DatabaseHelper.insertJobProfile(jobProfileModel);
    }
  }

  Future<JobProfileModel?> _readJobProfileFromLocal(int id) async {
    JobProfileModel? jobProfileModelList = await DatabaseHelper.readJobProfile(id);

    if (jobProfileModelList != null) {
      return jobProfileModelList;
    } else if (jobProfileModelList == null) {
      return null;
    } else {
      throw CacheException();
    }
  }
}
