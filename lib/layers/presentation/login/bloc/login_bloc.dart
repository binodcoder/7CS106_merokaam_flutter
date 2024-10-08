import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merokaam/core/entities/user_info_response.dart';
import 'package:merokaam/layers/presentation/login/bloc/login_event.dart';
import 'package:merokaam/layers/presentation/login/bloc/login_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../injection_container.dart';
import '../../../domain/login/usecases/login.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final Login login;
  final SharedPreferences sharedPreferences = sl<SharedPreferences>();

  LoginBloc({required this.login}) : super(LoginInitialState()) {
    on<LoginInitialEvent>(loginInitialEvent);
    on<LoginButtonPressEvent>(loginButtonPressEvent);
  }

  FutureOr<void> loginInitialEvent(LoginInitialEvent event, Emitter<LoginState> emit) {
    emit(LoginInitialState());
  }

  FutureOr<void> loginButtonPressEvent(LoginButtonPressEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoadingState());
    final result = await login(event.loginModel);
    result!.fold((failure) {
      emit(LoginErrorState(failure));
    }, (result) {
      emit(LoggedState());
      saveUserData(result);
    });
  }

  saveUserData(UserInfoResponse userInfoResponse) {
    sharedPreferences.setBool('login', true);
    sharedPreferences.setString('jwt_token', userInfoResponse.jwtToken);
    sharedPreferences.setInt("id", userInfoResponse.id ?? 1);
    sharedPreferences.setString("email", userInfoResponse.username ?? "");
    sharedPreferences.setString("role", userInfoResponse.userTypeName ?? "");
  }
}
