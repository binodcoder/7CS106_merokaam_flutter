import 'package:dartz/dartz.dart';
import 'package:merokaam/core/entities/job_profile.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/job_profile_repositories.dart';

class UpdatePost implements UseCase<int, JobProfile> {
  JobProfileRepository postRepository;

  UpdatePost(this.postRepository);

  @override
  Future<Either<Failure, int>?> call(JobProfile jobProfile) async {
    return await postRepository.updateJobProfile(jobProfile);
  }
}
