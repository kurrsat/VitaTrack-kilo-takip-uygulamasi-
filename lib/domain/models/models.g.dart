// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserProfileImpl _$$UserProfileImplFromJson(Map<String, dynamic> json) =>
    _$UserProfileImpl(
      uid: json['uid'] as String,
      name: json['name'] as String,
      heightCm: (json['heightCm'] as num).toDouble(),
      birthYear: (json['birthYear'] as num?)?.toInt(),
      gender: json['gender'] as String?,
      units: $enumDecode(_$UnitsSystemEnumMap, json['units']),
      goalType: $enumDecode(_$GoalTypeEnumMap, json['goalType']),
      goalWeight: (json['goalWeight'] as num).toDouble(),
      goalDate: const DateTimeMillisConverter()
          .fromJson((json['goalDate'] as num).toInt()),
      tdeeTarget: (json['tdeeTarget'] as num?)?.toDouble(),
      adaptiveGoalsEnabled: json['adaptiveGoalsEnabled'] as bool,
      lastUpdatedAt: const DateTimeMillisConverter()
          .fromJson((json['lastUpdatedAt'] as num).toInt()),
      createdAt: const DateTimeMillisConverter()
          .fromJson((json['createdAt'] as num).toInt()),
    );

Map<String, dynamic> _$$UserProfileImplToJson(_$UserProfileImpl instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'name': instance.name,
      'heightCm': instance.heightCm,
      'birthYear': instance.birthYear,
      'gender': instance.gender,
      'units': _$UnitsSystemEnumMap[instance.units]!,
      'goalType': _$GoalTypeEnumMap[instance.goalType]!,
      'goalWeight': instance.goalWeight,
      'goalDate': const DateTimeMillisConverter().toJson(instance.goalDate),
      'tdeeTarget': instance.tdeeTarget,
      'adaptiveGoalsEnabled': instance.adaptiveGoalsEnabled,
      'lastUpdatedAt':
          const DateTimeMillisConverter().toJson(instance.lastUpdatedAt),
      'createdAt': const DateTimeMillisConverter().toJson(instance.createdAt),
    };

const _$UnitsSystemEnumMap = {
  UnitsSystem.metric: 'metric',
  UnitsSystem.imperial: 'imperial',
};

const _$GoalTypeEnumMap = {
  GoalType.lose: 'lose',
  GoalType.gain: 'gain',
  GoalType.maintain: 'maintain',
};

_$WeightEntryImpl _$$WeightEntryImplFromJson(Map<String, dynamic> json) =>
    _$WeightEntryImpl(
      id: json['id'] as String,
      uid: json['uid'] as String,
      dateTime: const DateTimeMillisConverter()
          .fromJson((json['dateTime'] as num).toInt()),
      weightKg: (json['weightKg'] as num).toDouble(),
      note: json['note'] as String?,
      conditionTag:
          $enumDecodeNullable(_$ConditionTagEnumMap, json['conditionTag']),
      moodTag: $enumDecodeNullable(_$MoodTagEnumMap, json['moodTag']),
      lastUpdatedAt: const DateTimeMillisConverter()
          .fromJson((json['lastUpdatedAt'] as num).toInt()),
      isDeleted: json['isDeleted'] as bool? ?? false,
    );

Map<String, dynamic> _$$WeightEntryImplToJson(_$WeightEntryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'dateTime': const DateTimeMillisConverter().toJson(instance.dateTime),
      'weightKg': instance.weightKg,
      'note': instance.note,
      'conditionTag': _$ConditionTagEnumMap[instance.conditionTag],
      'moodTag': _$MoodTagEnumMap[instance.moodTag],
      'lastUpdatedAt':
          const DateTimeMillisConverter().toJson(instance.lastUpdatedAt),
      'isDeleted': instance.isDeleted,
    };

const _$ConditionTagEnumMap = {
  ConditionTag.morningFasted: 'morningFasted',
  ConditionTag.morningFed: 'morningFed',
  ConditionTag.eveningFasted: 'eveningFasted',
  ConditionTag.eveningFed: 'eveningFed',
};

const _$MoodTagEnumMap = {
  MoodTag.great: 'great',
  MoodTag.ok: 'ok',
  MoodTag.low: 'low',
  MoodTag.stressed: 'stressed',
};

_$MeasurementEntryImpl _$$MeasurementEntryImplFromJson(
        Map<String, dynamic> json) =>
    _$MeasurementEntryImpl(
      id: json['id'] as String,
      uid: json['uid'] as String,
      dateTime: const DateTimeMillisConverter()
          .fromJson((json['dateTime'] as num).toInt()),
      waistCm: (json['waistCm'] as num).toDouble(),
      hipCm: (json['hipCm'] as num).toDouble(),
      chestCm: (json['chestCm'] as num).toDouble(),
      neckCm: (json['neckCm'] as num).toDouble(),
      armCm: (json['armCm'] as num).toDouble(),
      thighCm: (json['thighCm'] as num).toDouble(),
      bodyFatPct: (json['bodyFatPct'] as num?)?.toDouble(),
      musclePct: (json['musclePct'] as num?)?.toDouble(),
      waterPct: (json['waterPct'] as num?)?.toDouble(),
      lastUpdatedAt: const DateTimeMillisConverter()
          .fromJson((json['lastUpdatedAt'] as num).toInt()),
      isDeleted: json['isDeleted'] as bool? ?? false,
    );

Map<String, dynamic> _$$MeasurementEntryImplToJson(
        _$MeasurementEntryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'dateTime': const DateTimeMillisConverter().toJson(instance.dateTime),
      'waistCm': instance.waistCm,
      'hipCm': instance.hipCm,
      'chestCm': instance.chestCm,
      'neckCm': instance.neckCm,
      'armCm': instance.armCm,
      'thighCm': instance.thighCm,
      'bodyFatPct': instance.bodyFatPct,
      'musclePct': instance.musclePct,
      'waterPct': instance.waterPct,
      'lastUpdatedAt':
          const DateTimeMillisConverter().toJson(instance.lastUpdatedAt),
      'isDeleted': instance.isDeleted,
    };

_$WaterEntryImpl _$$WaterEntryImplFromJson(Map<String, dynamic> json) =>
    _$WaterEntryImpl(
      id: json['id'] as String,
      uid: json['uid'] as String,
      date: const DateTimeMillisConverter()
          .fromJson((json['date'] as num).toInt()),
      ml: (json['ml'] as num).toInt(),
      lastUpdatedAt: const DateTimeMillisConverter()
          .fromJson((json['lastUpdatedAt'] as num).toInt()),
      isDeleted: json['isDeleted'] as bool? ?? false,
    );

Map<String, dynamic> _$$WaterEntryImplToJson(_$WaterEntryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'date': const DateTimeMillisConverter().toJson(instance.date),
      'ml': instance.ml,
      'lastUpdatedAt':
          const DateTimeMillisConverter().toJson(instance.lastUpdatedAt),
      'isDeleted': instance.isDeleted,
    };

_$FoodTotalsImpl _$$FoodTotalsImplFromJson(Map<String, dynamic> json) =>
    _$FoodTotalsImpl(
      cal: (json['cal'] as num).toDouble(),
      protein: (json['protein'] as num).toDouble(),
      carb: (json['carb'] as num).toDouble(),
      fat: (json['fat'] as num).toDouble(),
      fiber: (json['fiber'] as num?)?.toDouble(),
      sodium: (json['sodium'] as num?)?.toDouble(),
      sugar: (json['sugar'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$FoodTotalsImplToJson(_$FoodTotalsImpl instance) =>
    <String, dynamic>{
      'cal': instance.cal,
      'protein': instance.protein,
      'carb': instance.carb,
      'fat': instance.fat,
      'fiber': instance.fiber,
      'sodium': instance.sodium,
      'sugar': instance.sugar,
    };

_$FoodItemImpl _$$FoodItemImplFromJson(Map<String, dynamic> json) =>
    _$FoodItemImpl(
      customFoodId: json['customFoodId'] as String?,
      name: json['name'] as String,
      grams: (json['grams'] as num).toDouble(),
      cal: (json['cal'] as num).toDouble(),
      protein: (json['protein'] as num).toDouble(),
      carb: (json['carb'] as num).toDouble(),
      fat: (json['fat'] as num).toDouble(),
      fiber: (json['fiber'] as num?)?.toDouble(),
      sodium: (json['sodium'] as num?)?.toDouble(),
      sugar: (json['sugar'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$FoodItemImplToJson(_$FoodItemImpl instance) =>
    <String, dynamic>{
      'customFoodId': instance.customFoodId,
      'name': instance.name,
      'grams': instance.grams,
      'cal': instance.cal,
      'protein': instance.protein,
      'carb': instance.carb,
      'fat': instance.fat,
      'fiber': instance.fiber,
      'sodium': instance.sodium,
      'sugar': instance.sugar,
    };

_$FoodEntryImpl _$$FoodEntryImplFromJson(Map<String, dynamic> json) =>
    _$FoodEntryImpl(
      id: json['id'] as String,
      uid: json['uid'] as String,
      dateTime: const DateTimeMillisConverter()
          .fromJson((json['dateTime'] as num).toInt()),
      mealType: $enumDecode(_$MealTypeEnumMap, json['mealType']),
      items: (json['items'] as List<dynamic>?)
              ?.map((e) => FoodItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <FoodItem>[],
      totals: FoodTotals.fromJson(json['totals'] as Map<String, dynamic>),
      lastUpdatedAt: const DateTimeMillisConverter()
          .fromJson((json['lastUpdatedAt'] as num).toInt()),
      isDeleted: json['isDeleted'] as bool? ?? false,
    );

Map<String, dynamic> _$$FoodEntryImplToJson(_$FoodEntryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'dateTime': const DateTimeMillisConverter().toJson(instance.dateTime),
      'mealType': _$MealTypeEnumMap[instance.mealType]!,
      'items': instance.items,
      'totals': instance.totals,
      'lastUpdatedAt':
          const DateTimeMillisConverter().toJson(instance.lastUpdatedAt),
      'isDeleted': instance.isDeleted,
    };

const _$MealTypeEnumMap = {
  MealType.breakfast: 'breakfast',
  MealType.lunch: 'lunch',
  MealType.dinner: 'dinner',
  MealType.snack: 'snack',
};

_$CustomFoodImpl _$$CustomFoodImplFromJson(Map<String, dynamic> json) =>
    _$CustomFoodImpl(
      id: json['id'] as String,
      uid: json['uid'] as String,
      nameTr: json['nameTr'] as String,
      nameEn: json['nameEn'] as String,
      barcode: json['barcode'] as String?,
      cal: (json['cal'] as num).toDouble(),
      protein: (json['protein'] as num).toDouble(),
      carb: (json['carb'] as num).toDouble(),
      fat: (json['fat'] as num).toDouble(),
      fiber: (json['fiber'] as num?)?.toDouble(),
      sodium: (json['sodium'] as num?)?.toDouble(),
      sugar: (json['sugar'] as num?)?.toDouble(),
      lastUpdatedAt: const DateTimeMillisConverter()
          .fromJson((json['lastUpdatedAt'] as num).toInt()),
      isDeleted: json['isDeleted'] as bool? ?? false,
    );

Map<String, dynamic> _$$CustomFoodImplToJson(_$CustomFoodImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'nameTr': instance.nameTr,
      'nameEn': instance.nameEn,
      'barcode': instance.barcode,
      'cal': instance.cal,
      'protein': instance.protein,
      'carb': instance.carb,
      'fat': instance.fat,
      'fiber': instance.fiber,
      'sodium': instance.sodium,
      'sugar': instance.sugar,
      'lastUpdatedAt':
          const DateTimeMillisConverter().toJson(instance.lastUpdatedAt),
      'isDeleted': instance.isDeleted,
    };

_$FastingSessionImpl _$$FastingSessionImplFromJson(Map<String, dynamic> json) =>
    _$FastingSessionImpl(
      id: json['id'] as String,
      uid: json['uid'] as String,
      start: const DateTimeMillisConverter()
          .fromJson((json['start'] as num).toInt()),
      end: _$JsonConverterFromJson<int, DateTime>(
          json['end'], const DateTimeMillisConverter().fromJson),
      planType: $enumDecode(_$FastingPlanTypeEnumMap, json['planType']),
      goalHours: (json['goalHours'] as num).toInt(),
      completed: json['completed'] as bool,
      lastUpdatedAt: const DateTimeMillisConverter()
          .fromJson((json['lastUpdatedAt'] as num).toInt()),
      isDeleted: json['isDeleted'] as bool? ?? false,
    );

Map<String, dynamic> _$$FastingSessionImplToJson(
        _$FastingSessionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'start': const DateTimeMillisConverter().toJson(instance.start),
      'end': _$JsonConverterToJson<int, DateTime>(
          instance.end, const DateTimeMillisConverter().toJson),
      'planType': _$FastingPlanTypeEnumMap[instance.planType]!,
      'goalHours': instance.goalHours,
      'completed': instance.completed,
      'lastUpdatedAt':
          const DateTimeMillisConverter().toJson(instance.lastUpdatedAt),
      'isDeleted': instance.isDeleted,
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

const _$FastingPlanTypeEnumMap = {
  FastingPlanType.sixteenEight: 'sixteenEight',
  FastingPlanType.eighteenSix: 'eighteenSix',
  FastingPlanType.twentyFour: 'twentyFour',
  FastingPlanType.omad: 'omad',
  FastingPlanType.custom: 'custom',
};

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);

_$ActivityEntryImpl _$$ActivityEntryImplFromJson(Map<String, dynamic> json) =>
    _$ActivityEntryImpl(
      id: json['id'] as String,
      uid: json['uid'] as String,
      dateTime: const DateTimeMillisConverter()
          .fromJson((json['dateTime'] as num).toInt()),
      type: json['type'] as String,
      durationMin: (json['durationMin'] as num).toInt(),
      calories: (json['calories'] as num).toDouble(),
      steps: (json['steps'] as num?)?.toInt(),
      source: $enumDecode(_$ActivitySourceEnumMap, json['source']),
      lastUpdatedAt: const DateTimeMillisConverter()
          .fromJson((json['lastUpdatedAt'] as num).toInt()),
      isDeleted: json['isDeleted'] as bool? ?? false,
    );

Map<String, dynamic> _$$ActivityEntryImplToJson(_$ActivityEntryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'dateTime': const DateTimeMillisConverter().toJson(instance.dateTime),
      'type': instance.type,
      'durationMin': instance.durationMin,
      'calories': instance.calories,
      'steps': instance.steps,
      'source': _$ActivitySourceEnumMap[instance.source]!,
      'lastUpdatedAt':
          const DateTimeMillisConverter().toJson(instance.lastUpdatedAt),
      'isDeleted': instance.isDeleted,
    };

const _$ActivitySourceEnumMap = {
  ActivitySource.manual: 'manual',
  ActivitySource.health: 'health',
};

_$PhotoEntryImpl _$$PhotoEntryImplFromJson(Map<String, dynamic> json) =>
    _$PhotoEntryImpl(
      id: json['id'] as String,
      uid: json['uid'] as String,
      date: const DateTimeMillisConverter()
          .fromJson((json['date'] as num).toInt()),
      type: $enumDecode(_$PhotoTypeEnumMap, json['type']),
      storageUrl: json['storageUrl'] as String?,
      localPath: json['localPath'] as String?,
      notes: json['notes'] as String?,
      lastUpdatedAt: const DateTimeMillisConverter()
          .fromJson((json['lastUpdatedAt'] as num).toInt()),
      isDeleted: json['isDeleted'] as bool? ?? false,
    );

Map<String, dynamic> _$$PhotoEntryImplToJson(_$PhotoEntryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'date': const DateTimeMillisConverter().toJson(instance.date),
      'type': _$PhotoTypeEnumMap[instance.type]!,
      'storageUrl': instance.storageUrl,
      'localPath': instance.localPath,
      'notes': instance.notes,
      'lastUpdatedAt':
          const DateTimeMillisConverter().toJson(instance.lastUpdatedAt),
      'isDeleted': instance.isDeleted,
    };

const _$PhotoTypeEnumMap = {
  PhotoType.front: 'front',
  PhotoType.side: 'side',
  PhotoType.back: 'back',
};

_$SyncLogImpl _$$SyncLogImplFromJson(Map<String, dynamic> json) =>
    _$SyncLogImpl(
      id: json['id'] as String,
      uid: json['uid'] as String,
      entityType: json['entityType'] as String,
      entityId: json['entityId'] as String,
      conflictInfo: json['conflictInfo'] as String?,
      createdAt: const DateTimeMillisConverter()
          .fromJson((json['createdAt'] as num).toInt()),
    );

Map<String, dynamic> _$$SyncLogImplToJson(_$SyncLogImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'entityType': instance.entityType,
      'entityId': instance.entityId,
      'conflictInfo': instance.conflictInfo,
      'createdAt': const DateTimeMillisConverter().toJson(instance.createdAt),
    };
