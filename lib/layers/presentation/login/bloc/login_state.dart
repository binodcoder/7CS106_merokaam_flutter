import 'package:merokaam/core/errors/failures.dart';

abstract class LoginState {}

abstract class LoginActionState extends LoginState {}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginActionState {}

class ReadyToLoginState extends LoginState {}

class LoggedState extends LoginActionState {}

class LoginErrorState extends LoginActionState {
  final Failure failure;

  LoginErrorState(this.failure);
}
