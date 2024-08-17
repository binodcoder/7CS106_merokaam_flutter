import 'package:dartz/dartz.dart';
import 'package:merokaam/core/entities/job_profile.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/job_profile_repositories.dart';

class UpdateJobProfile implements UseCase<int, JobProfile> {
  JobProfileRepository jobProfileRepository;

  UpdateJobProfile(this.jobProfileRepository);

  @override
  Future<Either<Failure, int>?> call(JobProfile jobProfile) async {
    return await jobProfileRepository.updateJobProfile(jobProfile);
  }
}
