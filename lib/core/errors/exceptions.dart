class AppException implements Exception {
  final String message;
  final dynamic cause;

  AppException([this.message = 'An unknown error occurred.', this.cause = 'Unknown cause']);
}

class CacheException extends AppException {
  CacheException([String message = 'Cache Failure.', dynamic cause = ""]) : super(message, cause);
}

class LoginException extends AppException {
  LoginException([String message = 'Invalid Username or Password.', dynamic cause = ""]) : super(message, cause);
}

class ServerException extends AppException {
  ServerException([String message = 'Server error occurred.', dynamic cause = ""]) : super(message, cause);
}

class NetworkException extends AppException {
  NetworkException([String message = 'No internet connection..', dynamic cause = ""]) : super(message, cause);
}

class BadRequestException extends AppException {
  BadRequestException([String message = 'Invalid request.', dynamic cause = ""]) : super(message, cause);
}

class NotFoundException extends AppException {
  NotFoundException([String message = 'Resource Not Found.', dynamic cause = ""]) : super(message, cause);
}

class CustomTimeoutException extends AppException {
  CustomTimeoutException([String message = 'Connection Timeout.', dynamic cause = ""]) : super(message, cause);
}

class UnauthorizedException extends AppException {
  UnauthorizedException([String message = 'Unauthorized access.', dynamic cause = ""]) : super(message, cause);
}

class DatabaseInitializationException extends AppException {
  DatabaseInitializationException([String message = 'Database initialization error.', dynamic cause = ""]) : super(message, cause);
}

class DataFormatException extends AppException {
  DataFormatException([String message = 'Data format error.', dynamic cause = ""]) : super(message, cause);
}

class DatabaseOperationException extends AppException {
  DatabaseOperationException([String message = 'Database operation error.', dynamic cause = ""]) : super(message, cause);
}

class InvalidFormatException extends AppException {
  InvalidFormatException([String message = 'Invalid response format.', dynamic cause = ""]) : super(message, cause);
}

class ParsingException extends AppException {
  ParsingException([String message = 'Invalid response format.', dynamic cause = ""]) : super(message, cause);
}

class ArgumentException extends AppException {
  ArgumentException([String message = 'invalid argument.', dynamic cause = ""]) : super(message, cause);
}

class UnknownException extends AppException {
  UnknownException([String message = 'An unknown error occurred.', dynamic cause = ""]) : super(message, cause);
}
