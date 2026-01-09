import 'package:meallog/features/meal_log/domain/entities/food_entry.dart';
import 'package:meallog/features/meal_log/domain/entities/meal_type.dart';

class NutritionTotals {
  const NutritionTotals({
    required this.kcal,
    required this.protein,
    required this.carbs,
    required this.fat,
  });

  final double kcal;
  final double protein;
  final double carbs;
  final double fat;

  static const empty = NutritionTotals(kcal: 0, protein: 0, carbs: 0, fat: 0);

  NutritionTotals add(NutritionTotals other) {
    return NutritionTotals(
      kcal: kcal + other.kcal,
      protein: protein + other.protein,
      carbs: carbs + other.carbs,
      fat: fat + other.fat,
    );
  }
}

class DaySummary {
  const DaySummary({
    required this.total,
    required this.perMeal,
  });

  final NutritionTotals total;
  final Map<MealType, NutritionTotals> perMeal;

  static DaySummary empty() {
    return DaySummary(
      total: NutritionTotals.empty,
      perMeal: {
        MealType.breakfast: NutritionTotals.empty,
        MealType.lunch: NutritionTotals.empty,
        MealType.dinner: NutritionTotals.empty,
        MealType.snack: NutritionTotals.empty,
      },
    );
  }
}

class DayLog {
  const DayLog({
    required this.date,
    required this.entries,
    required this.summary,
  });

  final DateTime date;
  final List<FoodEntry> entries;
  final DaySummary summary;
}
