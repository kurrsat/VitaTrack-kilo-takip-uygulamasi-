import 'package:meallog/features/meal_log/domain/entities/meal_type.dart';

class FoodEntry {
  const FoodEntry({
    required this.id,
    required this.date,
    required this.mealType,
    required this.name,
    this.brand,
    required this.grams,
    required this.kcal,
    required this.protein,
    required this.carbs,
    required this.fat,
    required this.createdAt,
  });

  final String id;
  final DateTime date;
  final MealType mealType;
  final String name;
  final String? brand;
  final double grams;
  final double kcal;
  final double protein;
  final double carbs;
  final double fat;
  final DateTime createdAt;

  FoodEntry copyWith({
    double? grams,
    double? kcal,
    double? protein,
    double? carbs,
    double? fat,
  }) {
    return FoodEntry(
      id: id,
      date: date,
      mealType: mealType,
      name: name,
      brand: brand,
      grams: grams ?? this.grams,
      kcal: kcal ?? this.kcal,
      protein: protein ?? this.protein,
      carbs: carbs ?? this.carbs,
      fat: fat ?? this.fat,
      createdAt: createdAt,
    );
  }
}
