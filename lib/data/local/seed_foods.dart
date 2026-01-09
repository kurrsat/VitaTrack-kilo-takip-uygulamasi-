class SeedFood {
  SeedFood({
    required this.nameTr,
    required this.nameEn,
    required this.cal,
    required this.protein,
    required this.carb,
    required this.fat,
    this.fiber,
    this.sodium,
    this.sugar,
  });

  final String nameTr;
  final String nameEn;
  final double cal;
  final double protein;
  final double carb;
  final double fat;
  final double? fiber;
  final double? sodium;
  final double? sugar;
}

List<SeedFood> buildSeedFoods() {
  const descriptorsTr = [
    'taze',
    'firin',
    'izgara',
    'ev yapimi',
    'az yagli',
    'tuzsuz',
    'sekersiz',
    'organik',
    'tam tahilli',
    'baharatli',
  ];
  const descriptorsEn = [
    'fresh',
    'baked',
    'grilled',
    'homemade',
    'low fat',
    'unsalted',
    'no sugar',
    'organic',
    'whole grain',
    'spiced',
  ];
  const baseTr = [
    'elma',
    'muz',
    'yogurt',
    'tavuk',
    'somon',
    'pirinc',
    'makarna',
    'yulaf',
    'badem',
    'cilek',
    'salatalik',
    'domates',
    'mercimek',
    'nohut',
    'peynir',
    'ekmek',
    'yumurta',
    'zeytinyagi',
    'avokado',
    'brokoli',
  ];
  const baseEn = [
    'apple',
    'banana',
    'yogurt',
    'chicken',
    'salmon',
    'rice',
    'pasta',
    'oats',
    'almond',
    'strawberry',
    'cucumber',
    'tomato',
    'lentil',
    'chickpea',
    'cheese',
    'bread',
    'egg',
    'olive oil',
    'avocado',
    'broccoli',
  ];

  final foods = <SeedFood>[];
  var index = 0;
  for (var i = 0; i < baseTr.length; i++) {
    for (var j = 0; j < descriptorsTr.length; j++) {
      final cal = 40.0 + (index % 25) * 6.0;
      final protein = 2.0 + (index % 8) * 1.2;
      final carb = 4.0 + (index % 10) * 2.0;
      final fat = 1.0 + (index % 6) * 0.8;
      foods.add(
        SeedFood(
          nameTr: '${descriptorsTr[j]} ${baseTr[i]}',
          nameEn: '${descriptorsEn[j]} ${baseEn[i]}',
          cal: cal,
          protein: protein,
          carb: carb,
          fat: fat,
          fiber: 1 + (index % 5) * 0.7,
          sodium: 20 + (index % 10) * 12,
          sugar: 1 + (index % 4) * 1.5,
        ),
      );
      index++;
      if (foods.length >= 200) {
        return foods;
      }
    }
  }
  return foods;
}
