import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:merokaam/layers/presentation/register/bloc/user_add_event.dart';
import 'package:merokaam/layers/presentation/register/bloc/user_add_state.dart';
import '../../../../core/mappers/map_failure_to_message.dart';
import '../../../../core/models/user_model.dart';
import '../../../domain/register/usecases/add_user.dart';

class UserAddBloc extends Bloc<UserAddEvent, UserAddState> {
  final AddUser addUser;
  UserAddBloc({
    required this.addUser,
  }) : super(UserAddInitialState()) {
    on<UserAddInitialEvent>(postAddInitialEvent);
    on<UserAddSaveButtonPressEvent>(userAddSaveButtonPressEvent);
  }

  FutureOr<void> postAddInitialEvent(UserAddInitialEvent event, Emitter<UserAddState> emit) {
    emit(UserAddInitialState());
  }

  FutureOr<void> userAddSaveButtonPressEvent(UserAddSaveButtonPressEvent event, Emitter<UserAddState> emit) async {
    UserModel newUser = UserModel(
      email: event.email,
      password: event.password,
    );
    emit(AddUserLoadingState());
    final failureOrSuccess = await addUser(newUser);
    failureOrSuccess!.fold((failure) {
      emit(AddUserErrorState(failure));
    }, (success) {
      emit(AddUserSavedState());
    });
  }
}
