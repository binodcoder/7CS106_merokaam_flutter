import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:merokaam/layers/presentation/JobProfile/add_update_job_profile/bloc/create_job_profile_bloc_event.dart';
import 'package:merokaam/layers/presentation/JobProfile/read_job_profile/bloc/read_job_profile_event.dart';
import 'package:merokaam/layers/presentation/JobProfile/read_job_profile/bloc/read_job_profile_event.dart';
import 'package:merokaam/layers/presentation/JobProfile/read_job_profile/bloc/read_job_profile_event.dart';
import 'package:merokaam/layers/presentation/JobProfile/read_job_profile/bloc/read_job_profile_event.dart';
import 'package:merokaam/layers/presentation/JobProfile/read_job_profile/bloc/read_job_profile_event.dart';
import 'package:merokaam/layers/presentation/JobProfile/read_job_profile/bloc/read_job_profile_event.dart';
import 'package:merokaam/layers/presentation/JobProfile/read_job_profile/bloc/read_job_profile_state.dart';
import '../../../../../core/entities/job_profile.dart';
import '../../../../../core/mappers/map_failure_to_message.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../../domain/job_profile/usecases/delete_job_profile.dart';
import '../../../../domain/job_profile/usecases/read_job_profile.dart';
import '../../../../domain/job_profile/usecases/update_job_profile.dart';

class ReadJobProfileBloc extends Bloc<ReadJobProfileEvent, ReadJobProfileState> {
  final ReadJobProfile getJobProfiles;

  final DeleteJobProfile deleteJobProfile;

  ReadJobProfileState get initialState => JobProfileInitialState();

  ReadJobProfileBloc({
    required this.getJobProfiles,
    required this.deleteJobProfile,
  }) : super(JobProfileInitialState()) {
    on<JobProfileInitialEvent>(jobProfileInitialEvent);
    on<JobProfileEditButtonClickedEvent>(jobProfileEditButtonClickedEvent);
    on<JobProfileDeleteButtonClickedEvent>(jobProfileDeleteButtonClickedEvent);

    on<JobProfileAddButtonClickedEvent>(jobProfileAddButtonClickedEvent);
  }

  /*
  This method initializes a list of selected JobProfiles, signals application loading, fetches JobProfiles from a data source, and updates
  state based on success or failure. If successful, it filters JobProfiles and emits a state, handling errors.
   */

  FutureOr<void> jobProfileInitialEvent(JobProfileInitialEvent event, Emitter<ReadJobProfileState> emit) async {
    emit(JobProfileLoadingState());
    final jobProfileModel = await getJobProfiles(event.id);

    jobProfileModel!.fold((failure) {
      emit(JobProfileErrorState(message: mapFailureToMessage(failure)));
    }, (jobProfile) {
      emit(JobProfileLoadedSuccessState(jobProfile));
    });
  }

  FutureOr<void> jobProfileEditButtonClickedEvent(JobProfileEditButtonClickedEvent event, Emitter<ReadJobProfileState> emit) {
    emit(JobProfileNavigateToUpdatePageActionState(event.jobProfile));
  }

/*
This method handles events triggered by a deleted button click in an application, initiating the deletion process by sending
a delete request to the server, processing it using the `fold` function, and emitting an error state if successful.
 */
  FutureOr<void> jobProfileDeleteButtonClickedEvent(JobProfileDeleteButtonClickedEvent event, Emitter<ReadJobProfileState> emit) async {
    final result = await deleteJobProfile(event.jobProfile);

    result!.fold((failure) {
      emit(JobProfileErrorState(message: mapFailureToMessage(failure)));
    }, (jobProfileList) {
      emit(JobProfileItemDeletedActionState());
    });
  }

  FutureOr<void> jobProfileAddButtonClickedEvent(JobProfileAddButtonClickedEvent event, Emitter<ReadJobProfileState> emit) {
    emit(JobProfileNavigateToAddJobProfileActionState());
  }
}
