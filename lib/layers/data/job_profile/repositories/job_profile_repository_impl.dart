import 'package:dartz/dartz.dart';
import 'package:merokaam/core/entities/job_profile.dart';
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
    try {
      int response = await jobProfileRemoteDataSources.createJobProfile(jobProfileModel);
      return Right(response);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, JobProfile>> readJobProfile(int id) async {
    if (await networkInfo.isConnected) {
      try {
        JobProfile jobProfiles = await jobProfileRemoteDataSources.readJobProfile(id);
        return Right(jobProfiles);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        JobProfile jobProfile = await jobProfilesLocalDataSource.readLastJobProfile(id);
        return Right(jobProfile);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, int>>? updateJobProfile(JobProfile jobProfile) async {
    JobProfileModel jobProfileModel = JobProfileModel(
      firstName: jobProfile.firstName,
      lastName: jobProfile.lastName,
      city: jobProfile.city,
      state: jobProfile.state,
      country: jobProfile.country,
      workAuthorization: jobProfile.workAuthorization,
      employmentType: jobProfile.employmentType,
    );
    try {
      int response = await jobProfileRemoteDataSources.updateJobProfile(jobProfileModel);
      return Right(response);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, int>>? deleteJobProfile(JobProfile jobProfile) async {
    try {
      int postList = await jobProfileRemoteDataSources.deleteJobProfile(jobProfile.userAccountId!);
      return Right(postList);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
