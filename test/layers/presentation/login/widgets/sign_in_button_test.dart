import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:merokaam/layers/presentation/login/widgets/sign_in_button.dart';
import 'package:merokaam/resources/colour_manager.dart';
import 'package:merokaam/resources/strings_manager.dart';

void main() {
  group('SigningButton Widget Tests', () {
    testWidgets('Renders SigningButton with child widget', (WidgetTester tester) async {
      const childWidget = Text('Login');
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SigninButton(
              child: childWidget,
              onPressed: () {},
            ),
          ),
        ),
      );

      // Check if the button renders with the correct child
      expect(find.byType(SigninButton), findsOneWidget);
      expect(find.text('Login'), findsOneWidget);
    });

    testWidgets('SigningButton has correct width and height', (WidgetTester tester) async {
      const width = 200.0;
      const height = 50.0;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Center(
              child: SigninButton(
                width: width,
                height: height,
                onPressed: () {},
                child: const Text(AppStrings.login),
              ),
            ),
          ),
        ),
      );

      final button = tester.widget<Container>(find.byType(Container));

      // Verify the width and height of the button
      expect(button.constraints!.maxWidth, equals(width));
      expect(button.constraints!.maxHeight, equals(height));
    });

    testWidgets('Triggers onPressed callback when tapped', (WidgetTester tester) async {
      var wasPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SigninButton(
              child: const Text(AppStrings.login),
              onPressed: () {
                wasPressed = true;
              },
            ),
          ),
        ),
      );

      // Tap the button
      await tester.tap(find.byType(InkWell));
      await tester.pumpAndSettle();

      // Verify that the onPressed callback was triggered
      expect(wasPressed, isTrue);
    });

    testWidgets('SigningButton has correct gradient and border radius', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SigninButton(
              child: const Text(AppStrings.login),
              onPressed: () {},
            ),
          ),
        ),
      );

      final container = tester.widget<Container>(find.byType(Container));

      final boxDecoration = container.decoration as BoxDecoration;

      // Verify the gradient colors
      final gradient = boxDecoration.gradient as LinearGradient;
      expect(gradient.colors, equals([ColorManager.primary, ColorManager.primaryOpacity70]));

      // Verify the border radius
      expect(boxDecoration.borderRadius, BorderRadius.circular(25.0));
    });
  });
}
