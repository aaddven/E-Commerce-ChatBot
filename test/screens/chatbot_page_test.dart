import 'package:ecommerce_chatbot/widgets/chatbot_page/chat_input_field.dart';
import 'package:ecommerce_chatbot/widgets/chatbot_page/chatbot_reply.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce_chatbot/screens/chatbot_page.dart';
import 'package:ecommerce_chatbot/providers/login_page/auth_provider.dart';
import 'package:ecommerce_chatbot/providers/chatbot_page/clothing_provider.dart';
import 'package:ecommerce_chatbot/providers/chatbot_page/chatbot_provider.dart';
import 'package:ecommerce_chatbot/repository/clothing_repository.dart';
import 'package:ecommerce_chatbot/data/clothing_database.dart';

void main() {
  testWidgets('ChatBotPage UI elements test', (WidgetTester tester) async {

    final clothingDatabase = ClothingDatabase();
    final clothingRepository = ClothingRepository(clothingDatabase);
    final authProvider = AuthProvider();
    final clothingProvider = ClothingProvider();
    final chatbotProvider = ChatbotProvider(clothingRepository, clothingProvider);


    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<AuthProvider>.value(value: authProvider),
          ChangeNotifierProvider<ClothingProvider>.value(value: clothingProvider),
          ChangeNotifierProxyProvider<ClothingProvider, ChatbotProvider>(
            create: (_) => chatbotProvider,
            update: (_, clothingProvider, chatbotProvider) {
              if (chatbotProvider == null) {
                throw Exception('ChatbotProvider cannot be null');
              }
              chatbotProvider.clothingProvider = clothingProvider;
              return chatbotProvider;
            },
          ),

        ],
        child: MaterialApp(
          home: ChatBotPage(),
        ),
      ),
    );


    expect(find.text('E-Commerce ChatBot'), findsOneWidget);
    expect(find.byType(DropdownButton<String>), findsNWidgets(2));
    expect(find.byType(ChatInputField), findsOneWidget);


    clothingProvider.updateSelectedGender('Male');
    clothingProvider.updateSelectedStyle('Casual');
    await chatbotProvider.processUserMessage('T-shirt');


    await tester.pump();


    expect(find.byType(ChatBotReply), findsOneWidget);
  });
}
