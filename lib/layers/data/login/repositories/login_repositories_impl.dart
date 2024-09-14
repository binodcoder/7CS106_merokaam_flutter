import 'package:dartz/dartz.dart';
import '../../../../core/entities/login.dart';
import '../../../../core/entities/user.dart';
import '../../../../core/entities/user_info_response.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../../domain/login/repositories/login_repositories.dart';
import '../datasources/login_remote_data_source.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  LoginRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });
/*
Either is class from dartz package which helps to do functional programming
when login is success Right side will return otherwise left.
 */
  @override
  Future<Either<Failure, UserInfoResponse>>? login(LoginModel loginModel) async {
    if (await networkInfo.isConnected) {
      try {
        UserInfoResponse response = await remoteDataSource.login(loginModel);
        return Right(response);
      } on LoginException {
        return Left(LoginFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
