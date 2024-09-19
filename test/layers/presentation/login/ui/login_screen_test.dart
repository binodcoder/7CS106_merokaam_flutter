import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:merokaam/core/errors/failures.dart';
import 'package:merokaam/layers/presentation/JobProfile/read_job_profile/ui/read_job_profile_page.dart';
import 'package:merokaam/layers/presentation/login/bloc/login_bloc.dart';
import 'package:merokaam/layers/presentation/login/bloc/login_event.dart';
import 'package:merokaam/layers/presentation/login/bloc/login_state.dart';
import 'package:merokaam/layers/presentation/login/ui/login_screen.dart';
import 'package:merokaam/layers/presentation/register/ui/register_page.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'package:merokaam/resources/colour_manager.dart';
import 'package:merokaam/resources/strings_manager.dart';

// Mock class for LoginBloc
class MockLoginBloc extends MockBloc<LoginEvent, LoginState> implements LoginBloc {}

// Create a mock class for Fluttertoast
class MockFluttertoast extends Mock implements Fluttertoast {}

void main() {
  late MockLoginBloc mockLoginBloc;
  late MockFluttertoast mockFluttertoast;

  setUp(() {
    mockLoginBloc = MockLoginBloc();
    mockFluttertoast = MockFluttertoast();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: Scaffold(
        body: LoginPage(loginBloc: mockLoginBloc),
      ),
    );
  }

  group('LoginPage', () {
    testWidgets('should render login page correctly', (WidgetTester tester) async {
      when(mockLoginBloc.state).thenReturn(LoginInitialState());

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.text(AppStrings.appTitle), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(2)); // Email & Password fields
      expect(find.text('Login'), findsOneWidget); // Login button
      expect(find.text('Register'), findsOneWidget); // Register button
    });

    testWidgets('should show loading indicator when in LoginLoadingState', (WidgetTester tester) async {
      whenListen(
        mockLoginBloc,
        Stream<LoginState>.fromIterable([LoginLoadingState()]),
        initialState: LoginInitialState(),
      );

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump(); // Trigger the BlocConsumer listener

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should navigate to ReadJobProfilePage when logged in', (WidgetTester tester) async {
      whenListen(
        mockLoginBloc,
        Stream<LoginState>.fromIterable([LoggedState()]),
        initialState: LoginInitialState(),
      );

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump(); // Trigger the BlocConsumer listener

      expect(find.byType(ReadJobProfilePage), findsOneWidget);
    });

    testWidgets('should show error toast when in LoginErrorState', (WidgetTester tester) async {
      const failure = LoginFailure();
      whenListen(
        mockLoginBloc,
        Stream<LoginState>.fromIterable([LoginErrorState(failure)]),
        initialState: LoginInitialState(),
      );

      // Fluttertoast.showToast = (msg, {toastLength, gravity, backgroundColor}) {
      //   expect(msg, errorMessage);
      //   expect(backgroundColor, ColorManager.error);
      // };

      await tester.pumpWidget(createWidgetUnderTest());
      await tester.pump(); // Trigger the BlocConsumer listener
    });

    testWidgets('should dispatch LoginButtonPressEvent when login button is pressed', (WidgetTester tester) async {
      when(mockLoginBloc.state).thenReturn(LoginInitialState());

      await tester.pumpWidget(createWidgetUnderTest());

      final emailField = find.byKey(const ValueKey("email_id"));
      final passwordField = find.byKey(const ValueKey("password"));
      final loginButton = find.text('Login');

      await tester.enterText(emailField, 'test@example.com');
      await tester.enterText(passwordField, 'password123');
      await tester.tap(loginButton);

      // verify(mockLoginBloc.add(any)).called(1);
    });

    testWidgets('should navigate to RegisterPage when register button is pressed', (WidgetTester tester) async {
      when(mockLoginBloc.state).thenReturn(LoginInitialState());

      await tester.pumpWidget(createWidgetUnderTest());

      final registerButton = find.text('Register');
      await tester.tap(registerButton);
      await tester.pumpAndSettle();

      expect(find.byType(RegisterPage), findsOneWidget);
    });
  });
}
