import 'package:dartz/dartz.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/models/user_model.dart';
import '../../../domain/register/repositories/user_repositories.dart';
import '../datasources/user_remote_data_source.dart';

class UserRepositoriesImpl implements UserRepository {
  final UserRemoteDataSource addUserRemoteDataSource;
  UserRepositoriesImpl({
    required this.addUserRemoteDataSource,
  });

  @override
  Future<Either<Failure, int>>? addUser(UserModel userModel) async {
    try {
      int response = await addUserRemoteDataSource.addUser(userModel);
      return Right(response);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
