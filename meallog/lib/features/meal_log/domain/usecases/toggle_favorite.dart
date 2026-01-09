import 'package:meallog/core/errors/result.dart';
import 'package:meallog/features/meal_log/domain/entities/food_search_item.dart';
import 'package:meallog/features/meal_log/domain/repositories/food_repository.dart';

class ToggleFavoriteUseCase {
  ToggleFavoriteUseCase(this._repository);

  final FoodRepository _repository;

  Future<Result<bool>> call(FoodSearchItem item) {
    return _repository.toggleFavorite(item);
  }
}
