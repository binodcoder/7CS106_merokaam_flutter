import '../../../../core/errors/failures.dart';

abstract class UserAddState {}

abstract class UserAddActionState extends UserAddState {}

class UserAddInitialState extends UserAddState {}

class AddUserLoadingState extends UserAddActionState {}

class AddUserSavedState extends UserAddActionState {}

class AddUserErrorState extends UserAddActionState {
  final Failure failure;

  AddUserErrorState(this.failure);
}
