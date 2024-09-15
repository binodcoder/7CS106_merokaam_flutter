import '../../resources/strings_manager.dart';
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
    default:
      return 'Unexpected error';
  }
}
