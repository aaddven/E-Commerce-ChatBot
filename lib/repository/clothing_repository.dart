import '../data/clothing_database.dart';
import '../model/clothing_item.dart';

// Repository to fetch Clothing items based on prompt

class ClothingRepository {
  final ClothingDatabase _database;

  ClothingRepository(this._database);

  List<ClothingItem> getClothingItems({
    required String gender,
    required String style,
    required String clothingType,
  }) {
    final clothingItems = <ClothingItem>[];

    try {
      if (_database.clothingMap.containsKey(gender) &&
          _database.clothingMap[gender]!.containsKey(style) &&
          _database.clothingMap[gender]![style]!.containsKey(clothingType)) {

        final items = _database.clothingMap[gender]![style]![clothingType]!;

        for (var item in items) {
          final image = item['image'];
          final link = item['link'];
          if (image != null && link != null) {
            clothingItems.add(ClothingItem(image: image, link: link));
          } else {
            print('Invalid data for clothing item: $item');
          }
        }
      } else {
        print('Requested category not found in the database for: $gender, $style, $clothingType');
      }
    } catch (e) {
      print('Error fetching clothing items: $e');
    }

    return clothingItems;
  }
}




