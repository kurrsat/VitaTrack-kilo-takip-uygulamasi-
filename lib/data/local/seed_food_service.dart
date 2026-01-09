import 'package:weightvault/data/local/seed_foods.dart';
import 'package:weightvault/domain/models/models.dart';
import 'package:weightvault/domain/repositories/repositories.dart';
class SeedFoodService {
  SeedFoodService(this.customFoods);

  final CustomFoodRepository customFoods;

  Future<void> ensureSeedFoods(String uid) async {
    final existing = await customFoods.watchAll(uid).first;
    if (existing.length >= 200) {
      return;
    }
    final now = DateTime.now().toUtc();
    final seeds = buildSeedFoods();
    for (var i = 0; i < seeds.length; i++) {
      final food = seeds[i];
      await customFoods.upsert(
        CustomFood(
          id: 'seed_${uid}_$i',
          uid: uid,
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
  }
}
