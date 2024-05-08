import 'package:ecommerce_chatbot/data/clothing_database.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ecommerce_chatbot/repository/clothing_repository.dart';

void main() {
  group('ClothingRepository', () {
    test('getClothingItems should return correct items for valid criteria', () {
      // Arrange
      final repository = ClothingRepository(MockClothingDatabase());
      final gender = 'Male';
      final style = 'Casual';
      final clothingType = 'T-Shirts';

      // Act
      final items = repository.getClothingItems(
        gender: gender,
        style: style,
        clothingType: clothingType,
      );

      // Assert
      expect(items.length, equals(3)); // Assuming we expect 3 items for this category
      // You can add more specific assertions based on the expected items
    });

    test('getClothingItems should return empty list for invalid criteria', () {
      // Arrange
      final repository = ClothingRepository(MockClothingDatabase());
      final gender = 'Male';
      final style = 'Casual';
      final clothingType = 'Jacket';

      // Act
      final items = repository.getClothingItems(
        gender: gender,
        style: style,
        clothingType: clothingType,
      );

      // Assert
      expect(items.isEmpty, true);
    });
  });
}

// Mock implementation of ClothingDatabase for testing purposes
class MockClothingDatabase extends ClothingDatabase {
  @override
  final Map<String, Map<String, Map<String, List<Map<String, String>>>>> clothingMap = {
    'Male': {
      'Casual': {
        'T-Shirts': [
          {'image': 'test_image_1.png', 'link': 'test_link_1'},
          {'image': 'test_image_2.png', 'link': 'test_link_2'},
          {'image': 'test_image_3.png', 'link': 'test_link_3'},
        ],
      },
    },
  };
}
