import 'package:dartz/dartz.dart';
import 'package:merokaam/core/entities/job_profile.dart';
import '../../../../../core/errors/failures.dart';

abstract class JobProfileRepository {
  Future<Either<Failure, List<JobProfile>>>? readJobProfiles();
  Future<Either<Failure, int>>? deleteJobProfile(JobProfile post);
  Future<Either<Failure, int>>? createJobProfile(JobProfile post);
  Future<Either<Failure, int>>? updateJobProfile(JobProfile post);
  Future<Either<Failure, List<JobProfile>>>? findJobProfiles(String searchTerm);
}
