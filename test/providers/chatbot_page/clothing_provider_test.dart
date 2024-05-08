import 'package:flutter_test/flutter_test.dart';
import 'package:ecommerce_chatbot/providers/chatbot_page/clothing_provider.dart';

void main() {
  group('ClothingProvider Tests', () {
    test('Initial values of selectedGender and selectedStyle should be correct', () {
      final provider = ClothingProvider();

      expect(provider.selectedGender, 'Male');
      expect(provider.selectedStyle, 'Casual');
    });

    test('updateSelectedGender should update selectedGender correctly', () {
      final provider = ClothingProvider();

      provider.updateSelectedGender('Female');

      expect(provider.selectedGender, 'Female');
    });

    test('updateSelectedStyle should update selectedStyle correctly', () {
      final provider = ClothingProvider();

      provider.updateSelectedStyle('Formal');

      expect(provider.selectedStyle, 'Formal');
    });
  });
}
