import 'package:flutter_test/flutter_test.dart';
import 'package:meallog/features/meal_log/data/models/food_search_item_model.dart';

void main() {
  test('parses open food facts search item', () {
    final json = {
      'product_name': 'Domates',
      'brands': 'Pazar',
      'code': '123',
      'nutriments': {
        'energy-kcal_100g': 18,
        'proteins_100g': 0.9,
        'carbohydrates_100g': 3.9,
        'fat_100g': 0.2,
      },
      'data_quality_tags': ['en:verified'],
    };

    final item = FoodSearchItemModel.fromOpenFoodFacts(json);

    expect(item.id, '123');
    expect(item.name, 'Domates');
    expect(item.brand, 'Pazar');
    expect(item.per100gKcal, 18);
    expect(item.per100gProtein, 0.9);
    expect(item.per100gCarbs, 3.9);
    expect(item.per100gFat, 0.2);
    expect(item.isVerified, true);
  });
}
