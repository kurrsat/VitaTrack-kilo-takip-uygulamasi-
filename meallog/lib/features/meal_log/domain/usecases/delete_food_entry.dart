import 'package:meallog/core/errors/result.dart';
import 'package:meallog/features/meal_log/domain/repositories/food_repository.dart';

class DeleteFoodEntryUseCase {
  DeleteFoodEntryUseCase(this._repository);

  final FoodRepository _repository;

  Future<Result<void>> call(String id) {
    return _repository.deleteEntry(id);
  }
}
