import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:merokaam/layers/presentation/register/bloc/user_add_event.dart';
import 'package:merokaam/layers/presentation/register/bloc/user_add_state.dart';

class UserAddBloc extends Bloc<UserAddEvent, UserAddState> {
  UserAddBloc() : super(UserAddInitialState()) {
    on<UserAddInitialEvent>(postAddInitialEvent);
    on<UserAddReadyToUpdateEvent>(postAddReadyToUpdateEvent);
    on<UserAddPickFromGalaryButtonPressEvent>(addPostPickFromGalaryButtonPressEvent);
    on<UserAddSaveButtonPressEvent>(userAddSaveButtonPressEvent);
    on<UserAddUpdateButtonPressEvent>(postAddUpdateButtonPressEvent);
  }

  FutureOr<void> addPostPickFromGalaryButtonPressEvent(UserAddPickFromGalaryButtonPressEvent event, Emitter<UserAddState> emit) async {}

  FutureOr<void> postAddInitialEvent(UserAddInitialEvent event, Emitter<UserAddState> emit) {
    emit(UserAddInitialState());
  }

  FutureOr<void> postAddUpdateButtonPressEvent(UserAddUpdateButtonPressEvent event, Emitter<UserAddState> emit) async {
    emit(AddUserUpdatedState());
  }

  FutureOr<void> postAddReadyToUpdateEvent(UserAddReadyToUpdateEvent event, Emitter<UserAddState> emit) {
    // emit(PostAddReadyToUpdateState(event.postModel.imagePath));
  }

  FutureOr<void> userAddSaveButtonPressEvent(UserAddSaveButtonPressEvent event, Emitter<UserAddState> emit) async {}
}
