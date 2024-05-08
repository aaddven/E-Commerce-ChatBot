import 'package:ecommerce_chatbot/widgets/chatbot_page/chat_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  group('ChatInputField Widget', () {
    testWidgets('Sends message when send button is pressed', (WidgetTester tester) async {
      bool messageSent = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ChatInputField(
              controller: TextEditingController(),
              onPressed: () {
                messageSent = true;
              },
            ),
          ),
        ),
      );

      // Verify initial state
      expect(find.byType(TextField), findsOneWidget);
      expect(find.byType(IconButton), findsOneWidget);

      // Enter text into the TextField
      await tester.enterText(find.byType(TextField), 'Hello');

      // Tap the send button (IconButton)
      await tester.tap(find.byType(IconButton));

      // Rebuild the widget after the button press
      await tester.pump();

      // Verify that onPressed callback was called and message was sent
      expect(messageSent, true);
    });
  });
}
