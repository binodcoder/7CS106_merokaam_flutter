import '../errors/exceptions.dart';
import '../errors/failures.dart';

Failure mapExceptionToFailure(AppException exception) {
  final exceptionToFailureMap = <Type, Failure Function(AppException)>{
    ServerException: (e) => ServerFailure(e.message, e.cause),
    CacheException: (e) => CacheFailure(e.message, e.cause),
    NetworkException: (e) => NetworkFailure(e.message, e.cause),
    BadRequestException: (e) => BadRequestFailure(e.message, e.cause),
    NotFoundException: (e) => NotFoundFailure(e.message, e.cause),
    UnauthorizedException: (e) => UnauthorizedFailure(e.message, e.cause),
    CustomTimeoutException: (e) => TimeoutFailure(e.message, e.cause),
    LoginException: (e) => LoginFailure(e.message, e.cause),
    DatabaseInitializationException: (e) => DatabaseInitializationFailure(e.message, e.cause),
    DataFormatException: (e) => DataFormatFailure(e.message, e.cause),
    DatabaseOperationException: (e) => DatabaseOperationFailure(e.message, e.cause),
    InvalidFormatException: (e) => InvalidFormatFailure(e.message, e.cause),
    ParsingException: (e) => ParsingFailure(e.message, e.cause),
    ArgumentException: (e) => ArgumentFailure(e.message, e.cause),
    UnknownException: (e) => UnknownFailure(e.message, e.cause),
  };

  final failureConstructor = exceptionToFailureMap[exception.runtimeType];

  if (failureConstructor != null) {
    return failureConstructor(exception);
  } else {
    // Handle any other types of AppException
    return UnknownFailure(exception.message, exception.cause);
  }
}
