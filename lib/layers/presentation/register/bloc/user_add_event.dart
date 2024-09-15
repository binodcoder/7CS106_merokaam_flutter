abstract class UserAddEvent {}

class UserAddInitialEvent extends UserAddEvent {}

class UserAddSaveButtonPressEvent extends UserAddEvent {
  String email;
  String password;

  UserAddSaveButtonPressEvent(
    this.email,
    this.password,
  );
}
