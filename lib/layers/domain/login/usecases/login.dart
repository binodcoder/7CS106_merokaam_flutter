import '../../../../core/entities/login.dart';
import '../../../../core/entities/user.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import '../repositories/login_repositories.dart';

class Login implements UseCase<User, LoginModel> {
  final LoginRepository loginRepository;

  Login(this.loginRepository);

  //this is from dartz package used to initiate a login process.
  @override
  Future<Either<Failure, User>?> call(LoginModel loginModel) async {
    return await loginRepository.login(loginModel);
  }
}
