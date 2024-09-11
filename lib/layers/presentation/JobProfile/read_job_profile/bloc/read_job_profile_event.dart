//These are the set of events.
import '../../../../../core/entities/job_profile.dart';

abstract class ReadJobProfileEvent {}

class JobProfileInitialEvent extends ReadJobProfileEvent {
  final int id;
  JobProfileInitialEvent(this.id);
}

class JobProfileEditButtonClickedEvent extends ReadJobProfileEvent {
  final JobProfile jobProfile;

  JobProfileEditButtonClickedEvent(this.jobProfile);
}

class JobProfileDeleteButtonClickedEvent extends ReadJobProfileEvent {
  final JobProfile jobProfile;

  JobProfileDeleteButtonClickedEvent(this.jobProfile);
}

class JobProfileAddButtonClickedEvent extends ReadJobProfileEvent {}
