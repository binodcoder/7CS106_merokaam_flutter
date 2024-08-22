import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:merokaam/layers/presentation/login/ui/login_screen.dart';
import 'package:merokaam/layers/presentation/login/widgets/sign_in_button.dart';

void main() {
  group("Login Flow Test", () {
    IntegrationTestWidgetsFlutterBinding.ensureInitialized();
    testWidgets("Should show home screen when user taps on login button after entering valid email id & password", (WidgetTester tester) async {
      // ARRANGE
      await tester.pumpWidget(
        const MaterialApp(
          home: LoginPage(),
        ),
      );

      // ACT
      Finder userNameTextField = find.byKey(const ValueKey("email_id"));
      Finder passwordTextField = find.byKey(const ValueKey("password"));
      await tester.enterText(userNameTextField, "binod@gmail.com");
      await tester.enterText(passwordTextField, "P@ssw0rd123!");
      Finder loginButton = find.byType(SigninButton);
      await tester.tap(loginButton);
      // waits for the frames to settle down
      await tester.pumpAndSettle();

      Finder welcomeText = find.byType(Text);

      // ASSERT
      expect(welcomeText, findsOneWidget);
    });
  });
}
