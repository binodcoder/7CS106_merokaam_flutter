// Mocks generated by Mockito 5.4.4 from annotations
// in merokaam/test/layers/presentation/login/ui/login_screen_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;

import 'package:flutter_bloc/flutter_bloc.dart' as _i8;
import 'package:merokaam/core/entities/user_info_response.dart' as _i9;
import 'package:merokaam/layers/domain/login/usecases/login.dart' as _i2;
import 'package:merokaam/layers/presentation/login/bloc/login_bloc.dart' as _i5;
import 'package:merokaam/layers/presentation/login/bloc/login_event.dart'
    as _i7;
import 'package:merokaam/layers/presentation/login/bloc/login_state.dart'
    as _i4;
import 'package:mockito/mockito.dart' as _i1;
import 'package:shared_preferences/shared_preferences.dart' as _i3;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeLogin_0 extends _i1.SmartFake implements _i2.Login {
  _FakeLogin_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeSharedPreferences_1 extends _i1.SmartFake
    implements _i3.SharedPreferences {
  _FakeSharedPreferences_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeLoginState_2 extends _i1.SmartFake implements _i4.LoginState {
  _FakeLoginState_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [LoginBloc].
///
/// See the documentation for Mockito's code generation for more information.
class MockLoginBloc extends _i1.Mock implements _i5.LoginBloc {
  MockLoginBloc() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.Login get login => (super.noSuchMethod(
        Invocation.getter(#login),
        returnValue: _FakeLogin_0(
          this,
          Invocation.getter(#login),
        ),
      ) as _i2.Login);

  @override
  _i3.SharedPreferences get sharedPreferences => (super.noSuchMethod(
        Invocation.getter(#sharedPreferences),
        returnValue: _FakeSharedPreferences_1(
          this,
          Invocation.getter(#sharedPreferences),
        ),
      ) as _i3.SharedPreferences);

  @override
  _i4.LoginState get state => (super.noSuchMethod(
        Invocation.getter(#state),
        returnValue: _FakeLoginState_2(
          this,
          Invocation.getter(#state),
        ),
      ) as _i4.LoginState);

  @override
  _i6.Stream<_i4.LoginState> get stream => (super.noSuchMethod(
        Invocation.getter(#stream),
        returnValue: _i6.Stream<_i4.LoginState>.empty(),
      ) as _i6.Stream<_i4.LoginState>);

  @override
  bool get isClosed => (super.noSuchMethod(
        Invocation.getter(#isClosed),
        returnValue: false,
      ) as bool);

  @override
  _i6.FutureOr<void> loginInitialEvent(
    _i7.LoginInitialEvent? event,
    _i8.Emitter<_i4.LoginState>? emit,
  ) =>
      (super.noSuchMethod(Invocation.method(
        #loginInitialEvent,
        [
          event,
          emit,
        ],
      )) as _i6.FutureOr<void>);

  @override
  _i6.FutureOr<void> loginButtonPressEvent(
    _i7.LoginButtonPressEvent? event,
    _i8.Emitter<_i4.LoginState>? emit,
  ) =>
      (super.noSuchMethod(Invocation.method(
        #loginButtonPressEvent,
        [
          event,
          emit,
        ],
      )) as _i6.FutureOr<void>);

  @override
  dynamic saveUserData(_i9.UserInfoResponse? userInfoResponse) =>
      super.noSuchMethod(Invocation.method(
        #saveUserData,
        [userInfoResponse],
      ));

  @override
  void add(_i7.LoginEvent? event) => super.noSuchMethod(
        Invocation.method(
          #add,
          [event],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void onEvent(_i7.LoginEvent? event) => super.noSuchMethod(
        Invocation.method(
          #onEvent,
          [event],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void emit(_i4.LoginState? state) => super.noSuchMethod(
        Invocation.method(
          #emit,
          [state],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void on<E extends _i7.LoginEvent>(
    _i8.EventHandler<E, _i4.LoginState>? handler, {
    _i8.EventTransformer<E>? transformer,
  }) =>
      super.noSuchMethod(
        Invocation.method(
          #on,
          [handler],
          {#transformer: transformer},
        ),
        returnValueForMissingStub: null,
      );

  @override
  void onTransition(
          _i8.Transition<_i7.LoginEvent, _i4.LoginState>? transition) =>
      super.noSuchMethod(
        Invocation.method(
          #onTransition,
          [transition],
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i6.Future<void> close() => (super.noSuchMethod(
        Invocation.method(
          #close,
          [],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  void onChange(_i8.Change<_i4.LoginState>? change) => super.noSuchMethod(
        Invocation.method(
          #onChange,
          [change],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void addError(
    Object? error, [
    StackTrace? stackTrace,
  ]) =>
      super.noSuchMethod(
        Invocation.method(
          #addError,
          [
            error,
            stackTrace,
          ],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void onError(
    Object? error,
    StackTrace? stackTrace,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #onError,
          [
            error,
            stackTrace,
          ],
        ),
        returnValueForMissingStub: null,
      );
}
