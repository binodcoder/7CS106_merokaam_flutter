import 'package:merokaam/core/entities/job_profile.dart';

abstract class CreateJobProfileEvent {}

class JobProfileAddInitialEvent extends CreateJobProfileEvent {}

class JobProfileAddSaveButtonPressEvent extends CreateJobProfileEvent {
  final JobProfile newJobProfile;

  JobProfileAddSaveButtonPressEvent(this.newJobProfile);
}

class JobProfileAddUpdateButtonPressEvent extends CreateJobProfileEvent {
  final JobProfile updatedJobProfile;

  JobProfileAddUpdateButtonPressEvent(this.updatedJobProfile);
}

class JobProfileAddReadyToUpdateEvent extends CreateJobProfileEvent {
  final JobProfile jobProfile;

  JobProfileAddReadyToUpdateEvent(this.jobProfile);
}
