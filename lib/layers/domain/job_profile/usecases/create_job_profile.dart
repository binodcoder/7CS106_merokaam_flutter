import 'package:merokaam/core/entities/job_profile.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

import '../repositories/job_profile_repositories.dart';

class CreatePost implements UseCase<int, JobProfile> {
  final JobProfileRepository postRepository;

  CreatePost(this.postRepository);

  @override
  Future<Either<Failure, int>?> call(JobProfile jobProfile) async {
    return await postRepository.createJobProfile(jobProfile);
  }
}
