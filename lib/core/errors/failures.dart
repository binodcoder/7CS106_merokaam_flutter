import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  const Failure([this.message = 'An unknown failure occurred.']);

  @override
  List<Object> get props => [message];

  // const Failure([List properties = const <dynamic>[]]);
}

class ServerFailure extends Failure {
  const ServerFailure([String message = 'Server failure occurred.']) : super(message);

  @override
  List<Object> get props => [message];
}

class CacheFailure extends Failure {
  const CacheFailure([String message = 'Cache failure occurred.']) : super(message);
  @override
  List<Object> get props => [message];
}

class LoginFailure extends Failure {
  const LoginFailure([String message = 'Login failure occurred.']) : super(message);
  @override
  List<Object> get props => [message];
}

class NetworkFailure extends Failure {
  const NetworkFailure([String message = 'Network failure occurred.']) : super(message);
  @override
  List<Object> get props => [message];
}

class BadRequestFailure extends Failure {
  const BadRequestFailure([String message = 'Bad request failure occurred.']) : super(message);
  @override
  List<Object> get props => [message];
}

class NotFoundFailure extends Failure {
  const NotFoundFailure([String message = 'Not found failure occurred.']) : super(message);
  @override
  List<Object> get props => [message];
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure([String message = 'Unauthorized failure occurred.']) : super(message);
  @override
  List<Object> get props => [message];
}

class TimeoutFailure extends Failure {
  const TimeoutFailure([String message = 'Timeout failure occurred.']) : super(message);
  @override
  List<Object> get props => [message];
}

class UnknownFailure extends Failure {
  const UnknownFailure([String message = 'Unknown failure occurred.']) : super(message);
  @override
  List<Object> get props => [message];
}
