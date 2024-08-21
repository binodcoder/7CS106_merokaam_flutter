import 'package:flutter_test/flutter_test.dart';
import 'package:merokaam/core/entities/login.dart';
import 'package:merokaam/core/entities/user_info_response.dart';
import 'package:merokaam/core/models/user_model.dart';
import 'package:merokaam/layers/domain/login/repositories/login_repositories.dart';
import 'package:merokaam/layers/domain/login/usecases/login.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';

class MockLoginRepository extends Mock implements LoginRepository {}

void main() {
  late Login usecase;
  late MockLoginRepository mockLoginRepository;
  setUp(() {
    mockLoginRepository = MockLoginRepository();
    usecase = Login(mockLoginRepository);
  });

  UserInfoResponse tUser = UserInfoResponse(
    id: 0,
    jwtToken: '',
    username: '',
    userTypeName: '',
  );
  LoginModel tLoginModel = LoginModel(email: "", password: "");
  test(
    'should get user from the repository',
    () async {
      when(mockLoginRepository.login(tLoginModel)).thenAnswer((_) async => Right(tUser));
      final result = await usecase(tLoginModel);
      expect(result, Right(tUser));
      verify(mockLoginRepository.login(tLoginModel));
      verifyNoMoreInteractions(mockLoginRepository);
    },
  );
}
