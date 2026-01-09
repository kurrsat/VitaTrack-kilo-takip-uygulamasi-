import 'package:drift/drift.dart';
import 'package:weightvault/data/db/converters.dart';
import 'package:weightvault/domain/models/models.dart';
@DataClassName('UserProfileRow')
class UserProfiles extends Table {
  TextColumn get uid => text()();
  TextColumn get name => text()();
  RealColumn get heightCm => real()();
  IntColumn get birthYear => integer().nullable()();
  TextColumn get gender => text().nullable()();
  TextColumn get units => textEnum<UnitsSystem>()();
  TextColumn get goalType => textEnum<GoalType>()();
  RealColumn get goalWeight => real()();
  IntColumn get goalDate => integer()();
  RealColumn get tdeeTarget => real().nullable()();
  BoolColumn get adaptiveGoalsEnabled => boolean().withDefault(const Constant(false))();
  IntColumn get lastUpdatedAt => integer()();
  IntColumn get createdAt => integer()();
  BoolColumn get isDirty => boolean().withDefault(const Constant(true))();

  @override
  Set<Column<Object>>? get primaryKey => {uid};
}

@DataClassName('WeightEntryRow')
class WeightEntries extends Table {
  TextColumn get id => text()();
  TextColumn get uid => text()();
  IntColumn get recordedAt => integer().named('date_time')();
  RealColumn get weightKg => real()();
  TextColumn get note => text().nullable()();
  TextColumn get conditionTag => textEnum<ConditionTag>().nullable()();
  TextColumn get moodTag => textEnum<MoodTag>().nullable()();
  IntColumn get lastUpdatedAt => integer()();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
  BoolColumn get isDirty => boolean().withDefault(const Constant(true))();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}

@DataClassName('MeasurementEntryRow')
class MeasurementEntries extends Table {
  TextColumn get id => text()();
  TextColumn get uid => text()();
  IntColumn get recordedAt => integer().named('date_time')();
  RealColumn get waistCm => real()();
  RealColumn get hipCm => real()();
  RealColumn get chestCm => real()();
  RealColumn get neckCm => real()();
  RealColumn get armCm => real()();
  RealColumn get thighCm => real()();
  RealColumn get bodyFatPct => real().nullable()();
  RealColumn get musclePct => real().nullable()();
  RealColumn get waterPct => real().nullable()();
  IntColumn get lastUpdatedAt => integer()();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
  BoolColumn get isDirty => boolean().withDefault(const Constant(true))();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}

@DataClassName('WaterEntryRow')
class WaterEntries extends Table {
  TextColumn get id => text()();
  TextColumn get uid => text()();
  IntColumn get date => integer()();
  IntColumn get ml => integer()();
  IntColumn get lastUpdatedAt => integer()();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
  BoolColumn get isDirty => boolean().withDefault(const Constant(true))();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}

@DataClassName('FoodEntryRow')
class FoodEntries extends Table {
  TextColumn get id => text()();
  TextColumn get uid => text()();
  IntColumn get recordedAt => integer().named('date_time')();
  TextColumn get mealType => textEnum<MealType>()();
  TextColumn get items => text().map(const FoodItemsConverter())();
  TextColumn get totals => text().map(const FoodTotalsConverter())();
  IntColumn get lastUpdatedAt => integer()();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
  BoolColumn get isDirty => boolean().withDefault(const Constant(true))();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}

@DataClassName('CustomFoodRow')
class CustomFoods extends Table {
  TextColumn get id => text()();
  TextColumn get uid => text()();
  TextColumn get nameTr => text()();
  TextColumn get nameEn => text()();
  TextColumn get barcode => text().nullable()();
  RealColumn get cal => real()();
  RealColumn get protein => real()();
  RealColumn get carb => real()();
  RealColumn get fat => real()();
  RealColumn get fiber => real().nullable()();
  RealColumn get sodium => real().nullable()();
  RealColumn get sugar => real().nullable()();
  IntColumn get lastUpdatedAt => integer()();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
  BoolColumn get isDirty => boolean().withDefault(const Constant(true))();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}

@DataClassName('FastingSessionRow')
class FastingSessions extends Table {
  TextColumn get id => text()();
  TextColumn get uid => text()();
  IntColumn get start => integer()();
  IntColumn get end => integer().nullable()();
  TextColumn get planType => textEnum<FastingPlanType>()();
  IntColumn get goalHours => integer()();
  BoolColumn get completed => boolean().withDefault(const Constant(false))();
  IntColumn get lastUpdatedAt => integer()();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
  BoolColumn get isDirty => boolean().withDefault(const Constant(true))();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}

@DataClassName('ActivityEntryRow')
class ActivityEntries extends Table {
  TextColumn get id => text()();
  TextColumn get uid => text()();
  IntColumn get recordedAt => integer().named('date_time')();
  TextColumn get type => text()();
  IntColumn get durationMin => integer()();
  RealColumn get calories => real()();
  IntColumn get steps => integer().nullable()();
  TextColumn get source => textEnum<ActivitySource>()();
  IntColumn get lastUpdatedAt => integer()();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
  BoolColumn get isDirty => boolean().withDefault(const Constant(true))();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}

@DataClassName('PhotoEntryRow')
class PhotoEntries extends Table {
  TextColumn get id => text()();
  TextColumn get uid => text()();
  IntColumn get date => integer()();
  TextColumn get type => textEnum<PhotoType>()();
  TextColumn get storageUrl => text().nullable()();
  TextColumn get localPath => text().nullable()();
  TextColumn get notes => text().nullable()();
  IntColumn get lastUpdatedAt => integer()();
  BoolColumn get isDeleted => boolean().withDefault(const Constant(false))();
  BoolColumn get isDirty => boolean().withDefault(const Constant(true))();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}

@DataClassName('SyncLogRow')
class SyncLogs extends Table {
  TextColumn get id => text()();
  TextColumn get uid => text()();
  TextColumn get entityType => text()();
  TextColumn get entityId => text()();
  TextColumn get conflictInfo => text().nullable()();
  IntColumn get createdAt => integer()();

  @override
  Set<Column<Object>>? get primaryKey => {id};
}
