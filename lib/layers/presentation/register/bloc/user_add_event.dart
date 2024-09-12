abstract class UserAddEvent {}

class UserAddInitialEvent extends UserAddEvent {}

class UserAddPickFromGalaryButtonPressEvent extends UserAddEvent {}

class UserAddPickFromCameraButtonPressEvent extends UserAddEvent {}

class UserAddSaveButtonPressEvent extends UserAddEvent {
  String email;
  String password;

  UserAddSaveButtonPressEvent(
    this.email,
    this.password,
  );
}

class UserAddUpdateButtonPressEvent extends UserAddEvent {
  // final UserModel updatedUser;
  // UserAddUpdateButtonPressEvent(this.updatedUser);
}

class UserAddReadyToUpdateEvent extends UserAddEvent {
  // final UserModel userModel;
  // UserAddReadyToUpdateEvent(this.userModel);
}
