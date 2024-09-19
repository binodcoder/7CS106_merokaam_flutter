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
import '../../../../../core/errors/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../../../domain/job_profile/usecases/delete_job_profile.dart';
import '../../../../domain/job_profile/usecases/read_job_profile.dart';
import '../../../../domain/job_profile/usecases/update_job_profile.dart';

class ReadJobProfileBloc extends Bloc<ReadJobProfileEvent, ReadJobProfileState> {
  final ReadJobProfile readJobProfiles;

  ReadJobProfileState get initialState => JobProfileInitialState();

  ReadJobProfileBloc({
    required this.readJobProfiles,
  }) : super(JobProfileInitialState()) {
    on<JobProfileInitialEvent>(jobProfileInitialEvent);
    on<JobProfileEditButtonClickedEvent>(jobProfileEditButtonClickedEvent);

    on<JobProfileAddButtonClickedEvent>(jobProfileAddButtonClickedEvent);
  }

  /*
  This method initializes a list of selected JobProfiles, signals application loading, fetches JobProfiles from a data source, and updates
  state based on success or failure. If successful, it filters JobProfiles and emits a state, handling errors.
   */

  FutureOr<void> jobProfileInitialEvent(JobProfileInitialEvent event, Emitter<ReadJobProfileState> emit) async {
    emit(JobProfileLoadingState());
    final jobProfileResult = await readJobProfiles(event.id);

    jobProfileResult!.fold((failure) {
      // if (failure is NotFoundFailure) {
      //   emit(JobProfileNotFoundState());
      // } else if (failure is UnauthorizedFailure) {
      //   emit(JobProfileUnauthorizedState());
      // } else {
      emit(JobProfileErrorState(failure));
      // }
    }, (jobProfile) {
      emit(JobProfileLoadedSuccessState(jobProfile));
    });
  }

  FutureOr<void> jobProfileEditButtonClickedEvent(JobProfileEditButtonClickedEvent event, Emitter<ReadJobProfileState> emit) {
    emit(JobProfileNavigateToUpdatePageActionState(event.jobProfile));
  }

  FutureOr<void> jobProfileAddButtonClickedEvent(JobProfileAddButtonClickedEvent event, Emitter<ReadJobProfileState> emit) {
    emit(JobProfileNavigateToAddJobProfileActionState());
  }
}
