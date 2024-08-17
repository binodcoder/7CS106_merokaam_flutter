import 'package:merokaam/core/entities/job_profile.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

import '../repositories/job_profile_repositories.dart';

class CreateJobProfile implements UseCase<int, JobProfile> {
  final JobProfileRepository jobProfileRepository;

  CreateJobProfile(this.jobProfileRepository);

  @override
  Future<Either<Failure, int>?> call(JobProfile jobProfile) async {
    return await jobProfileRepository.createJobProfile(jobProfile);
  }
}
