import 'package:flutter_test/flutter_test.dart';
import 'package:meallog/core/utils/nutrition_calculator.dart';
import 'package:meallog/features/meal_log/domain/entities/food_entry.dart';
import 'package:meallog/features/meal_log/domain/entities/meal_type.dart';

void main() {
  test('daily totals sum correctly', () {
    final entries = [
      FoodEntry(
        id: '1',
        date: DateTime(2025, 1, 1),
        mealType: MealType.breakfast,
        name: 'Domates',
        grams: 100,
        kcal: 18,
        protein: 0.9,
        carbs: 3.9,
        fat: 0.2,
        createdAt: DateTime(2025, 1, 1),
      ),
      FoodEntry(
        id: '2',
        date: DateTime(2025, 1, 1),
        mealType: MealType.lunch,
        name: 'Yo�urt',
        grams: 200,
        kcal: 122,
        protein: 7.0,
        carbs: 9.4,
        fat: 6.6,
        createdAt: DateTime(2025, 1, 1),
      ),
    ];

    final total = sumEntries(entries);

    expect(total.kcal, 140);
    expect(total.protein, 7.9);
    expect(total.carbs, 13.3);
    expect(total.fat, 6.8);
  });
}
