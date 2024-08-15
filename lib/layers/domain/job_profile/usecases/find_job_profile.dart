import 'package:merokaam/core/entities/job_profile.dart';

import '../../../../../../core/errors/failures.dart';
import '../../../../../../core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';

import '../repositories/job_profile_repositories.dart';

class FindPosts implements UseCase<List<JobProfile>, String> {
  final JobProfileRepository postRepository;

  FindPosts(this.postRepository);

  @override
  Future<Either<Failure, List<JobProfile>>?> call(String searchTerm) async {
    return await postRepository.findJobProfiles(searchTerm);
  }
}
