import 'package:freezed_annotation/freezed_annotation.dart';

part 'models.freezed.dart';
part 'models.g.dart';

class DateTimeMillisConverter implements JsonConverter<DateTime, int> {
  const DateTimeMillisConverter();

  @override
  DateTime fromJson(int json) => DateTime.fromMillisecondsSinceEpoch(json, isUtc: true);

  @override
  int toJson(DateTime object) => object.toUtc().millisecondsSinceEpoch;
}

enum UnitsSystem { metric, imperial }

enum GoalType { lose, gain, maintain }

enum TrendMethod { movingAverage, exponential, doubleExponential, custom }

enum ConditionTag { morningFasted, morningFed, eveningFasted, eveningFed }

enum MoodTag { great, ok, low, stressed }

enum MealType { breakfast, lunch, dinner, snack }

enum FastingPlanType { sixteenEight, eighteenSix, twentyFour, omad, custom }

enum ActivitySource { manual, health }

enum PhotoType { front, side, back }

@freezed
class UserProfile with _$UserProfile {
  const factory UserProfile({
    required String uid,
    required String name,
    required double heightCm,
    required UnitsSystem units,
    required GoalType goalType,
    required double goalWeight,
    @DateTimeMillisConverter() required DateTime goalDate,
    required bool adaptiveGoalsEnabled,
    @DateTimeMillisConverter() required DateTime lastUpdatedAt,
    @DateTimeMillisConverter() required DateTime createdAt,
    int? birthYear,
    String? gender,
    double? tdeeTarget,
  }) = _UserProfile;

  factory UserProfile.fromJson(Map<String, dynamic> json) => _$UserProfileFromJson(json);
}

@freezed
class WeightEntry with _$WeightEntry {
  const factory WeightEntry({
    required String id,
    required String uid,
    @DateTimeMillisConverter() required DateTime dateTime,
    required double weightKg,
    @DateTimeMillisConverter() required DateTime lastUpdatedAt,
    String? note,
    ConditionTag? conditionTag,
    MoodTag? moodTag,
    @Default(false) bool isDeleted,
  }) = _WeightEntry;

  factory WeightEntry.fromJson(Map<String, dynamic> json) => _$WeightEntryFromJson(json);
}

@freezed
class MeasurementEntry with _$MeasurementEntry {
  const factory MeasurementEntry({
    required String id,
    required String uid,
    @DateTimeMillisConverter() required DateTime dateTime,
    required double waistCm,
    required double hipCm,
    required double chestCm,
    required double neckCm,
    required double armCm,
    required double thighCm,
    @DateTimeMillisConverter() required DateTime lastUpdatedAt,
    double? bodyFatPct,
    double? musclePct,
    double? waterPct,
    @Default(false) bool isDeleted,
  }) = _MeasurementEntry;

  factory MeasurementEntry.fromJson(Map<String, dynamic> json) =>
      _$MeasurementEntryFromJson(json);
}

@freezed
class WaterEntry with _$WaterEntry {
  const factory WaterEntry({
    required String id,
    required String uid,
    @DateTimeMillisConverter() required DateTime date,
    required int ml,
    @DateTimeMillisConverter() required DateTime lastUpdatedAt,
    @Default(false) bool isDeleted,
  }) = _WaterEntry;

  factory WaterEntry.fromJson(Map<String, dynamic> json) => _$WaterEntryFromJson(json);
}

@freezed
class FoodTotals with _$FoodTotals {
  const factory FoodTotals({
    required double cal,
    required double protein,
    required double carb,
    required double fat,
    double? fiber,
    double? sodium,
    double? sugar,
  }) = _FoodTotals;

  factory FoodTotals.fromJson(Map<String, dynamic> json) => _$FoodTotalsFromJson(json);
}

@freezed
class FoodItem with _$FoodItem {
  const factory FoodItem({
    required String name,
    required double grams,
    required double cal,
    required double protein,
    required double carb,
    required double fat,
    String? customFoodId,
    double? fiber,
    double? sodium,
    double? sugar,
  }) = _FoodItem;

  factory FoodItem.fromJson(Map<String, dynamic> json) => _$FoodItemFromJson(json);
}

@freezed
class FoodEntry with _$FoodEntry {
  const factory FoodEntry({
    required String id,
    required String uid,
    @DateTimeMillisConverter() required DateTime dateTime,
    required MealType mealType,
    required FoodTotals totals,
    @DateTimeMillisConverter() required DateTime lastUpdatedAt,
    @Default(<FoodItem>[]) List<FoodItem> items,
    @Default(false) bool isDeleted,
  }) = _FoodEntry;

  factory FoodEntry.fromJson(Map<String, dynamic> json) => _$FoodEntryFromJson(json);
}

@freezed
class CustomFood with _$CustomFood {
  const factory CustomFood({
    required String id,
    required String uid,
    required String nameTr,
    required String nameEn,
    required double cal,
    required double protein,
    required double carb,
    required double fat,
    @DateTimeMillisConverter() required DateTime lastUpdatedAt,
    String? barcode,
    double? fiber,
    double? sodium,
    double? sugar,
    @Default(false) bool isDeleted,
  }) = _CustomFood;

  factory CustomFood.fromJson(Map<String, dynamic> json) => _$CustomFoodFromJson(json);
}

@freezed
class FastingSession with _$FastingSession {
  const factory FastingSession({
    required String id,
    required String uid,
    @DateTimeMillisConverter() required DateTime start,
    required FastingPlanType planType,
    required int goalHours,
    required bool completed,
    @DateTimeMillisConverter() required DateTime lastUpdatedAt,
    @DateTimeMillisConverter() DateTime? end,
    @Default(false) bool isDeleted,
  }) = _FastingSession;

  factory FastingSession.fromJson(Map<String, dynamic> json) => _$FastingSessionFromJson(json);
}

@freezed
class ActivityEntry with _$ActivityEntry {
  const factory ActivityEntry({
    required String id,
    required String uid,
    @DateTimeMillisConverter() required DateTime dateTime,
    required String type,
    required int durationMin,
    required double calories,
    required ActivitySource source,
    @DateTimeMillisConverter() required DateTime lastUpdatedAt,
    int? steps,
    @Default(false) bool isDeleted,
  }) = _ActivityEntry;

  factory ActivityEntry.fromJson(Map<String, dynamic> json) => _$ActivityEntryFromJson(json);
}

@freezed
class PhotoEntry with _$PhotoEntry {
  const factory PhotoEntry({
    required String id,
    required String uid,
    @DateTimeMillisConverter() required DateTime date,
    required PhotoType type,
    @DateTimeMillisConverter() required DateTime lastUpdatedAt,
    String? storageUrl,
    String? localPath,
    String? notes,
    @Default(false) bool isDeleted,
  }) = _PhotoEntry;

  factory PhotoEntry.fromJson(Map<String, dynamic> json) => _$PhotoEntryFromJson(json);
}

@freezed
class SyncLog with _$SyncLog {
  const factory SyncLog({
    required String id,
    required String uid,
    required String entityType,
    required String entityId,
    @DateTimeMillisConverter() required DateTime createdAt,
    String? conflictInfo,
  }) = _SyncLog;

  factory SyncLog.fromJson(Map<String, dynamic> json) => _$SyncLogFromJson(json);
}
