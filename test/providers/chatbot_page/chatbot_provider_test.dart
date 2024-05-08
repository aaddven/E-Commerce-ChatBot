import 'package:ecommerce_chatbot/model/clothing_item.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ecommerce_chatbot/providers/chatbot_page/chatbot_provider.dart';
import 'package:ecommerce_chatbot/providers/chatbot_page/clothing_provider.dart';
import 'package:ecommerce_chatbot/repository/clothing_repository.dart';
import 'package:mockito/mockito.dart';

// Mock ClothingProvider
class MockClothingProvider extends Mock implements ClothingProvider {
  @override
  String get selectedGender => 'Male'; // Mocked implementation for selectedGender

  @override
  String get selectedStyle => 'Casual'; // Mocked implementation for selectedStyle
}

// Mock ClothingRepository
class MockClothingRepository extends Mock implements ClothingRepository {
  @override
  List<ClothingItem> getClothingItems({
    required String gender,
    required String style,
    required String clothingType,
  }) {
    // Mocked implementation for getClothingItems method
    return [
      ClothingItem(image: 'mock_image_1', link: 'mock_link_1'),
      ClothingItem(image: 'mock_image_2', link: 'mock_link_2'),
      ClothingItem(image: 'mock_image_3', link: 'mock_link_3'),
    ];
  }
}

void main() {
  group('ChatbotProvider Tests', () {
    late ChatbotProvider chatbotProvider;
    late MockClothingProvider mockClothingProvider;
    late MockClothingRepository mockClothingRepository;

    setUp(() {
      mockClothingProvider = MockClothingProvider();
      mockClothingRepository = MockClothingRepository();
      chatbotProvider = ChatbotProvider(mockClothingRepository, mockClothingProvider);
    });

    test('processUserMessage adds clothingItems to allChatbotReplies', () async {
      // Arrange: Mock selected gender and style in clothing provider
      when(mockClothingProvider.selectedGender).thenReturn('Male');
      when(mockClothingProvider.selectedStyle).thenReturn('Casual');

      // Arrange: Mock getClothingItems response
      final mockClothingItems = [
        ClothingItem(image: 'mock_image', link: 'mock_link'),
      ];
      when(mockClothingRepository.getClothingItems(
        gender: 'Male',
        style: 'Casual',
        clothingType: 'T-Shirts',
      )).thenReturn(mockClothingItems);

      // Act: Call the method under test
      await chatbotProvider.processUserMessage('T-Shirts');

      // Assert: Verify that getClothingItems was called with the correct parameters
      verify(mockClothingRepository.getClothingItems(
        gender: 'Male',
        style: 'Casual',
        clothingType: 'T-Shirts',
      )).called(1);

      // Assert: Check if allChatbotReplies contains the expected clothing items
      expect(chatbotProvider.allChatbotReplies, [
        mockClothingItems,
      ]);
    });
  });
}
