import 'package:meallog/core/errors/result.dart';
import 'package:meallog/features/meal_log/domain/entities/food_entry.dart';
import 'package:meallog/features/meal_log/domain/repositories/food_repository.dart';

class UpdateFoodEntryUseCase {
  UpdateFoodEntryUseCase(this._repository);

  final FoodRepository _repository;

  Future<Result<void>> call(FoodEntry entry) {
    return _repository.updateEntry(entry);
  }
}
