import 'package:weightvault/domain/models/models.dart';
import 'package:weightvault/domain/services/adaptive_goal_service.dart';

double goalOffset(GoalType goalType) {
  switch (goalType) {
    case GoalType.gain:
      return 1000;
    case GoalType.lose:
      return -1000;
    case GoalType.maintain:
      return 0;
  }
}

double calculateDailyCalorieGoal({
  required AdaptiveGoalService service,
  required double weightKg,
  required double heightCm,
  required int age,
  required String gender,
  required double activityCalories,
  required GoalType goalType,
}) {
  final bmr = service.calculateBmr(
    weightKg: weightKg,
    heightCm: heightCm,
    age: age,
    gender: gender,
  );
  final tdee = bmr + activityCalories;
  return tdee + goalOffset(goalType);
}
