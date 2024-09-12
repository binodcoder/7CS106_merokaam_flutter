import 'package:equatable/equatable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/models/user_model.dart';
import '../../../../core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import '../repositories/user_repositories.dart';

class AddUser implements UseCase<int, UserModel> {
  final UserRepository addUserRepository;

  AddUser(this.addUserRepository);

  @override
  Future<Either<Failure, int>?> call(UserModel userModel) async {
    return await addUserRepository.addUser(userModel);
  }
}

class Params extends Equatable {
  final int number;

  const Params({required this.number});

  @override
  List<Object?> get props => [number];
}
