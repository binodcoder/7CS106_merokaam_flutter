import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:merokaam/core/entities/login.dart';
import 'package:merokaam/layers/presentation/JobProfile/read_job_profile/ui/read_job_profile_page.dart';
import 'package:merokaam/layers/presentation/login/bloc/login_bloc.dart';
import 'package:merokaam/layers/presentation/login/bloc/login_event.dart';
import 'package:merokaam/layers/presentation/login/bloc/login_state.dart';
import 'package:merokaam/layers/presentation/login/ui/login_screen.dart';
import 'package:merokaam/layers/presentation/login/widgets/sign_in_button.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_test/bloc_test.dart';

// Mock classes
class MockLoginBloc extends MockBloc<LoginEvent, LoginState> implements LoginBloc {}

void main() {
  group('LoginPage Tests', () {
    late LoginBloc loginBloc;

    setUp(() {
      loginBloc = MockLoginBloc();
    });

    tearDown(() {
      loginBloc.close();
    });

    testWidgets('Renders LoginPage UI components', (WidgetTester tester) async {
      await tester.pumpWidget(
        BlocProvider.value(
          value: loginBloc,
          child: const MaterialApp(home: LoginPage()),
        ),
      );

      // Check if all UI components are present
      expect(find.text('Merokaam'), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(2));
      expect(find.byType(FlareActor), findsOneWidget);
      expect(find.byType(SigninButton), findsOneWidget);
    });

    testWidgets('Displays error message on invalid input', (WidgetTester tester) async {
      await tester.pumpWidget(
        BlocProvider.value(
          value: loginBloc,
          child: const MaterialApp(home: LoginPage()),
        ),
      );

      // Enter invalid email and password
      await tester.enterText(find.byKey(const ValueKey('email_id')), '');
      await tester.enterText(find.byKey(const ValueKey('password')), '');

      // Tap the login button
      await tester.tap(find.byType(SigninButton));
      await tester.pump();

      // Check if validation error is displayed
      expect(find.text('Please enter your username'), findsOneWidget);
      expect(find.text('Please enter your password'), findsOneWidget);
    });

    testWidgets('Triggers LoginButtonPressEvent on valid input', (WidgetTester tester) async {
      when(loginBloc.state).thenReturn(LoginInitialState());

      await tester.pumpWidget(
        BlocProvider.value(
          value: loginBloc,
          child: const MaterialApp(home: LoginPage()),
        ),
      );

      // Enter valid email and password
      await tester.enterText(find.byKey(const ValueKey('email_id')), 'test@example.com');
      await tester.enterText(find.byKey(const ValueKey('password')), 'password123');

      // Tap the login button
      await tester.tap(find.byType(SigninButton));
      await tester.pump();

      // Verify that LoginButtonPressEvent is added
      verify(loginBloc.add(LoginButtonPressEvent(LoginModel(
        email: 'test@example.com',
        password: 'password123',
      )))).called(1);
    });

    testWidgets('Shows CircularProgressIndicator when in loading state', (WidgetTester tester) async {
      when(loginBloc.state).thenReturn(LoginLoadingState());

      await tester.pumpWidget(
        BlocProvider.value(
          value: loginBloc,
          child: const MaterialApp(home: LoginPage()),
        ),
      );

      // Verify that the CircularProgressIndicator is shown
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('Navigates to ReadJobProfilePage on successful login', (WidgetTester tester) async {
      when(loginBloc.state).thenReturn(LoggedState());

      await tester.pumpWidget(
        BlocProvider.value(
          value: loginBloc,
          child: const MaterialApp(home: LoginPage()),
        ),
      );

      await tester.pumpAndSettle();

      // Verify that the navigation to ReadJobProfilePage occurred
      expect(find.byType(ReadJobProfilePage), findsOneWidget);
    });
  });
}
