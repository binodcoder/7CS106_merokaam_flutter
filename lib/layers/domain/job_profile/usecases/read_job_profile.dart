import 'package:merokaam/core/entities/job_profile.dart';

import '../../../../../../core/errors/failures.dart';
import '../../../../../../core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

import '../repositories/job_profile_repositories.dart';

class ReadJobProfile implements UseCase<JobProfile, int> {
  final JobProfileRepository jobProfileRepository;

  ReadJobProfile(this.jobProfileRepository);

  @override
  Future<Either<Failure, JobProfile>?> call(int id) async {
    return await jobProfileRepository.readJobProfile(id);
  }
}
