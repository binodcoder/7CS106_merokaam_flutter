import 'package:equatable/equatable.dart';
import 'package:merokaam/core/entities/job_profile.dart';
import 'package:merokaam/core/errors/failures.dart';

//These are the set of states.
abstract class ReadJobProfileState extends Equatable {
  const ReadJobProfileState();

  @override
  List<Object> get props => [];
}

abstract class JobProfileActionState extends ReadJobProfileState {}

class JobProfileInitialState extends ReadJobProfileState {}

class JobProfileLoadingState extends ReadJobProfileState {}

class JobProfileLoadedSuccessState extends ReadJobProfileState {
  final JobProfile jobProfile;

  const JobProfileLoadedSuccessState(this.jobProfile);
  JobProfileLoadedSuccessState copyWith({JobProfile? jobProfile}) {
    return JobProfileLoadedSuccessState(jobProfile ?? this.jobProfile);
  }
}

class JobProfileErrorState extends JobProfileActionState {
  final Failure failure;
  JobProfileErrorState(this.failure);
}

class JobProfileNavigateToAddJobProfileActionState extends JobProfileActionState {}

class JobProfileNavigateToUpdatePageActionState extends JobProfileActionState {
  final JobProfile jobProfile;

  JobProfileNavigateToUpdatePageActionState(this.jobProfile);
}

class JobProfileItemsUpdatedState extends JobProfileActionState {}
