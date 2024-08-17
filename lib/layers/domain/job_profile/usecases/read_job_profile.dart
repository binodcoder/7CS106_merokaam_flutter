import 'package:merokaam/core/entities/job_profile.dart';

import '../../../../../../core/errors/failures.dart';
import '../../../../../../core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

import '../repositories/job_profile_repositories.dart';

class ReadJobProfile implements UseCase<List<JobProfile>, NoParams> {
  final JobProfileRepository jobProfileRepository;

  ReadJobProfile(this.jobProfileRepository);

  @override
  Future<Either<Failure, List<JobProfile>>?> call(NoParams noParams) async {
    return await jobProfileRepository.readJobProfiles();
  }
}
