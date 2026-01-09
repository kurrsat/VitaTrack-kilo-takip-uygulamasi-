import 'package:meallog/core/errors/result.dart';
import 'package:meallog/features/meal_log/domain/entities/food_search_result.dart';
import 'package:meallog/features/meal_log/domain/repositories/food_repository.dart';

class SearchFoodsUseCase {
  SearchFoodsUseCase(this._repository);

  final FoodRepository _repository;

  Future<Result<FoodSearchResult>> call(String query) {
    return _repository.searchFoods(query);
  }
}
