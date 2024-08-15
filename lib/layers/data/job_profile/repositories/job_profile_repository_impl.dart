import 'package:dartz/dartz.dart';
import 'package:merokaam/core/entities/job_profile.dart';
import 'package:merokaam/core/models/job_profile_model.dart';
import 'package:merokaam/layers/data/job_profile/data_sources/job_profile_remote_data_sources.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../domain/job_profile/repositories/job_profile_repositories.dart';

class JobProfileRepositoryImpl implements JobProfileRepository {
  final JobProfileRemoteDataSources jobProfileRemoteDataSources;

  JobProfileRepositoryImpl({
    required this.jobProfileRemoteDataSources,
  });

  @override
  Future<Either<Failure, int>>? createJobProfile(JobProfile jobProfile) async {
    JobProfileModel jobProfileModel = JobProfileModel(
      userAccountId: jobProfile.userAccountId,
      firstName: '',
      lastName: '',
      city: "",
      state: '',
      country: '',
      workAuthorization: '',
      employmentType: '',
      resume: '',
      profilePhoto: '',
      photosImagePath: '',
    );
    try {
      int response = await jobProfileRemoteDataSources.createJobProfile(jobProfileModel);
      return Right(response);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, List<JobProfile>>> readJobProfiles() async {
    try {
      List<JobProfile> jobProfiles = await jobProfileRemoteDataSources.readJobProfile();
      return Right(jobProfiles);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, int>>? updateJobProfile(JobProfile jobProfile) async {
    JobProfileModel jobProfileModel = JobProfileModel(
      userAccountId: jobProfile.userAccountId,
      firstName: '',
      lastName: '',
      city: "",
      state: '',
      country: '',
      workAuthorization: '',
      employmentType: '',
      resume: '',
      profilePhoto: '',
      photosImagePath: '',
    );
    try {
      int response = await jobProfileRemoteDataSources.updateJobProfile(jobProfileModel);
      return Right(response);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, int>>? deleteJobProfile(JobProfile jobProfile) async {
    try {
      int postList = await jobProfileRemoteDataSources.deleteJobProfile(jobProfile.userAccountId);
      return Right(postList);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
