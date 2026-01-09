import 'package:flutter_test/flutter_test.dart';

import 'package:weightvault/domain/services/adaptive_goal_service.dart';

void main() {
  test('calculates BMR with Mifflin-St Jeor', () {
    final service = AdaptiveGoalService();
    final bmr = service.calculateBmr(weightKg: 70, heightCm: 170, age: 30, gender: 'female');
    expect(bmr, closeTo(1451, 5));
  });

  test('adjusts calorie target within bounds', () {
    final service = AdaptiveGoalService();
    final adjusted = service.adjustCalorieTarget(
      currentTarget: 2000,
      trendKgPerWeek: -0.1,
      isGoalLoss: true,
    );
    expect(adjusted, lessThan(2000));
  });
}
