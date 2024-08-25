// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:get_it/get_it.dart';
// import 'package:merokaam/layers/presentation/login/bloc/login_bloc.dart';
// import 'package:merokaam/layers/presentation/login/ui/login_screen.dart';
// import 'package:merokaam/layers/presentation/login/widgets/sign_in_button.dart';
// import 'package:mockito/annotations.dart';
// import 'login_screen_test.mocks.dart';
//
// @GenerateMocks([LoginBloc])
// void main() {
//   final sl = GetIt.instance;
//
//   setUp(() {
//     // Registering the mock LoginBloc
//
//     sl.registerFactory<LoginBloc>(() => MockLoginBloc());
//   });
//
//   tearDown(() {
//     // Reset the GetIt instance after each test
//     sl.reset();
//   });
//   testWidgets("Should have a title", (WidgetTester tester) async {
//     // ARRANGE
//     await tester.pumpWidget(
//       const MaterialApp(
//         home: LoginPage(),
//       ),
//     );
//     // Ensures the widget tree has fully built
//     await tester.pumpAndSettle();
//     // ACT
//     Finder title = find.text("Login");
//     // ASSERT
//     expect(title, findsOneWidget);
//   });
//
//   testWidgets("Should have one text field form to collect user email id", (WidgetTester tester) async {
//     // ARRANGE
//     await tester.pumpWidget(
//       const MaterialApp(
//         home: LoginPage(),
//       ),
//     );
//     // ACT
//     Finder userNameTextField = find.byKey(const ValueKey("email_id"));
//
//     // ASSERT
//     expect(userNameTextField, findsOneWidget);
//   });
//
//   testWidgets("Should have one text field form to collect user password", (WidgetTester tester) async {
//     // ARRANGE
//     await tester.pumpWidget(
//       const MaterialApp(
//         home: LoginPage(),
//       ),
//     );
//     // ACT
//     Finder passwordTextField = find.byKey(const ValueKey("password"));
//
//     // ASSERT
//     expect(passwordTextField, findsOneWidget);
//   });
//
//   testWidgets("Should have one login button", (WidgetTester tester) async {
//     // ARRANGE
//     await tester.pumpWidget(
//       const MaterialApp(
//         home: LoginPage(),
//       ),
//     );
//     // ACT
//     Finder loginButton = find.byType(SigninButton);
//
//     // ASSERT
//     expect(loginButton, findsOneWidget);
//   });
//
//   testWidgets("Should show Required Fields error message if user email id and password is empty", (WidgetTester tester) async {
//     // ARRANGE
//     await tester.pumpWidget(
//       const MaterialApp(
//         home: LoginPage(),
//       ),
//     );
//     // ACT
//     Finder loginButton = find.byType(SigninButton);
//     await tester.tap(loginButton);
//     await tester.pumpAndSettle();
//     Finder errorTexts = find.text("Required Field");
//
//     // ASSERT
//     expect(errorTexts, findsNWidgets(2));
//   });
//
//   // tests for validation errors
//
//   // tests for success case
//   testWidgets("Should submit form when user email id and password is valid", (WidgetTester tester) async {
//     // ARRANGE
//     await tester.pumpWidget(
//       const MaterialApp(
//         home: LoginPage(),
//       ),
//     );
//
//     // ACT
//     Finder userNameTextField = find.byKey(const ValueKey("email_id"));
//     Finder passwordTextField = find.byKey(const ValueKey("password"));
//     await tester.enterText(userNameTextField, "binod@gmail.com");
//     await tester.enterText(passwordTextField, "P@ssw0rd123!");
//     Finder loginButton = find.byType(SigninButton);
//     await tester.tap(loginButton);
//     await tester.pumpAndSettle();
//     Finder errorTexts = find.text("Required Field");
//
//     // ASSERT
//     expect(errorTexts, findsNothing);
//   });
// }
