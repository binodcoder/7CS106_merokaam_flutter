import '../../resources/strings_manager.dart';
import '../errors/exceptions.dart';
import '../errors/failures.dart';

String mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return AppStrings.serverFailureMessage;
    case CacheFailure:
      return AppStrings.cacheFailureMessage;
    case LoginFailure:
      return AppStrings.loginFailureMessage;
    case NetworkFailure:
      return AppStrings.networkFailureMessage;
    case BadRequestFailure:
      return AppStrings.badRequestFailureMessage;
    case NotFoundFailure:
      return AppStrings.notFoundFailureMessage;
    case TimeoutFailure:
      return AppStrings.timeoutFailureMessage;
    case UnauthorizedFailure:
      return AppStrings.unauthorizedFailureMessage;
    default:
      return 'Unexpected error';
  }
}

Failure mapExceptionToFailure(AppException exception) {
  if (exception is ServerException) {
    return ServerFailure(exception.message);
  } else if (exception is CacheException) {
    return CacheFailure(exception.message);
  } else if (exception is NetworkException) {
    return NetworkFailure(exception.message);
  } else if (exception is BadRequestException) {
    return BadRequestFailure(exception.message);
  } else if (exception is NotFoundException) {
    return NotFoundFailure(exception.message);
  } else if (exception is UnauthorizedException) {
    return UnauthorizedFailure(exception.message);
  } else if (exception is CustomTimeoutException) {
    return TimeoutFailure(exception.message);
  } else {
    return const UnknownFailure('An unknown error occurred.');
  }
}
