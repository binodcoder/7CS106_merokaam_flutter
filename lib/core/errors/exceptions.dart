class AppException implements Exception {
  final String message;
  AppException([this.message = 'An unknown error occurred.']);
}

class CacheException extends AppException {
  CacheException([String message = 'Cache Failure.']) : super(message);
}

class LoginException extends AppException {
  LoginException([String message = 'Invalid Username or Password.']) : super(message);
}

class ServerException extends AppException {
  ServerException([String message = 'Server error occurred.']) : super(message);
}

class NetworkException extends AppException {
  NetworkException([String message = 'No internet connection..']) : super(message);
}

class BadRequestException extends AppException {
  BadRequestException([String message = 'Email is already registered.']) : super(message);
}

class NotFoundException extends AppException {
  NotFoundException([String message = 'Not Found.']) : super(message);
}

class CustomTimeoutException extends AppException {
  CustomTimeoutException([String message = 'Timeout.']) : super(message);
}

class UnauthorizedException extends AppException {
  UnauthorizedException([String message = 'Unauthorized.']) : super(message);
}
