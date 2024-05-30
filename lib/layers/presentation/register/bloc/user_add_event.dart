abstract class UserAddEvent {}

class UserAddInitialEvent extends UserAddEvent {}

class UserAddPickFromGalaryButtonPressEvent extends UserAddEvent {}

class UserAddPickFromCameraButtonPressEvent extends UserAddEvent {}

class UserAddSaveButtonPressEvent extends UserAddEvent {
  String age;
  String email;
  String gender;
  String institutionEmail;
  String name;
  String password;
  String role;
  UserAddSaveButtonPressEvent(
    this.age,
    this.email,
    this.gender,
    this.institutionEmail,
    this.name,
    this.password,
    this.role,
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
