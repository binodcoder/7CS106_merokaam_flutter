import 'package:equatable/equatable.dart';
import 'package:merokaam/core/entities/job_profile.dart';

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
  final List<JobProfile> jobProfileList;

  const JobProfileLoadedSuccessState(this.jobProfileList);
  JobProfileLoadedSuccessState copyWith({List<JobProfile>? jobProfileList}) {
    return JobProfileLoadedSuccessState(jobProfileList ?? this.jobProfileList);
  }
}

class JobProfileErrorState extends JobProfileActionState {
  final String message;
  JobProfileErrorState({required this.message});
}

class JobProfileNavigateToAddJobProfileActionState extends JobProfileActionState {}

class JobProfileNavigateToDetailPageActionState extends JobProfileActionState {
  final JobProfile jobProfile;

  JobProfileNavigateToDetailPageActionState(this.jobProfile);
}

class JobProfileNavigateToUpdatePageActionState extends JobProfileActionState {
  final JobProfile jobProfile;

  JobProfileNavigateToUpdatePageActionState(this.jobProfile);
}

class JobProfileItemDeletedActionState extends JobProfileActionState {}

class JobProfileItemSelectedActionState extends JobProfileActionState {}

class JobProfileItemsDeletedActionState extends JobProfileActionState {}

class JobProfileearchIconClickedState extends JobProfileActionState {
  final bool isSearch;
  JobProfileearchIconClickedState(this.isSearch);
}

class JobProfileItemsUpdatedState extends JobProfileActionState {}
