import 'package:meallog/features/meal_log/domain/entities/food_search_item.dart';

class FoodSearchItemModel extends FoodSearchItem {
  const FoodSearchItemModel({
    required super.id,
    required super.name,
    super.brand,
    super.per100gKcal,
    super.per100gProtein,
    super.per100gCarbs,
    super.per100gFat,
    required super.source,
    required super.isVerified,
  });

  factory FoodSearchItemModel.fromJson(Map<String, dynamic> json) {
    return FoodSearchItemModel(
      id: json['id'] as String,
      name: json['name'] as String,
      brand: json['brand'] as String?,
      per100gKcal: (json['per100gKcal'] as num?)?.toDouble(),
      per100gProtein: (json['per100gProtein'] as num?)?.toDouble(),
      per100gCarbs: (json['per100gCarbs'] as num?)?.toDouble(),
      per100gFat: (json['per100gFat'] as num?)?.toDouble(),
      source: json['source'] as String? ?? 'openfoodfacts',
      isVerified: json['isVerified'] as bool? ?? false,
    );
  }

  factory FoodSearchItemModel.fromOpenFoodFacts(Map<String, dynamic> json) {
    final nutriments = json['nutriments'] as Map<String, dynamic>? ?? {};
    final name = (json['product_name'] as String?)?.trim();
    final fallbackName = (json['generic_name'] as String?)?.trim();
    final trName = (json['product_name_tr'] as String?)?.trim();
    final brand = (json['brands'] as String?)?.split(',').first.trim();
    final code = (json['code'] as String?)?.trim();
    final kcal = _toDouble(nutriments['energy-kcal_100g']);
    final protein = _toDouble(nutriments['proteins_100g']);
    final carbs = _toDouble(nutriments['carbohydrates_100g']);
    final fat = _toDouble(nutriments['fat_100g']);
    final dataQuality = (json['data_quality_tags'] as List?)?.cast<String>() ?? const [];
    final verified = dataQuality.any((tag) => tag.contains('verified') || tag.contains('complete'));

    return FoodSearchItemModel(
      id: code ?? '${name ?? fallbackName ?? trName ?? 'item'}_${brand ?? ''}',
      name: name ?? trName ?? fallbackName ?? 'Unknown',
      brand: brand?.isEmpty == true ? null : brand,
      per100gKcal: kcal,
      per100gProtein: protein,
      per100gCarbs: carbs,
      per100gFat: fat,
      source: 'openfoodfacts',
      isVerified: verified && kcal != null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'brand': brand,
      'per100gKcal': per100gKcal,
      'per100gProtein': per100gProtein,
      'per100gCarbs': per100gCarbs,
      'per100gFat': per100gFat,
      'source': source,
      'isVerified': isVerified,
    };
  }

  static double? _toDouble(dynamic value) {
    if (value == null) return null;
    if (value is num) return value.toDouble();
    return double.tryParse(value.toString());
  }
}
