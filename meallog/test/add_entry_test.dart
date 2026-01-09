import 'package:flutter_test/flutter_test.dart';
import 'package:meallog/core/errors/result.dart';
import 'package:meallog/features/meal_log/domain/entities/day_summary.dart';
import 'package:meallog/features/meal_log/domain/entities/food_entry.dart';
import 'package:meallog/features/meal_log/domain/entities/food_search_item.dart';
import 'package:meallog/features/meal_log/domain/entities/food_search_result.dart';
import 'package:meallog/features/meal_log/domain/entities/meal_type.dart';
import 'package:meallog/features/meal_log/domain/repositories/food_repository.dart';
import 'package:meallog/features/meal_log/domain/usecases/add_food_entry.dart';

class _FakeFoodRepository implements FoodRepository {
  final List<FoodEntry> entries = [];

  @override
  Future<Result<void>> addEntry(FoodEntry entry) async {
    entries.add(entry);
    return const Success(null);
  }

  @override
  Future<Result<void>> deleteEntry(String id) async => const Success(null);

  @override
  Future<Result<DayLog>> getDayLog(DateTime date) async {
    return Success(DayLog(date: date, entries: entries, summary: DaySummary.empty()));
  }

  @override
  Future<Result<List<FoodSearchItem>>> getFavorites() async => const Success([]);

  @override
  Future<Result<List<FoodSearchItem>>> getRecentItems() async => const Success([]);

  @override
  Future<Result<FoodSearchResult>> searchFoods(String query) async {
    return const Success(FoodSearchResult(items: []));
  }

  @override
  Future<Result<void>> updateEntry(FoodEntry entry) async => const Success(null);

  @override
  Future<Result<bool>> toggleFavorite(FoodSearchItem item) async => const Success(false);

  @override
  Future<Result<void>> saveRecent(FoodSearchItem item) async => const Success(null);
}

void main() {
  test('add entry use case adds entry to repository', () async {
    final repo = _FakeFoodRepository();
    final useCase = AddFoodEntryUseCase(repo);

    final entry = FoodEntry(
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
    );

    await useCase.call(entry);

    expect(repo.entries.length, 1);
    expect(repo.entries.first.name, 'Domates');
  });
}
