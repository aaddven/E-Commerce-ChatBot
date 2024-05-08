import 'package:ecommerce_chatbot/providers/chatbot_page/clothing_provider.dart';
import 'package:flutter/material.dart';
import '../../model/clothing_item.dart';
import '../../repository/clothing_repository.dart';

// Provider for ChatBot state management

class ChatbotProvider extends ChangeNotifier {

  final ClothingRepository _clothingRepository;
  ClothingProvider _clothingProvider;

  List<List<ClothingItem>> _allChatbotReplies = [];
  List<List<ClothingItem>> get allChatbotReplies => _allChatbotReplies;

  ChatbotProvider(this._clothingRepository, this._clothingProvider);

  set clothingProvider(ClothingProvider provider) {
    _clothingProvider = provider;
  }

  // Function to fetch Clothing items using Clothing Repository
  Future<void> processUserMessage(String message) async {
    final selectedGender = _clothingProvider.selectedGender;
    final selectedStyle = _clothingProvider.selectedStyle;


    try {
      final clothingItems = _clothingRepository.getClothingItems(
        gender: selectedGender,
        style: selectedStyle,
        clothingType: message,
      );


      _allChatbotReplies.add(clothingItems);

      notifyListeners();

    } catch (e) {
      print('Error processing user message: $e');
    }
  }


}
