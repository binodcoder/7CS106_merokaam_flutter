abstract class UserAddState {
  final String? imagePath;
  UserAddState({this.imagePath});
}

abstract class UserAddActionState extends UserAddState {}

class UserAddInitialState extends UserAddState {}

class UserAddReadyToUpdateState extends UserAddState {
  UserAddReadyToUpdateState(imagePath) : super(imagePath: imagePath);
}

class AddUserImagePickedFromGalaryState extends UserAddState {
  AddUserImagePickedFromGalaryState(imagePath) : super(imagePath: imagePath);
}

class AddUserImagePickedFromCameraState extends UserAddState {
  AddUserImagePickedFromCameraState(imagePath) : super(imagePath: imagePath);
}

class AddUserLoadingState extends UserAddActionState {}

class AddUserSavedState extends UserAddActionState {}

class AddUserUpdatedState extends UserAddActionState {}

class AddUserErrorState extends UserAddActionState {
  final String message;

  AddUserErrorState({required this.message});
}
