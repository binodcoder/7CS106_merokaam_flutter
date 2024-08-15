import 'package:dartz/dartz.dart';
import 'package:merokaam/core/entities/job_profile.dart';
import '../../../../../../core/usecases/usecase.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/job_profile_repositories.dart';

class DeleteJobProfile implements UseCase<int, JobProfile> {
  JobProfileRepository postRepository;

  DeleteJobProfile(this.postRepository);

  @override
  Future<Either<Failure, int>?> call(JobProfile jobProfile) async {
    return await postRepository.deleteJobProfile(jobProfile);
  }
}
