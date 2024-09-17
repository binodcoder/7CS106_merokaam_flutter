import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  final dynamic cause;
  const Failure([this.message = 'An unknown failure occurred.', this.cause]);

  @override
  List<Object?> get props => [message, cause];
}

class ServerFailure extends Failure {
  const ServerFailure([String message = 'Server failure occurred.', dynamic cause = ""]) : super(message, cause);

  @override
  List<Object?> get props => [message, cause];
}

class CacheFailure extends Failure {
  const CacheFailure([String message = 'Cache failure occurred.', dynamic cause = ""]) : super(message, cause);

  @override
  List<Object?> get props => [message, cause];
}

class LoginFailure extends Failure {
  const LoginFailure([String message = 'Login failure occurred.', dynamic cause = ""]) : super(message, cause);

  @override
  List<Object?> get props => [message, cause];
}

class NetworkFailure extends Failure {
  const NetworkFailure([String message = 'Network failure occurred.', dynamic cause = ""]) : super(message, cause);

  @override
  List<Object?> get props => [message, cause];
}

class BadRequestFailure extends Failure {
  const BadRequestFailure([String message = 'Bad request failure occurred.', dynamic cause = ""]) : super(message, cause);

  @override
  List<Object?> get props => [message, cause];
}

class NotFoundFailure extends Failure {
  const NotFoundFailure([String message = 'Not found failure occurred.', dynamic cause = ""]) : super(message, cause);

  @override
  List<Object?> get props => [message, cause];
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure([String message = 'Unauthorized failure occurred.', dynamic cause = ""]) : super(message, cause);

  @override
  List<Object?> get props => [message, cause];
}

class TimeoutFailure extends Failure {
  const TimeoutFailure([String message = 'Timeout failure occurred.', dynamic cause = ""]) : super(message, cause);

  @override
  List<Object?> get props => [message, cause];
}

class DatabaseInitializationFailure extends Failure {
  const DatabaseInitializationFailure([String message = 'Database initialization failure occurred.', dynamic cause = ""]) : super(message, cause);

  @override
  List<Object?> get props => [message, cause];
}

class DataFormatFailure extends Failure {
  const DataFormatFailure([String message = 'Data format failure occurred.', dynamic cause = ""]) : super(message, cause);

  @override
  List<Object?> get props => [message, cause];
}

class DatabaseOperationFailure extends Failure {
  const DatabaseOperationFailure([String message = 'Database operation failure occurred.', dynamic cause = ""]) : super(message, cause);

  @override
  List<Object?> get props => [message, cause];
}

class InvalidFormatFailure extends Failure {
  const InvalidFormatFailure([String message = 'Invalid format failure occurred.', dynamic cause = ""]) : super(message, cause);

  @override
  List<Object?> get props => [message, cause];
}

class ParsingFailure extends Failure {
  const ParsingFailure([String message = 'Error parsing response.', dynamic cause = ""]) : super(message, cause);

  @override
  List<Object?> get props => [message, cause];
}

class ArgumentFailure extends Failure {
  const ArgumentFailure([String message = 'Error argument.', dynamic cause = ""]) : super(message, cause);

  @override
  List<Object?> get props => [message, cause];
}

class UnknownFailure extends Failure {
  const UnknownFailure([String message = 'An unknown failure occurred.', dynamic cause = ""]) : super(message, cause);

  @override
  List<Object?> get props => [message, cause];
}
