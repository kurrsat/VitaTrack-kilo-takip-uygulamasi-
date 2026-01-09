import 'dart:math';
class AdaptiveGoalService {
  double calculateBmr({
    required double weightKg,
    required double heightCm,
    required int age,
    required String gender,
  }) {
    final base = 10 * weightKg + 6.25 * heightCm - 5 * age;
    if (gender.toLowerCase().startsWith('m')) {
      return base + 5;
    }
    if (gender.toLowerCase().startsWith('f')) {
      return base - 161;
    }
    return base - 78;
  }

  double calculateTdee({
    required double bmr,
    double activityMultiplier = 1.4,
  }) {
    return bmr * activityMultiplier;
  }

  double adjustCalorieTarget({
    required double currentTarget,
    required double trendKgPerWeek,
    required bool isGoalLoss,
    double minCalories = 1200,
    double maxCalories = 3500,
  }) {
    final desiredChange = isGoalLoss ? -0.5 : 0.5;
    final delta = (trendKgPerWeek - desiredChange).clamp(-1.0, 1.0);
    final adjustment = delta * 250;
    final proposed = currentTarget - adjustment;
    return min(max(proposed, minCalories), maxCalories);
  }
}
