import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:merokaam/layers/presentation/JobProfile/read_job_profile/widgets/utils.dart';
import 'package:merokaam/resources/colour_manager.dart';
import 'package:mockito/mockito.dart';

import 'package:another_flushbar/flushbar.dart';

class MockFlutterToast extends Mock implements Fluttertoast {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Utils Widget Tests', () {
    // Test for getErrorMessageWidget
    testWidgets('should display the correct error message in the widget', (WidgetTester tester) async {
      const testErrorMessage = 'This is an error message';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Utils.getErrorMessageWidget(testErrorMessage),
          ),
        ),
      );

      // Verify the text is displayed
      expect(find.text(testErrorMessage), findsOneWidget);

      // Verify the Text Widget has the correct style
      final textWidget = tester.widget<Text>(find.text(testErrorMessage));
      expect(textWidget.style!.fontSize, 19);
      expect(textWidget.style!.fontWeight, FontWeight.bold);
      expect(textWidget.style!.color, ColorManager.error);
    });

    // Test for flushBarErrorMessage
  });
}
