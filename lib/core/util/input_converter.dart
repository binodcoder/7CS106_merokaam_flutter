import 'package:dartz/dartz.dart';
import '../errors/failures.dart';

class InputConverter {
  Either<Failure, int> stringToUnsignedInteger(String string) {
    try {
      final integer = int.parse(string);
      if (integer < 0) throw const FormatException();
      return Right(integer);
    } on FormatException {
      return const Left(InvalidInputFailure());
    }
  }
}

class InvalidInputFailure extends Failure {
  const InvalidInputFailure([String message = 'Server failure occurred.']) : super(message);
  @override
  List<Object> get props => [message];
}
