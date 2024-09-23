import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:merokaam/core/entities/login.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:merokaam/core/entities/user_info_response.dart';
import 'package:merokaam/core/errors/failures.dart';
import 'package:merokaam/layers/presentation/login/bloc/login_bloc.dart';
import 'package:merokaam/layers/presentation/login/bloc/login_event.dart';
import 'package:merokaam/layers/presentation/login/bloc/login_state.dart';
import 'package:merokaam/layers/domain/login/usecases/login.dart';

import 'login_bloc_test.mocks.dart';

@GenerateMocks([Login, SharedPreferences])
void main() {
  late MockLogin mockLogin;
  late MockSharedPreferences mockSharedPreferences;
  late LoginBloc loginBloc;

  setUp(() {
    mockLogin = MockLogin();
    mockSharedPreferences = MockSharedPreferences();

    // Register the mock in GetIt
    final sl = GetIt.instance;
    sl.registerLazySingleton<SharedPreferences>(() => mockSharedPreferences);

    // Now you can initialize your LoginBloc

    loginBloc = LoginBloc(login: mockLogin);

    // Stub the setString method to always return true (successful save)
    when(mockSharedPreferences.setString(any, any)).thenAnswer((_) async => true);
  });

  tearDown(() {
    loginBloc.close();
    // Reset GetIt after each test to prevent side effects between tests
    GetIt.instance.reset();
  });

  final tLoginModel = LoginModel(
    email: 'test',
    password: '123',
  );
  final tUserInfoResponse = UserInfoResponse(
    id: 0,
    jwtToken: 'testToken',
    username: '',
    userTypeName: '',
  );

  group('LoginBloc Tests', () {
    blocTest<LoginBloc, LoginState>(
      'emits [LoginLoadingState, LoginErrorState] when login fails',
      build: () {
        when(mockLogin(any)).thenAnswer((_) async => const Left(LoginFailure()));
        return loginBloc;
      },
      act: (bloc) => bloc.add(LoginButtonPressEvent(tLoginModel)),
      expect: () => [
        isA<LoginLoadingState>(),
        isA<LoginErrorState>(),
      ],
      verify: (_) {
        verify(mockLogin(any)).called(1);
        verifyNever(mockSharedPreferences.setString('jwt_token', any));
      },
    );
  });
}
