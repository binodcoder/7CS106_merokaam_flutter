import '../../../../../core/errors/failures.dart';

abstract class CreateJobProfileState {}

abstract class JobProfileAddActionState extends CreateJobProfileState {}

class JobProfileAddInitialState extends CreateJobProfileState {}

class AddJobProfileSavedState extends JobProfileAddActionState {}

class AddJobProfileLoadingState extends JobProfileAddActionState {}

class AddJobProfileUpdatedState extends JobProfileAddActionState {}

class AddJobProfileErrorState extends JobProfileAddActionState {
  final Failure failure;

  AddJobProfileErrorState(this.failure);
}

class AddProfileUnauthorizedState extends JobProfileAddActionState {}
