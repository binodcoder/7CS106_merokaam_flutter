import 'package:dartz/dartz.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/models/user_model.dart';
import '../../../../core/network/network_info.dart';
import '../../../domain/register/repositories/user_repositories.dart';
import '../datasources/user_remote_data_source.dart';

class UserRepositoriesImpl implements UserRepository {
  final UserRemoteDataSource addUserRemoteDataSource;
  final NetworkInfo networkInfo;
  UserRepositoriesImpl({
    required this.addUserRemoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, int>>? addUser(UserModel userModel) async {
    if (await networkInfo.isConnected) {
      try {
        int response = await addUserRemoteDataSource.addUser(userModel);
        return Right(response);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(NetworkFailure());
    }
  }
}
