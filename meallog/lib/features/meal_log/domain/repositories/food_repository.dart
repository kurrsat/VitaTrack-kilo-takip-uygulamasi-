import 'package:meallog/core/errors/result.dart';
import 'package:meallog/features/meal_log/domain/entities/day_summary.dart';
import 'package:meallog/features/meal_log/domain/entities/food_entry.dart';
import 'package:meallog/features/meal_log/domain/entities/food_search_item.dart';
import 'package:meallog/features/meal_log/domain/entities/food_search_result.dart';

abstract class FoodRepository {
  Future<Result<FoodSearchResult>> searchFoods(String query);
  Future<Result<void>> addEntry(FoodEntry entry);
  Future<Result<void>> updateEntry(FoodEntry entry);
  Future<Result<void>> deleteEntry(String id);
  Future<Result<DayLog>> getDayLog(DateTime date);
  Future<Result<List<FoodSearchItem>>> getRecentItems();
  Future<Result<List<FoodSearchItem>>> getFavorites();
  Future<Result<bool>> toggleFavorite(FoodSearchItem item);
  Future<Result<void>> saveRecent(FoodSearchItem item);
}
