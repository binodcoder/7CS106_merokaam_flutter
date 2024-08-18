import 'package:dartz/dartz.dart';
import '../../../../core/entities/login.dart';
import '../../../../core/entities/user_info_response.dart';
import '../../../../core/errors/failures.dart';

//This is an abstract class, meaning it only provides a definition of the 'login' method but does not implement it.
//Concrete subclasses would need to provide implementations for the 'login' method.
abstract class LoginRepository {
  Future<Either<Failure, UserInfoResponse>>? login(LoginModel loginModel);
}
