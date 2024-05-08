import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ecommerce_chatbot/widgets/login_page/custom_text_field.dart';

void main() {
  testWidgets('CustomTextField renders correctly', (WidgetTester tester) async {

    // Mock function for the onSubmitted callback
    String submittedValue = '';
    void handleSubmitted(String value) {
      submittedValue = value;
    }

    // Build the CustomTextField widget with the onSubmitted callback
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: CustomTextField(
          controller: TextEditingController(),
          hintText: 'Test',
          onSubmitted: handleSubmitted,
        ),
      ),
    ));

    // Verify the presence of the CustomTextField widget
    expect(find.byType(TextField), findsOneWidget);
    expect(find.text('Test'), findsOneWidget);

    // Simulate submission
    await tester.enterText(find.byType(TextField), 'Submitted Text');
    await tester.testTextInput.receiveAction(TextInputAction.done);

    // Verify that the submittedValue was updated
    expect(submittedValue, 'Submitted Text');
  });
}
