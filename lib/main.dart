import 'package:ecommerce_chatbot/data/clothing_database.dart';
import 'package:ecommerce_chatbot/providers/chatbot_page/clothing_provider.dart';
import 'package:ecommerce_chatbot/providers/login_page/auth_provider.dart';
import 'package:ecommerce_chatbot/providers/chatbot_page/chatbot_provider.dart';
import 'package:ecommerce_chatbot/repository/clothing_repository.dart';
import 'package:ecommerce_chatbot/screens/chatbot_page.dart';
import 'package:ecommerce_chatbot/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ClothingProvider()),
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
        debugShowCheckedModeBanner: false,
        title: 'E-commerce Chatbot',
        theme: ThemeData(primarySwatch: Colors.blue),
        initialRoute: '/login',
        routes: {
          '/login': (context) => LoginPage(),
          '/chatbot': (context) => ChatBotPage(),
        },
      ),
    );
  }
}
