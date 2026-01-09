import 'package:meallog/features/meal_log/domain/entities/day_summary.dart';
import 'package:meallog/features/meal_log/domain/entities/food_entry.dart';

NutritionTotals calculateFromPer100g({
  required double grams,
  double? kcal,
  double? protein,
  double? carbs,
  double? fat,
}) {
  final factor = grams / 100;
  return NutritionTotals(
    kcal: (kcal ?? 0) * factor,
    protein: (protein ?? 0) * factor,
    carbs: (carbs ?? 0) * factor,
    fat: (fat ?? 0) * factor,
  );
}

NutritionTotals sumEntries(List<FoodEntry> entries) {
  var total = NutritionTotals.empty;
  for (final entry in entries) {
    total = total.add(
      NutritionTotals(
        kcal: entry.kcal,
        protein: entry.protein,
        carbs: entry.carbs,
        fat: entry.fat,
      ),
    );
  }
  return total;
}
