import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/models/user_model.dart';

abstract class UserRepository {
  Future<Either<Failure, int>>? addUser(UserModel userModel);
}
