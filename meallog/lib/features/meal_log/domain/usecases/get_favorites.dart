import 'package:meallog/core/errors/result.dart';
import 'package:meallog/features/meal_log/domain/entities/food_search_item.dart';
import 'package:meallog/features/meal_log/domain/repositories/food_repository.dart';

class GetFavoritesUseCase {
  GetFavoritesUseCase(this._repository);

  final FoodRepository _repository;

  Future<Result<List<FoodSearchItem>>> call() {
    return _repository.getFavorites();
  }
}
