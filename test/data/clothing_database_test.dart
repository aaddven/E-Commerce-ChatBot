import 'package:ecommerce_chatbot/data/clothing_database.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  test('Test ClothingDatabase', () {

    ClothingDatabase database = ClothingDatabase();


    Map<String, Map<String, Map<String, List<Map<String, String>>>>> clothingMap = database.clothingMap;


    expect(clothingMap, isNotNull);


    expect(clothingMap.containsKey('Male'), true);
    expect(clothingMap['Male']?.containsKey('Casual'), true);


    expect(clothingMap['Male']?['Casual']?.containsKey('T-Shirts'), true);


  });
}
