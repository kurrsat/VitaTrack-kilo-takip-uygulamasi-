class FoodSearchItem {
  const FoodSearchItem({
    required this.id,
    required this.name,
    this.brand,
    this.per100gKcal,
    this.per100gProtein,
    this.per100gCarbs,
    this.per100gFat,
    required this.source,
    required this.isVerified,
  });

  final String id;
  final String name;
  final String? brand;
  final double? per100gKcal;
  final double? per100gProtein;
  final double? per100gCarbs;
  final double? per100gFat;
  final String source;
  final bool isVerified;
}
