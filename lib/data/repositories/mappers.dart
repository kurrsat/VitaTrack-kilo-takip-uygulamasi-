import 'package:drift/drift.dart';
import 'package:weightvault/data/db/app_database.dart';
import 'package:weightvault/domain/models/models.dart';

DateTime _fromMillis(int value) => DateTime.fromMillisecondsSinceEpoch(value, isUtc: true);
int _toMillis(DateTime value) => value.toUtc().millisecondsSinceEpoch;

extension UserProfileRowMapper on UserProfileRow {
  UserProfile toDomain() => UserProfile(
        uid: uid,
        name: name,
        heightCm: heightCm,
        birthYear: birthYear,
        gender: gender,
        units: units,
        goalType: goalType,
        goalWeight: goalWeight,
        goalDate: _fromMillis(goalDate),
        tdeeTarget: tdeeTarget,
        adaptiveGoalsEnabled: adaptiveGoalsEnabled,
        lastUpdatedAt: _fromMillis(lastUpdatedAt),
        createdAt: _fromMillis(createdAt),
      );
}

UserProfilesCompanion userProfileToCompanion(UserProfile profile, {bool isDirty = true}) {
  return UserProfilesCompanion.insert(
    uid: profile.uid,
    name: profile.name,
    heightCm: profile.heightCm,
    birthYear: Value(profile.birthYear),
    gender: Value(profile.gender),
    units: profile.units,
    goalType: profile.goalType,
    goalWeight: profile.goalWeight,
    goalDate: _toMillis(profile.goalDate),
    tdeeTarget: Value(profile.tdeeTarget),
    adaptiveGoalsEnabled: Value(profile.adaptiveGoalsEnabled),
    lastUpdatedAt: _toMillis(profile.lastUpdatedAt),
    createdAt: _toMillis(profile.createdAt),
    isDirty: Value(isDirty),
  );
}

extension WeightEntryRowMapper on WeightEntryRow {
  WeightEntry toDomain() => WeightEntry(
        id: id,
        uid: uid,
        dateTime: _fromMillis(recordedAt),
        weightKg: weightKg,
        note: note,
        conditionTag: conditionTag,
        moodTag: moodTag,
        lastUpdatedAt: _fromMillis(lastUpdatedAt),
        isDeleted: isDeleted,
      );
}

WeightEntriesCompanion weightEntryToCompanion(WeightEntry entry, {bool isDirty = true}) {
  return WeightEntriesCompanion.insert(
    id: entry.id,
    uid: entry.uid,
    recordedAt: _toMillis(entry.dateTime),
    weightKg: entry.weightKg,
    note: Value(entry.note),
    conditionTag: Value(entry.conditionTag),
    moodTag: Value(entry.moodTag),
    lastUpdatedAt: _toMillis(entry.lastUpdatedAt),
    isDeleted: Value(entry.isDeleted),
    isDirty: Value(isDirty),
  );
}

extension MeasurementEntryRowMapper on MeasurementEntryRow {
  MeasurementEntry toDomain() => MeasurementEntry(
        id: id,
        uid: uid,
        dateTime: _fromMillis(recordedAt),
        waistCm: waistCm,
        hipCm: hipCm,
        chestCm: chestCm,
        neckCm: neckCm,
        armCm: armCm,
        thighCm: thighCm,
        bodyFatPct: bodyFatPct,
        musclePct: musclePct,
        waterPct: waterPct,
        lastUpdatedAt: _fromMillis(lastUpdatedAt),
        isDeleted: isDeleted,
      );
}

MeasurementEntriesCompanion measurementEntryToCompanion(
  MeasurementEntry entry, {
  bool isDirty = true,
}) {
  return MeasurementEntriesCompanion.insert(
    id: entry.id,
    uid: entry.uid,
    recordedAt: _toMillis(entry.dateTime),
    waistCm: entry.waistCm,
    hipCm: entry.hipCm,
    chestCm: entry.chestCm,
    neckCm: entry.neckCm,
    armCm: entry.armCm,
    thighCm: entry.thighCm,
    bodyFatPct: Value(entry.bodyFatPct),
    musclePct: Value(entry.musclePct),
    waterPct: Value(entry.waterPct),
    lastUpdatedAt: _toMillis(entry.lastUpdatedAt),
    isDeleted: Value(entry.isDeleted),
    isDirty: Value(isDirty),
  );
}

extension WaterEntryRowMapper on WaterEntryRow {
  WaterEntry toDomain() => WaterEntry(
        id: id,
        uid: uid,
        date: _fromMillis(date),
        ml: ml,
        lastUpdatedAt: _fromMillis(lastUpdatedAt),
        isDeleted: isDeleted,
      );
}

WaterEntriesCompanion waterEntryToCompanion(WaterEntry entry, {bool isDirty = true}) {
  return WaterEntriesCompanion.insert(
    id: entry.id,
    uid: entry.uid,
    date: _toMillis(entry.date),
    ml: entry.ml,
    lastUpdatedAt: _toMillis(entry.lastUpdatedAt),
    isDeleted: Value(entry.isDeleted),
    isDirty: Value(isDirty),
  );
}

extension FoodEntryRowMapper on FoodEntryRow {
  FoodEntry toDomain() => FoodEntry(
        id: id,
        uid: uid,
        dateTime: _fromMillis(recordedAt),
        mealType: mealType,
        items: items,
        totals: totals,
        lastUpdatedAt: _fromMillis(lastUpdatedAt),
        isDeleted: isDeleted,
      );
}

FoodEntriesCompanion foodEntryToCompanion(FoodEntry entry, {bool isDirty = true}) {
  return FoodEntriesCompanion.insert(
    id: entry.id,
    uid: entry.uid,
    recordedAt: _toMillis(entry.dateTime),
    mealType: entry.mealType,
    items: entry.items,
    totals: entry.totals,
    lastUpdatedAt: _toMillis(entry.lastUpdatedAt),
    isDeleted: Value(entry.isDeleted),
    isDirty: Value(isDirty),
  );
}

extension CustomFoodRowMapper on CustomFoodRow {
  CustomFood toDomain() => CustomFood(
        id: id,
        uid: uid,
        nameTr: nameTr,
        nameEn: nameEn,
        barcode: barcode,
        cal: cal,
        protein: protein,
        carb: carb,
        fat: fat,
        fiber: fiber,
        sodium: sodium,
        sugar: sugar,
        lastUpdatedAt: _fromMillis(lastUpdatedAt),
        isDeleted: isDeleted,
      );
}

CustomFoodsCompanion customFoodToCompanion(CustomFood food, {bool isDirty = true}) {
  return CustomFoodsCompanion.insert(
    id: food.id,
    uid: food.uid,
    nameTr: food.nameTr,
    nameEn: food.nameEn,
    barcode: Value(food.barcode),
    cal: food.cal,
    protein: food.protein,
    carb: food.carb,
    fat: food.fat,
    fiber: Value(food.fiber),
    sodium: Value(food.sodium),
    sugar: Value(food.sugar),
    lastUpdatedAt: _toMillis(food.lastUpdatedAt),
    isDeleted: Value(food.isDeleted),
    isDirty: Value(isDirty),
  );
}

extension FastingSessionRowMapper on FastingSessionRow {
  FastingSession toDomain() => FastingSession(
        id: id,
        uid: uid,
        start: _fromMillis(start),
        end: end == null ? null : _fromMillis(end!),
        planType: planType,
        goalHours: goalHours,
        completed: completed,
        lastUpdatedAt: _fromMillis(lastUpdatedAt),
        isDeleted: isDeleted,
      );
}

FastingSessionsCompanion fastingSessionToCompanion(
  FastingSession session, {
  bool isDirty = true,
}) {
  return FastingSessionsCompanion.insert(
    id: session.id,
    uid: session.uid,
    start: _toMillis(session.start),
    end: Value(session.end == null ? null : _toMillis(session.end!)),
    planType: session.planType,
    goalHours: session.goalHours,
    completed: Value(session.completed),
    lastUpdatedAt: _toMillis(session.lastUpdatedAt),
    isDeleted: Value(session.isDeleted),
    isDirty: Value(isDirty),
  );
}

extension ActivityEntryRowMapper on ActivityEntryRow {
  ActivityEntry toDomain() => ActivityEntry(
        id: id,
        uid: uid,
        dateTime: _fromMillis(recordedAt),
        type: type,
        durationMin: durationMin,
        calories: calories,
        steps: steps,
        source: source,
        lastUpdatedAt: _fromMillis(lastUpdatedAt),
        isDeleted: isDeleted,
      );
}

ActivityEntriesCompanion activityEntryToCompanion(
  ActivityEntry entry, {
  bool isDirty = true,
}) {
  return ActivityEntriesCompanion.insert(
    id: entry.id,
    uid: entry.uid,
    recordedAt: _toMillis(entry.dateTime),
    type: entry.type,
    durationMin: entry.durationMin,
    calories: entry.calories,
    steps: Value(entry.steps),
    source: entry.source,
    lastUpdatedAt: _toMillis(entry.lastUpdatedAt),
    isDeleted: Value(entry.isDeleted),
    isDirty: Value(isDirty),
  );
}

extension PhotoEntryRowMapper on PhotoEntryRow {
  PhotoEntry toDomain() => PhotoEntry(
        id: id,
        uid: uid,
        date: _fromMillis(date),
        type: type,
        storageUrl: storageUrl,
        localPath: localPath,
        notes: notes,
        lastUpdatedAt: _fromMillis(lastUpdatedAt),
        isDeleted: isDeleted,
      );
}

PhotoEntriesCompanion photoEntryToCompanion(PhotoEntry entry, {bool isDirty = true}) {
  return PhotoEntriesCompanion.insert(
    id: entry.id,
    uid: entry.uid,
    date: _toMillis(entry.date),
    type: entry.type,
    storageUrl: Value(entry.storageUrl),
    localPath: Value(entry.localPath),
    notes: Value(entry.notes),
    lastUpdatedAt: _toMillis(entry.lastUpdatedAt),
    isDeleted: Value(entry.isDeleted),
    isDirty: Value(isDirty),
  );
}

extension SyncLogRowMapper on SyncLogRow {
  SyncLog toDomain() => SyncLog(
        id: id,
        uid: uid,
        entityType: entityType,
        entityId: entityId,
        conflictInfo: conflictInfo,
        createdAt: _fromMillis(createdAt),
      );
}

SyncLogsCompanion syncLogToCompanion(SyncLog log) {
  return SyncLogsCompanion.insert(
    id: log.id,
    uid: log.uid,
    entityType: log.entityType,
    entityId: log.entityId,
    conflictInfo: Value(log.conflictInfo),
    createdAt: _toMillis(log.createdAt),
  );
}
