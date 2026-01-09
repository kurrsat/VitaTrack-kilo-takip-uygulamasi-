import 'dart:math';

import 'package:weightvault/core/constants/app_constants.dart';
import 'package:weightvault/core/services/preferences_service.dart';
import 'package:weightvault/data/local/seed_foods.dart';
import 'package:weightvault/domain/models/models.dart';
import 'package:weightvault/domain/repositories/repositories.dart';
class DemoSeedService {
  DemoSeedService({
    required this.prefs,
    required this.userProfiles,
    required this.weights,
    required this.measurements,
    required this.waters,
    required this.fastings,
    required this.customFoods,
  });

  final PreferencesService prefs;
  final UserProfileRepository userProfiles;
  final WeightRepository weights;
  final MeasurementRepository measurements;
  final WaterRepository waters;
  final FastingRepository fastings;
  final CustomFoodRepository customFoods;

  Future<void> seedIfNeeded() async {
    if (prefs.demoSeeded) {
      return;
    }
    await seed();
    await prefs.setDemoSeeded(value: true);
  }

  Future<void> reset() async {
    await weights.hardDeleteAll(AppConstants.demoUserId);
    await measurements.hardDeleteAll(AppConstants.demoUserId);
    await waters.hardDeleteAll(AppConstants.demoUserId);
    await fastings.hardDeleteAll(AppConstants.demoUserId);
    await customFoods.hardDeleteAll(AppConstants.demoUserId);
    await userProfiles.deleteAll(AppConstants.demoUserId);
    await seed();
  }

  Future<void> seed() async {
    final now = DateTime.now().toUtc();
    await userProfiles.upsert(
      UserProfile(
        uid: AppConstants.demoUserId,
        name: 'Demo User',
        heightCm: 172,
        birthYear: 1992,
        gender: 'female',
        units: UnitsSystem.metric,
        goalType: GoalType.lose,
        goalWeight: 68,
        goalDate: now.add(const Duration(days: 120)),
        tdeeTarget: 2100,
        adaptiveGoalsEnabled: true,
        lastUpdatedAt: now,
        createdAt: now,
      ),
      isDirty: false,
    );

    await _seedWeights(now);
    await _seedMeasurements(now);
    await _seedWater(now);
    await _seedFasting(now);
    await _seedCustomFoods(now);
  }

  Future<void> _seedWeights(DateTime now) async {
    final rand = Random(42);
    const base = 82;
    for (var i = 29; i >= 0; i--) {
      final date = now.subtract(Duration(days: i));
      final trend = base - (29 - i) * 0.08;
      final noise = rand.nextDouble() * 0.6 - 0.3;
      final weight = trend + noise;
      await weights.upsert(
        WeightEntry(
          id: 'demo_weight_$i',
          uid: AppConstants.demoUserId,
          dateTime: date,
          weightKg: double.parse(weight.toStringAsFixed(2)),
          note: i % 6 == 0 ? 'Sabah olcumu' : null,
          conditionTag: i % 3 == 0 ? ConditionTag.morningFasted : ConditionTag.morningFed,
          moodTag: i % 4 == 0 ? MoodTag.great : MoodTag.ok,
          lastUpdatedAt: now,
        ),
        isDirty: false,
      );
    }
  }

  Future<void> _seedMeasurements(DateTime now) async {
    for (var i = 0; i < 5; i++) {
      final date = now.subtract(Duration(days: i * 7));
      await measurements.upsert(
        MeasurementEntry(
          id: 'demo_measure_$i',
          uid: AppConstants.demoUserId,
          dateTime: date,
          waistCm: 78 - i * 0.5,
          hipCm: 98 - i * 0.4,
          chestCm: 92 - i * 0.3,
          neckCm: 33,
          armCm: 28 - i * 0.2,
          thighCm: 56 - i * 0.3,
          bodyFatPct: 30 - i * 0.3,
          musclePct: 28 + i * 0.2,
          waterPct: 52 + i * 0.1,
          lastUpdatedAt: now,
        ),
        isDirty: false,
      );
    }
  }

  Future<void> _seedWater(DateTime now) async {
    for (var i = 0; i < 7; i++) {
      final date = DateTime.utc(now.year, now.month, now.day).subtract(Duration(days: i));
      await waters.upsert(
        WaterEntry(
          id: 'demo_water_$i',
          uid: AppConstants.demoUserId,
          date: date,
          ml: AppConstants.defaultWaterGoalMl - i * 100,
          lastUpdatedAt: now,
        ),
        isDirty: false,
      );
    }
  }

  Future<void> _seedFasting(DateTime now) async {
    for (var i = 0; i < 3; i++) {
      final start = now.subtract(Duration(days: i * 4 + 1, hours: 20));
      final end = start.add(const Duration(hours: 16));
      await fastings.upsert(
        FastingSession(
          id: 'demo_fast_$i',
          uid: AppConstants.demoUserId,
          start: start,
          end: end,
          planType: FastingPlanType.sixteenEight,
          goalHours: 16,
          completed: true,
          lastUpdatedAt: now,
        ),
        isDirty: false,
      );
    }
  }

  Future<void> _seedCustomFoods(DateTime now) async {
    final seeds = buildSeedFoods();
    for (var i = 0; i < seeds.length; i++) {
      final food = seeds[i];
      await customFoods.upsert(
        CustomFood(
          id: 'seed_food_$i',
          uid: AppConstants.demoUserId,
          nameTr: food.nameTr,
          nameEn: food.nameEn,
          cal: food.cal,
          protein: food.protein,
          carb: food.carb,
          fat: food.fat,
          fiber: food.fiber,
          sodium: food.sodium,
          sugar: food.sugar,
          lastUpdatedAt: now,
        ),
        isDirty: false,
      );
    }

    for (var i = 0; i < 10; i++) {
      await customFoods.upsert(
        CustomFood(
          id: 'demo_custom_$i',
          uid: AppConstants.demoUserId,
          nameTr: 'Ozel Tarif $i',
          nameEn: 'Custom Recipe $i',
          cal: 320.0 + i * 10,
          protein: 18.0 + i,
          carb: 24.0 + i * 1.5,
          fat: 12.0 + i * 0.8,
          fiber: 4.0 + i * 0.2,
          sodium: 150.0 + i * 15,
          sugar: 3.0 + i * 0.3,
          lastUpdatedAt: now,
        ),
        isDirty: false,
      );
    }
  }
}
