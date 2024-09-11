import 'package:dartz/dartz.dart';
import 'package:merokaam/core/entities/job_profile.dart';
import '../../../../../core/errors/failures.dart';

abstract class JobProfileRepository {
  Future<Either<Failure, JobProfile>>? readJobProfile(int id);
  Future<Either<Failure, int>>? deleteJobProfile(JobProfile jobProfile);
  Future<Either<Failure, int>>? createJobProfile(JobProfile jobProfile);
  Future<Either<Failure, int>>? updateJobProfile(JobProfile jobProfile);
}
