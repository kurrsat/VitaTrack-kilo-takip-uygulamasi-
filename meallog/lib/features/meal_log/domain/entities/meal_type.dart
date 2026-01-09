enum MealType {
  breakfast,
  lunch,
  dinner,
  snack,
}

extension MealTypeX on MealType {
  String get key => name;

  static MealType fromRoute(String? value) {
    return MealType.values.firstWhere(
      (type) => type.key == value,
      orElse: () => MealType.breakfast,
    );
  }
}
