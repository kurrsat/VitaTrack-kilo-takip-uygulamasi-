import 'package:dio/dio.dart';
import 'package:meallog/core/errors/app_exception.dart';
import 'package:meallog/core/errors/result.dart';
import 'package:meallog/core/utils/nutrition_calculator.dart';
import 'package:meallog/features/meal_log/data/datasources/food_local_data_source.dart';
import 'package:meallog/features/meal_log/data/datasources/food_remote_data_source.dart';
import 'package:meallog/features/meal_log/data/datasources/mock_food_data.dart';
import 'package:meallog/features/meal_log/data/models/food_entry_model.dart';
import 'package:meallog/features/meal_log/data/models/food_search_item_model.dart';
import 'package:meallog/features/meal_log/domain/entities/day_summary.dart';
import 'package:meallog/features/meal_log/domain/entities/food_entry.dart';
import 'package:meallog/features/meal_log/domain/entities/food_search_item.dart';
import 'package:meallog/features/meal_log/domain/entities/food_search_result.dart';
import 'package:meallog/features/meal_log/domain/entities/meal_type.dart';
import 'package:meallog/features/meal_log/domain/repositories/food_repository.dart';

class FoodRepositoryImpl implements FoodRepository {
  FoodRepositoryImpl({
    required FoodRemoteDataSource remoteDataSource,
    required FoodLocalDataSource localDataSource,
    Duration cacheTtl = const Duration(hours: 24),
  })  : _remote = remoteDataSource,
        _local = localDataSource,
        _cacheTtl = cacheTtl;

  final FoodRemoteDataSource _remote;
  final FoodLocalDataSource _local;
  final Duration _cacheTtl;

  @override
  Future<Result<FoodSearchResult>> searchFoods(String query) async {
    final trimmed = query.trim();
    if (trimmed.isEmpty) {
      return const Success(FoodSearchResult(items: []));
    }
    try {
      final items = await _remote.searchFoods(trimmed);
      if (items.isNotEmpty) {
        await _local.cacheSearch(trimmed, items);
      }
      return Success(FoodSearchResult(items: items));
    } on DioException {
      final cached = _local.getCachedSearch(trimmed);
      if (cached != null) {
        final isStale = DateTime.now().difference(cached.cachedAt) > _cacheTtl;
        return Success(
          FoodSearchResult(
            items: cached.items,
            fromCache: true,
            isStale: isStale,
          ),
        );
      }
      return Success(FoodSearchResult(items: mockFoodSearchItems, isFallback: true));
    } catch (error) {
      return Failure(AppException('Search failed', cause: error));
    }
  }

  @override
  Future<Result<void>> addEntry(FoodEntry entry) async {
    try {
      await _local.saveEntry(_toModel(entry));
      return const Success(null);
    } catch (error) {
      return Failure(AppException('Add entry failed', cause: error));
    }
  }

  @override
  Future<Result<void>> updateEntry(FoodEntry entry) async {
    try {
      await _local.updateEntry(_toModel(entry));
      return const Success(null);
    } catch (error) {
      return Failure(AppException('Update entry failed', cause: error));
    }
  }

  @override
  Future<Result<void>> deleteEntry(String id) async {
    try {
      await _local.deleteEntry(id);
      return const Success(null);
    } catch (error) {
      return Failure(AppException('Delete entry failed', cause: error));
    }
  }

  @override
  Future<Result<DayLog>> getDayLog(DateTime date) async {
    try {
      final entries = await _local.getEntriesForDate(date);
      final summary = _buildSummary(entries);
      return Success(DayLog(date: date, entries: entries, summary: summary));
    } catch (error) {
      return Failure(AppException('Load day log failed', cause: error));
    }
  }

  @override
  Future<Result<List<FoodSearchItem>>> getRecentItems() async {
    try {
      final items = await _local.getRecent();
      return Success(items);
    } catch (error) {
      return Failure(AppException('Load recents failed', cause: error));
    }
  }

  @override
  Future<Result<List<FoodSearchItem>>> getFavorites() async {
    try {
      final items = await _local.getFavorites();
      return Success(items);
    } catch (error) {
      return Failure(AppException('Load favorites failed', cause: error));
    }
  }

  @override
  Future<Result<bool>> toggleFavorite(FoodSearchItem item) async {
    try {
      final model = _toSearchModel(item);
      final enabled = await _local.toggleFavorite(model);
      return Success(enabled);
    } catch (error) {
      return Failure(AppException('Toggle favorite failed', cause: error));
    }
  }

  @override
  Future<Result<void>> saveRecent(FoodSearchItem item) async {
    try {
      await _local.saveRecent(_toSearchModel(item));
      return const Success(null);
    } catch (error) {
      return Failure(AppException('Save recent failed', cause: error));
    }
  }

  FoodEntryModel _toModel(FoodEntry entry) {
    return FoodEntryModel(
      id: entry.id,
      date: entry.date,
      mealType: entry.mealType,
      name: entry.name,
      brand: entry.brand,
      grams: entry.grams,
      kcal: entry.kcal,
      protein: entry.protein,
      carbs: entry.carbs,
      fat: entry.fat,
      createdAt: entry.createdAt,
    );
  }

  FoodSearchItemModel _toSearchModel(FoodSearchItem item) {
    return FoodSearchItemModel(
      id: item.id,
      name: item.name,
      brand: item.brand,
      per100gKcal: item.per100gKcal,
      per100gProtein: item.per100gProtein,
      per100gCarbs: item.per100gCarbs,
      per100gFat: item.per100gFat,
      source: item.source,
      isVerified: item.isVerified,
    );
  }

  DaySummary _buildSummary(List<FoodEntry> entries) {
    final totalsByMeal = {
      MealType.breakfast: NutritionTotals.empty,
      MealType.lunch: NutritionTotals.empty,
      MealType.dinner: NutritionTotals.empty,
      MealType.snack: NutritionTotals.empty,
    };
    for (final entry in entries) {
      final mealTotal = totalsByMeal[entry.mealType] ?? NutritionTotals.empty;
      totalsByMeal[entry.mealType] = mealTotal.add(
        NutritionTotals(
          kcal: entry.kcal,
          protein: entry.protein,
          carbs: entry.carbs,
          fat: entry.fat,
        ),
      );
    }
    final total = sumEntries(entries);
    return DaySummary(total: total, perMeal: totalsByMeal);
  }
}
