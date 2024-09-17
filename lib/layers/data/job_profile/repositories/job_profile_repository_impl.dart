import 'package:dartz/dartz.dart';
import 'package:merokaam/core/entities/job_profile.dart';
import 'package:merokaam/core/mappers/map_failure_to_message.dart';
import 'package:merokaam/core/models/job_profile_model.dart';
import 'package:merokaam/layers/data/job_profile/data_sources/job_profile_local_data_source.dart';
import 'package:merokaam/layers/data/job_profile/data_sources/job_profile_remote_data_sources.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../../domain/job_profile/repositories/job_profile_repositories.dart';

class JobProfileRepositoryImpl implements JobProfileRepository {
  final JobProfilesLocalDataSource jobProfilesLocalDataSource;
  final JobProfileRemoteDataSource jobProfileRemoteDataSources;
  final NetworkInfo networkInfo;

  JobProfileRepositoryImpl({
    required this.jobProfileRemoteDataSources,
    required this.jobProfilesLocalDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, int>>? createJobProfile(JobProfile jobProfile) async {
    JobProfileModel jobProfileModel = JobProfileModel(
      firstName: jobProfile.firstName,
      lastName: jobProfile.lastName,
      city: jobProfile.city,
      state: jobProfile.state,
      country: jobProfile.country,
      workAuthorization: jobProfile.workAuthorization,
      employmentType: jobProfile.employmentType,
    );
    if (await networkInfo.isConnected) {
      try {
        int response = await jobProfileRemoteDataSources.createJobProfile(jobProfileModel);
        return Right(response);
      } on AppException catch (e) {
        return Left(mapExceptionToFailure(e));
      }
    } else {
      return const Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, JobProfile>> readJobProfile(int id) async {
    // Check network connectivity
    if (await networkInfo.isConnected) {
      try {
        // Fetch from remote source
        JobProfile jobProfile = await jobProfileRemoteDataSources.readJobProfile(id);

        JobProfileModel jobProfileModel = JobProfileModel(
          userAccountId: jobProfile.userAccountId,
          firstName: jobProfile.firstName,
          lastName: jobProfile.lastName,
          city: jobProfile.city,
          state: jobProfile.state,
          country: jobProfile.country,
          workAuthorization: jobProfile.workAuthorization,
          employmentType: jobProfile.employmentType,
        );
        // Cache the fetched job profile locally only if the remote call is successful
        await jobProfilesLocalDataSource.cacheJobProfile(jobProfileModel);
        // Return the job profile as a successful result
        return Right(jobProfile);
      } on AppException catch (e) {
        return Left(mapExceptionToFailure(e));
      }
    } else {
      // If no network, fallback to local cache
      try {
        final JobProfile jobProfile = await jobProfilesLocalDataSource.readLastJobProfile(id);
        return Right(jobProfile);
      } on AppException catch (e) {
        return Left(mapExceptionToFailure(e));
      }
    }
  }

  @override
  Future<Either<Failure, int>> updateJobProfile(JobProfile jobProfile) async {
    // Convert JobProfile to JobProfileModel for updating
    JobProfileModel jobProfileModel = JobProfileModel(
      firstName: jobProfile.firstName,
      lastName: jobProfile.lastName,
      city: jobProfile.city,
      state: jobProfile.state,
      country: jobProfile.country,
      workAuthorization: jobProfile.workAuthorization,
      employmentType: jobProfile.employmentType,
    );
    // Check network connectivity before proceeding
    if (await networkInfo.isConnected) {
      try {
        int response = await jobProfileRemoteDataSources.updateJobProfile(jobProfileModel);
        //cache the updated profile locally after a successful remote update
        await jobProfilesLocalDataSource.cacheJobProfile(jobProfileModel);
        return Right(response);
      } on AppException catch (e) {
        return Left(mapExceptionToFailure(e));
      }
    } else {
      return const Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, int>>? deleteJobProfile(JobProfile jobProfile) async {
    try {
      int postList = await jobProfileRemoteDataSources.deleteJobProfile(jobProfile.userAccountId!);
      return Right(postList);
    } on AppException catch (e) {
      return Left(mapExceptionToFailure(e));
    }
  }
}
