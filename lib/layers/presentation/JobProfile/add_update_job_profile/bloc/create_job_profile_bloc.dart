import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../../../core/mappers/map_failure_to_message.dart';
import '../../../../domain/job_profile/usecases/create_job_profile.dart';
import '../../../../domain/job_profile/usecases/read_job_profile.dart';
import '../../../../domain/job_profile/usecases/update_job_profile.dart';
import 'create_job_profile_bloc_event.dart';
import 'create_job_profile_bloc_state.dart';

class CreateJobProfileBloc extends Bloc<CreateJobProfileEvent, CreateJobProfileState> {
  final CreateJobProfile createJobProfile;
  final UpdateJobProfile updateJobProfile;

  CreateJobProfileBloc({required this.createJobProfile, required this.updateJobProfile}) : super(JobProfileAddInitialState()) {
    on<JobProfileAddInitialEvent>(postAddInitialEvent);
    on<JobProfileAddSaveButtonPressEvent>(addJobProfileSaveButtonPressEvent);
    on<JobProfileAddUpdateButtonPressEvent>(jobProfileAddUpdateButtonPressEvent);
  }

  FutureOr<void> addJobProfileSaveButtonPressEvent(JobProfileAddSaveButtonPressEvent event, Emitter<CreateJobProfileState> emit) async {
    emit(AddJobProfileLoadingState());
    final result = await createJobProfile(event.newJobProfile);
    result!.fold((failure) {
      emit(AddJobProfileErrorState(message: mapFailureToMessage(failure)));
    }, (result) {
      emit(AddJobProfileSavedState());
    });
  }

  FutureOr<void> postAddInitialEvent(JobProfileAddInitialEvent event, Emitter<CreateJobProfileState> emit) {
    emit(JobProfileAddInitialState());
  }

  FutureOr<void> jobProfileAddUpdateButtonPressEvent(JobProfileAddUpdateButtonPressEvent event, Emitter<CreateJobProfileState> emit) async {
    emit(AddJobProfileLoadingState());
    final result = await updateJobProfile(event.updatedJobProfile);

    result!.fold((failure) {
      emit(AddJobProfileErrorState(message: mapFailureToMessage(failure)));
    }, (result) {
      emit(AddJobProfileUpdatedState());
    });
  }
}
