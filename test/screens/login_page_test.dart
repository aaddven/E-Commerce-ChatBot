import 'package:ecommerce_chatbot/data/clothing_database.dart';
import 'package:ecommerce_chatbot/providers/chatbot_page/chatbot_provider.dart';
import 'package:ecommerce_chatbot/providers/chatbot_page/clothing_provider.dart';
import 'package:ecommerce_chatbot/repository/clothing_repository.dart';
import 'package:ecommerce_chatbot/screens/chatbot_page.dart';
import 'package:ecommerce_chatbot/widgets/login_page/custom_text_field.dart';
import 'package:ecommerce_chatbot/widgets/login_page/login_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ecommerce_chatbot/screens/login_page.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce_chatbot/providers/login_page/auth_provider.dart';

void main() {
  group('LoginPage Tests', () {

    testWidgets('LoginPage UI components test', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider(
            create: (_) => AuthProvider(),
            child: LoginPage(),
          ),
        ),
      );

      expect(find.text('Welcome to E-commerce Chatbot', findRichText: true) , findsOneWidget);
      expect(find.text('Please login to continue'), findsOneWidget);
      expect(find.byType(CustomTextField), findsNWidgets(2));
      expect(find.byType(LoginButton), findsOneWidget);
    });


    testWidgets('Login with valid credentials navigates to chatbot page', (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<AuthProvider>(
              create: (_) => AuthProvider(),
            ),
            ChangeNotifierProvider<ClothingProvider>(
              create: (_) => ClothingProvider(),
            ),
            ChangeNotifierProxyProvider<ClothingProvider, ChatbotProvider>(
              create: (_) => ChatbotProvider(
                ClothingRepository(ClothingDatabase()),
                ClothingProvider(),
              ),
              update: (_, clothingProvider, chatbotProvider) {
                chatbotProvider?.clothingProvider = clothingProvider;
                return chatbotProvider ?? ChatbotProvider(ClothingRepository(ClothingDatabase()), ClothingProvider());
              },
            ),
          ],
          child: MaterialApp(
            initialRoute: '/login',
            routes: {
              '/login': (context) => LoginPage(),
              '/chatbot': (context) => ChatBotPage(),
            },
          ),
        ),
      );


      final usernameFieldFinder = find.byType(CustomTextField).first;
      final passwordFieldFinder = find.byType(CustomTextField).last;


      await tester.enterText(usernameFieldFinder, 'blitz_demo');
      await tester.enterText(passwordFieldFinder, 'Blitz@1234');
      await tester.tap(find.text('LOGIN'));
      await tester.pumpAndSettle();


      expect(find.byType(ChatBotPage), findsOneWidget);
    });


    testWidgets('Login with invalid credentials displays error dialog', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          initialRoute: '/',
          routes: {
            '/': (context) => ChangeNotifierProvider(
              create: (_) => AuthProvider(),
              child: LoginPage(),
            ),
          },
        ),
      );

      final usernameFieldFinder = find.byType(CustomTextField).first;
      final passwordFieldFinder = find.byType(CustomTextField).last;


      await tester.enterText(usernameFieldFinder, 'invalid_username');
      await tester.enterText(passwordFieldFinder, 'invalid_password');
      await tester.tap(find.text('LOGIN'));
      await tester.pumpAndSettle();


      expect(find.text('Invalid username or password.'), findsOneWidget);
      expect(find.text('OK'), findsOneWidget);


      await tester.tap(find.text('OK'));
      await tester.pumpAndSettle();

     
      expect(find.text('Invalid username or password.'), findsNothing);
    });
  });
}









// void main() {
//
//   group('LoginPage Widget Tests', () {
//     testWidgets('LoginPage UI renders correctly', (WidgetTester tester) async {
//       await tester.pumpWidget(
//         MultiProvider(
//           providers: [
//             ChangeNotifierProvider(create: (_) => AuthProvider()),
//           ],
//           child: MaterialApp(
//             home: LoginPage(),
//           ),
//         ),
//       );
//
//
//       // Verify the presence of Welcome RichText
//       expect(find.text('Welcome to E-commerce Chatbot', findRichText: true) , findsOneWidget);
//
//       // Verify the presence of login fields and button
//       expect(find.byType(TextField), findsNWidgets(2));
//       expect(find.text('LOGIN'), findsOneWidget);
//     });
//
//
//     // Verify that error dialog is shown in case of invalid user
//     testWidgets('Invalid login shows error dialog', (WidgetTester tester) async {
//       await tester.pumpWidget(
//         MultiProvider(
//           providers: [
//             ChangeNotifierProvider(create: (_) => AuthProvider()),
//           ],
//           child: MaterialApp(
//             home: LoginPage(),
//           ),
//         ),
//       );
//
//       await tester.pump();
//
//       // Attempt to login with invalid credentials
//       await tester.enterText(find.byType(TextField).first, 'invalid_user');
//       await tester.enterText(find.byType(TextField).last, 'invalid_pass');
//       await tester.tap(find.text('LOGIN'));
//       await tester.pump();
//
//
//       expect(find.text('Invalid Credentials'), findsOneWidget);
//       expect(find.text('Please check your username and password.'), findsOneWidget);
//     });
//   });
// }
