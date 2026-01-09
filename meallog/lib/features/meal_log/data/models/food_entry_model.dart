import 'package:meallog/core/utils/date_utils.dart';
import 'package:meallog/features/meal_log/domain/entities/food_entry.dart';
import 'package:meallog/features/meal_log/domain/entities/meal_type.dart';

class FoodEntryModel extends FoodEntry {
  const FoodEntryModel({
    required super.id,
    required super.date,
    required super.mealType,
    required super.name,
    super.brand,
    required super.grams,
    required super.kcal,
    required super.protein,
    required super.carbs,
    required super.fat,
    required super.createdAt,
  });

  factory FoodEntryModel.fromJson(Map<String, dynamic> json) {
    return FoodEntryModel(
      id: json['id'] as String,
      date: DateTime.parse(json['date'] as String),
      mealType: MealType.values.firstWhere(
        (type) => type.name == json['mealType'],
        orElse: () => MealType.breakfast,
      ),
      name: json['name'] as String,
      brand: json['brand'] as String?,
      grams: (json['grams'] as num).toDouble(),
      kcal: (json['kcal'] as num).toDouble(),
      protein: (json['protein'] as num).toDouble(),
      carbs: (json['carbs'] as num).toDouble(),
      fat: (json['fat'] as num).toDouble(),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'dateKey': dayKey(date),
      'mealType': mealType.name,
      'name': name,
      'brand': brand,
      'grams': grams,
      'kcal': kcal,
      'protein': protein,
      'carbs': carbs,
      'fat': fat,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
