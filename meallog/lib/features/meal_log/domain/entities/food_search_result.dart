import 'package:meallog/features/meal_log/domain/entities/food_search_item.dart';

class FoodSearchResult {
  const FoodSearchResult({
    required this.items,
    this.fromCache = false,
    this.isStale = false,
    this.isFallback = false,
  });

  final List<FoodSearchItem> items;
  final bool fromCache;
  final bool isStale;
  final bool isFallback;
}
