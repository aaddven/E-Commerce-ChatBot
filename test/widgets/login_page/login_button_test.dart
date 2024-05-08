import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ecommerce_chatbot/widgets/login_page/login_button.dart';

void main() {
  testWidgets('LoginButton renders correctly', (WidgetTester tester) async {
    // Build the LoginButton widget
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: LoginButton(label: 'LOGIN', onPressed: () {}),
      ),
    ));

    // Verify the presence of the LoginButton widget
    expect(find.byType(ElevatedButton), findsOneWidget);
    expect(find.text('LOGIN'), findsOneWidget);
  });
}
