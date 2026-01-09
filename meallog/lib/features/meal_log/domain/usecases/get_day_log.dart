import 'package:meallog/core/errors/result.dart';
import 'package:meallog/features/meal_log/domain/entities/day_summary.dart';
import 'package:meallog/features/meal_log/domain/repositories/food_repository.dart';

class GetDayLogUseCase {
  GetDayLogUseCase(this._repository);

  final FoodRepository _repository;

  Future<Result<DayLog>> call(DateTime date) {
    return _repository.getDayLog(date);
  }
}
