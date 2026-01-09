// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserProfile _$UserProfileFromJson(Map<String, dynamic> json) {
  return _UserProfile.fromJson(json);
}

/// @nodoc
mixin _$UserProfile {
  String get uid => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  double get heightCm => throw _privateConstructorUsedError;
  int? get birthYear => throw _privateConstructorUsedError;
  String? get gender => throw _privateConstructorUsedError;
  UnitsSystem get units => throw _privateConstructorUsedError;
  GoalType get goalType => throw _privateConstructorUsedError;
  double get goalWeight => throw _privateConstructorUsedError;
  @DateTimeMillisConverter()
  DateTime get goalDate => throw _privateConstructorUsedError;
  double? get tdeeTarget => throw _privateConstructorUsedError;
  bool get adaptiveGoalsEnabled => throw _privateConstructorUsedError;
  @DateTimeMillisConverter()
  DateTime get lastUpdatedAt => throw _privateConstructorUsedError;
  @DateTimeMillisConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this UserProfile to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserProfileCopyWith<UserProfile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserProfileCopyWith<$Res> {
  factory $UserProfileCopyWith(
          UserProfile value, $Res Function(UserProfile) then) =
      _$UserProfileCopyWithImpl<$Res, UserProfile>;
  @useResult
  $Res call(
      {String uid,
      String name,
      double heightCm,
      int? birthYear,
      String? gender,
      UnitsSystem units,
      GoalType goalType,
      double goalWeight,
      @DateTimeMillisConverter() DateTime goalDate,
      double? tdeeTarget,
      bool adaptiveGoalsEnabled,
      @DateTimeMillisConverter() DateTime lastUpdatedAt,
      @DateTimeMillisConverter() DateTime createdAt});
}

/// @nodoc
class _$UserProfileCopyWithImpl<$Res, $Val extends UserProfile>
    implements $UserProfileCopyWith<$Res> {
  _$UserProfileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? name = null,
    Object? heightCm = null,
    Object? birthYear = freezed,
    Object? gender = freezed,
    Object? units = null,
    Object? goalType = null,
    Object? goalWeight = null,
    Object? goalDate = null,
    Object? tdeeTarget = freezed,
    Object? adaptiveGoalsEnabled = null,
    Object? lastUpdatedAt = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      heightCm: null == heightCm
          ? _value.heightCm
          : heightCm // ignore: cast_nullable_to_non_nullable
              as double,
      birthYear: freezed == birthYear
          ? _value.birthYear
          : birthYear // ignore: cast_nullable_to_non_nullable
              as int?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      units: null == units
          ? _value.units
          : units // ignore: cast_nullable_to_non_nullable
              as UnitsSystem,
      goalType: null == goalType
          ? _value.goalType
          : goalType // ignore: cast_nullable_to_non_nullable
              as GoalType,
      goalWeight: null == goalWeight
          ? _value.goalWeight
          : goalWeight // ignore: cast_nullable_to_non_nullable
              as double,
      goalDate: null == goalDate
          ? _value.goalDate
          : goalDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      tdeeTarget: freezed == tdeeTarget
          ? _value.tdeeTarget
          : tdeeTarget // ignore: cast_nullable_to_non_nullable
              as double?,
      adaptiveGoalsEnabled: null == adaptiveGoalsEnabled
          ? _value.adaptiveGoalsEnabled
          : adaptiveGoalsEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      lastUpdatedAt: null == lastUpdatedAt
          ? _value.lastUpdatedAt
          : lastUpdatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserProfileImplCopyWith<$Res>
    implements $UserProfileCopyWith<$Res> {
  factory _$$UserProfileImplCopyWith(
          _$UserProfileImpl value, $Res Function(_$UserProfileImpl) then) =
      __$$UserProfileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String uid,
      String name,
      double heightCm,
      int? birthYear,
      String? gender,
      UnitsSystem units,
      GoalType goalType,
      double goalWeight,
      @DateTimeMillisConverter() DateTime goalDate,
      double? tdeeTarget,
      bool adaptiveGoalsEnabled,
      @DateTimeMillisConverter() DateTime lastUpdatedAt,
      @DateTimeMillisConverter() DateTime createdAt});
}

/// @nodoc
class __$$UserProfileImplCopyWithImpl<$Res>
    extends _$UserProfileCopyWithImpl<$Res, _$UserProfileImpl>
    implements _$$UserProfileImplCopyWith<$Res> {
  __$$UserProfileImplCopyWithImpl(
      _$UserProfileImpl _value, $Res Function(_$UserProfileImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? name = null,
    Object? heightCm = null,
    Object? birthYear = freezed,
    Object? gender = freezed,
    Object? units = null,
    Object? goalType = null,
    Object? goalWeight = null,
    Object? goalDate = null,
    Object? tdeeTarget = freezed,
    Object? adaptiveGoalsEnabled = null,
    Object? lastUpdatedAt = null,
    Object? createdAt = null,
  }) {
    return _then(_$UserProfileImpl(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      heightCm: null == heightCm
          ? _value.heightCm
          : heightCm // ignore: cast_nullable_to_non_nullable
              as double,
      birthYear: freezed == birthYear
          ? _value.birthYear
          : birthYear // ignore: cast_nullable_to_non_nullable
              as int?,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String?,
      units: null == units
          ? _value.units
          : units // ignore: cast_nullable_to_non_nullable
              as UnitsSystem,
      goalType: null == goalType
          ? _value.goalType
          : goalType // ignore: cast_nullable_to_non_nullable
              as GoalType,
      goalWeight: null == goalWeight
          ? _value.goalWeight
          : goalWeight // ignore: cast_nullable_to_non_nullable
              as double,
      goalDate: null == goalDate
          ? _value.goalDate
          : goalDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      tdeeTarget: freezed == tdeeTarget
          ? _value.tdeeTarget
          : tdeeTarget // ignore: cast_nullable_to_non_nullable
              as double?,
      adaptiveGoalsEnabled: null == adaptiveGoalsEnabled
          ? _value.adaptiveGoalsEnabled
          : adaptiveGoalsEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      lastUpdatedAt: null == lastUpdatedAt
          ? _value.lastUpdatedAt
          : lastUpdatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserProfileImpl implements _UserProfile {
  const _$UserProfileImpl(
      {required this.uid,
      required this.name,
      required this.heightCm,
      this.birthYear,
      this.gender,
      required this.units,
      required this.goalType,
      required this.goalWeight,
      @DateTimeMillisConverter() required this.goalDate,
      this.tdeeTarget,
      required this.adaptiveGoalsEnabled,
      @DateTimeMillisConverter() required this.lastUpdatedAt,
      @DateTimeMillisConverter() required this.createdAt});

  factory _$UserProfileImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserProfileImplFromJson(json);

  @override
  final String uid;
  @override
  final String name;
  @override
  final double heightCm;
  @override
  final int? birthYear;
  @override
  final String? gender;
  @override
  final UnitsSystem units;
  @override
  final GoalType goalType;
  @override
  final double goalWeight;
  @override
  @DateTimeMillisConverter()
  final DateTime goalDate;
  @override
  final double? tdeeTarget;
  @override
  final bool adaptiveGoalsEnabled;
  @override
  @DateTimeMillisConverter()
  final DateTime lastUpdatedAt;
  @override
  @DateTimeMillisConverter()
  final DateTime createdAt;

  @override
  String toString() {
    return 'UserProfile(uid: $uid, name: $name, heightCm: $heightCm, birthYear: $birthYear, gender: $gender, units: $units, goalType: $goalType, goalWeight: $goalWeight, goalDate: $goalDate, tdeeTarget: $tdeeTarget, adaptiveGoalsEnabled: $adaptiveGoalsEnabled, lastUpdatedAt: $lastUpdatedAt, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserProfileImpl &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.heightCm, heightCm) ||
                other.heightCm == heightCm) &&
            (identical(other.birthYear, birthYear) ||
                other.birthYear == birthYear) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.units, units) || other.units == units) &&
            (identical(other.goalType, goalType) ||
                other.goalType == goalType) &&
            (identical(other.goalWeight, goalWeight) ||
                other.goalWeight == goalWeight) &&
            (identical(other.goalDate, goalDate) ||
                other.goalDate == goalDate) &&
            (identical(other.tdeeTarget, tdeeTarget) ||
                other.tdeeTarget == tdeeTarget) &&
            (identical(other.adaptiveGoalsEnabled, adaptiveGoalsEnabled) ||
                other.adaptiveGoalsEnabled == adaptiveGoalsEnabled) &&
            (identical(other.lastUpdatedAt, lastUpdatedAt) ||
                other.lastUpdatedAt == lastUpdatedAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      uid,
      name,
      heightCm,
      birthYear,
      gender,
      units,
      goalType,
      goalWeight,
      goalDate,
      tdeeTarget,
      adaptiveGoalsEnabled,
      lastUpdatedAt,
      createdAt);

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserProfileImplCopyWith<_$UserProfileImpl> get copyWith =>
      __$$UserProfileImplCopyWithImpl<_$UserProfileImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserProfileImplToJson(
      this,
    );
  }
}

abstract class _UserProfile implements UserProfile {
  const factory _UserProfile(
          {required final String uid,
          required final String name,
          required final double heightCm,
          final int? birthYear,
          final String? gender,
          required final UnitsSystem units,
          required final GoalType goalType,
          required final double goalWeight,
          @DateTimeMillisConverter() required final DateTime goalDate,
          final double? tdeeTarget,
          required final bool adaptiveGoalsEnabled,
          @DateTimeMillisConverter() required final DateTime lastUpdatedAt,
          @DateTimeMillisConverter() required final DateTime createdAt}) =
      _$UserProfileImpl;

  factory _UserProfile.fromJson(Map<String, dynamic> json) =
      _$UserProfileImpl.fromJson;

  @override
  String get uid;
  @override
  String get name;
  @override
  double get heightCm;
  @override
  int? get birthYear;
  @override
  String? get gender;
  @override
  UnitsSystem get units;
  @override
  GoalType get goalType;
  @override
  double get goalWeight;
  @override
  @DateTimeMillisConverter()
  DateTime get goalDate;
  @override
  double? get tdeeTarget;
  @override
  bool get adaptiveGoalsEnabled;
  @override
  @DateTimeMillisConverter()
  DateTime get lastUpdatedAt;
  @override
  @DateTimeMillisConverter()
  DateTime get createdAt;

  /// Create a copy of UserProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserProfileImplCopyWith<_$UserProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WeightEntry _$WeightEntryFromJson(Map<String, dynamic> json) {
  return _WeightEntry.fromJson(json);
}

/// @nodoc
mixin _$WeightEntry {
  String get id => throw _privateConstructorUsedError;
  String get uid => throw _privateConstructorUsedError;
  @DateTimeMillisConverter()
  DateTime get dateTime => throw _privateConstructorUsedError;
  double get weightKg => throw _privateConstructorUsedError;
  String? get note => throw _privateConstructorUsedError;
  ConditionTag? get conditionTag => throw _privateConstructorUsedError;
  MoodTag? get moodTag => throw _privateConstructorUsedError;
  @DateTimeMillisConverter()
  DateTime get lastUpdatedAt => throw _privateConstructorUsedError;
  bool get isDeleted => throw _privateConstructorUsedError;

  /// Serializes this WeightEntry to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WeightEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WeightEntryCopyWith<WeightEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WeightEntryCopyWith<$Res> {
  factory $WeightEntryCopyWith(
          WeightEntry value, $Res Function(WeightEntry) then) =
      _$WeightEntryCopyWithImpl<$Res, WeightEntry>;
  @useResult
  $Res call(
      {String id,
      String uid,
      @DateTimeMillisConverter() DateTime dateTime,
      double weightKg,
      String? note,
      ConditionTag? conditionTag,
      MoodTag? moodTag,
      @DateTimeMillisConverter() DateTime lastUpdatedAt,
      bool isDeleted});
}

/// @nodoc
class _$WeightEntryCopyWithImpl<$Res, $Val extends WeightEntry>
    implements $WeightEntryCopyWith<$Res> {
  _$WeightEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WeightEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? uid = null,
    Object? dateTime = null,
    Object? weightKg = null,
    Object? note = freezed,
    Object? conditionTag = freezed,
    Object? moodTag = freezed,
    Object? lastUpdatedAt = null,
    Object? isDeleted = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      dateTime: null == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      weightKg: null == weightKg
          ? _value.weightKg
          : weightKg // ignore: cast_nullable_to_non_nullable
              as double,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      conditionTag: freezed == conditionTag
          ? _value.conditionTag
          : conditionTag // ignore: cast_nullable_to_non_nullable
              as ConditionTag?,
      moodTag: freezed == moodTag
          ? _value.moodTag
          : moodTag // ignore: cast_nullable_to_non_nullable
              as MoodTag?,
      lastUpdatedAt: null == lastUpdatedAt
          ? _value.lastUpdatedAt
          : lastUpdatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isDeleted: null == isDeleted
          ? _value.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WeightEntryImplCopyWith<$Res>
    implements $WeightEntryCopyWith<$Res> {
  factory _$$WeightEntryImplCopyWith(
          _$WeightEntryImpl value, $Res Function(_$WeightEntryImpl) then) =
      __$$WeightEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String uid,
      @DateTimeMillisConverter() DateTime dateTime,
      double weightKg,
      String? note,
      ConditionTag? conditionTag,
      MoodTag? moodTag,
      @DateTimeMillisConverter() DateTime lastUpdatedAt,
      bool isDeleted});
}

/// @nodoc
class __$$WeightEntryImplCopyWithImpl<$Res>
    extends _$WeightEntryCopyWithImpl<$Res, _$WeightEntryImpl>
    implements _$$WeightEntryImplCopyWith<$Res> {
  __$$WeightEntryImplCopyWithImpl(
      _$WeightEntryImpl _value, $Res Function(_$WeightEntryImpl) _then)
      : super(_value, _then);

  /// Create a copy of WeightEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? uid = null,
    Object? dateTime = null,
    Object? weightKg = null,
    Object? note = freezed,
    Object? conditionTag = freezed,
    Object? moodTag = freezed,
    Object? lastUpdatedAt = null,
    Object? isDeleted = null,
  }) {
    return _then(_$WeightEntryImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      dateTime: null == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      weightKg: null == weightKg
          ? _value.weightKg
          : weightKg // ignore: cast_nullable_to_non_nullable
              as double,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      conditionTag: freezed == conditionTag
          ? _value.conditionTag
          : conditionTag // ignore: cast_nullable_to_non_nullable
              as ConditionTag?,
      moodTag: freezed == moodTag
          ? _value.moodTag
          : moodTag // ignore: cast_nullable_to_non_nullable
              as MoodTag?,
      lastUpdatedAt: null == lastUpdatedAt
          ? _value.lastUpdatedAt
          : lastUpdatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isDeleted: null == isDeleted
          ? _value.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WeightEntryImpl implements _WeightEntry {
  const _$WeightEntryImpl(
      {required this.id,
      required this.uid,
      @DateTimeMillisConverter() required this.dateTime,
      required this.weightKg,
      this.note,
      this.conditionTag,
      this.moodTag,
      @DateTimeMillisConverter() required this.lastUpdatedAt,
      this.isDeleted = false});

  factory _$WeightEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$WeightEntryImplFromJson(json);

  @override
  final String id;
  @override
  final String uid;
  @override
  @DateTimeMillisConverter()
  final DateTime dateTime;
  @override
  final double weightKg;
  @override
  final String? note;
  @override
  final ConditionTag? conditionTag;
  @override
  final MoodTag? moodTag;
  @override
  @DateTimeMillisConverter()
  final DateTime lastUpdatedAt;
  @override
  @JsonKey()
  final bool isDeleted;

  @override
  String toString() {
    return 'WeightEntry(id: $id, uid: $uid, dateTime: $dateTime, weightKg: $weightKg, note: $note, conditionTag: $conditionTag, moodTag: $moodTag, lastUpdatedAt: $lastUpdatedAt, isDeleted: $isDeleted)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WeightEntryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.dateTime, dateTime) ||
                other.dateTime == dateTime) &&
            (identical(other.weightKg, weightKg) ||
                other.weightKg == weightKg) &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.conditionTag, conditionTag) ||
                other.conditionTag == conditionTag) &&
            (identical(other.moodTag, moodTag) || other.moodTag == moodTag) &&
            (identical(other.lastUpdatedAt, lastUpdatedAt) ||
                other.lastUpdatedAt == lastUpdatedAt) &&
            (identical(other.isDeleted, isDeleted) ||
                other.isDeleted == isDeleted));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, uid, dateTime, weightKg,
      note, conditionTag, moodTag, lastUpdatedAt, isDeleted);

  /// Create a copy of WeightEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WeightEntryImplCopyWith<_$WeightEntryImpl> get copyWith =>
      __$$WeightEntryImplCopyWithImpl<_$WeightEntryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WeightEntryImplToJson(
      this,
    );
  }
}

abstract class _WeightEntry implements WeightEntry {
  const factory _WeightEntry(
      {required final String id,
      required final String uid,
      @DateTimeMillisConverter() required final DateTime dateTime,
      required final double weightKg,
      final String? note,
      final ConditionTag? conditionTag,
      final MoodTag? moodTag,
      @DateTimeMillisConverter() required final DateTime lastUpdatedAt,
      final bool isDeleted}) = _$WeightEntryImpl;

  factory _WeightEntry.fromJson(Map<String, dynamic> json) =
      _$WeightEntryImpl.fromJson;

  @override
  String get id;
  @override
  String get uid;
  @override
  @DateTimeMillisConverter()
  DateTime get dateTime;
  @override
  double get weightKg;
  @override
  String? get note;
  @override
  ConditionTag? get conditionTag;
  @override
  MoodTag? get moodTag;
  @override
  @DateTimeMillisConverter()
  DateTime get lastUpdatedAt;
  @override
  bool get isDeleted;

  /// Create a copy of WeightEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WeightEntryImplCopyWith<_$WeightEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MeasurementEntry _$MeasurementEntryFromJson(Map<String, dynamic> json) {
  return _MeasurementEntry.fromJson(json);
}

/// @nodoc
mixin _$MeasurementEntry {
  String get id => throw _privateConstructorUsedError;
  String get uid => throw _privateConstructorUsedError;
  @DateTimeMillisConverter()
  DateTime get dateTime => throw _privateConstructorUsedError;
  double get waistCm => throw _privateConstructorUsedError;
  double get hipCm => throw _privateConstructorUsedError;
  double get chestCm => throw _privateConstructorUsedError;
  double get neckCm => throw _privateConstructorUsedError;
  double get armCm => throw _privateConstructorUsedError;
  double get thighCm => throw _privateConstructorUsedError;
  double? get bodyFatPct => throw _privateConstructorUsedError;
  double? get musclePct => throw _privateConstructorUsedError;
  double? get waterPct => throw _privateConstructorUsedError;
  @DateTimeMillisConverter()
  DateTime get lastUpdatedAt => throw _privateConstructorUsedError;
  bool get isDeleted => throw _privateConstructorUsedError;

  /// Serializes this MeasurementEntry to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MeasurementEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MeasurementEntryCopyWith<MeasurementEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MeasurementEntryCopyWith<$Res> {
  factory $MeasurementEntryCopyWith(
          MeasurementEntry value, $Res Function(MeasurementEntry) then) =
      _$MeasurementEntryCopyWithImpl<$Res, MeasurementEntry>;
  @useResult
  $Res call(
      {String id,
      String uid,
      @DateTimeMillisConverter() DateTime dateTime,
      double waistCm,
      double hipCm,
      double chestCm,
      double neckCm,
      double armCm,
      double thighCm,
      double? bodyFatPct,
      double? musclePct,
      double? waterPct,
      @DateTimeMillisConverter() DateTime lastUpdatedAt,
      bool isDeleted});
}

/// @nodoc
class _$MeasurementEntryCopyWithImpl<$Res, $Val extends MeasurementEntry>
    implements $MeasurementEntryCopyWith<$Res> {
  _$MeasurementEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MeasurementEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? uid = null,
    Object? dateTime = null,
    Object? waistCm = null,
    Object? hipCm = null,
    Object? chestCm = null,
    Object? neckCm = null,
    Object? armCm = null,
    Object? thighCm = null,
    Object? bodyFatPct = freezed,
    Object? musclePct = freezed,
    Object? waterPct = freezed,
    Object? lastUpdatedAt = null,
    Object? isDeleted = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      dateTime: null == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      waistCm: null == waistCm
          ? _value.waistCm
          : waistCm // ignore: cast_nullable_to_non_nullable
              as double,
      hipCm: null == hipCm
          ? _value.hipCm
          : hipCm // ignore: cast_nullable_to_non_nullable
              as double,
      chestCm: null == chestCm
          ? _value.chestCm
          : chestCm // ignore: cast_nullable_to_non_nullable
              as double,
      neckCm: null == neckCm
          ? _value.neckCm
          : neckCm // ignore: cast_nullable_to_non_nullable
              as double,
      armCm: null == armCm
          ? _value.armCm
          : armCm // ignore: cast_nullable_to_non_nullable
              as double,
      thighCm: null == thighCm
          ? _value.thighCm
          : thighCm // ignore: cast_nullable_to_non_nullable
              as double,
      bodyFatPct: freezed == bodyFatPct
          ? _value.bodyFatPct
          : bodyFatPct // ignore: cast_nullable_to_non_nullable
              as double?,
      musclePct: freezed == musclePct
          ? _value.musclePct
          : musclePct // ignore: cast_nullable_to_non_nullable
              as double?,
      waterPct: freezed == waterPct
          ? _value.waterPct
          : waterPct // ignore: cast_nullable_to_non_nullable
              as double?,
      lastUpdatedAt: null == lastUpdatedAt
          ? _value.lastUpdatedAt
          : lastUpdatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isDeleted: null == isDeleted
          ? _value.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MeasurementEntryImplCopyWith<$Res>
    implements $MeasurementEntryCopyWith<$Res> {
  factory _$$MeasurementEntryImplCopyWith(_$MeasurementEntryImpl value,
          $Res Function(_$MeasurementEntryImpl) then) =
      __$$MeasurementEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String uid,
      @DateTimeMillisConverter() DateTime dateTime,
      double waistCm,
      double hipCm,
      double chestCm,
      double neckCm,
      double armCm,
      double thighCm,
      double? bodyFatPct,
      double? musclePct,
      double? waterPct,
      @DateTimeMillisConverter() DateTime lastUpdatedAt,
      bool isDeleted});
}

/// @nodoc
class __$$MeasurementEntryImplCopyWithImpl<$Res>
    extends _$MeasurementEntryCopyWithImpl<$Res, _$MeasurementEntryImpl>
    implements _$$MeasurementEntryImplCopyWith<$Res> {
  __$$MeasurementEntryImplCopyWithImpl(_$MeasurementEntryImpl _value,
      $Res Function(_$MeasurementEntryImpl) _then)
      : super(_value, _then);

  /// Create a copy of MeasurementEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? uid = null,
    Object? dateTime = null,
    Object? waistCm = null,
    Object? hipCm = null,
    Object? chestCm = null,
    Object? neckCm = null,
    Object? armCm = null,
    Object? thighCm = null,
    Object? bodyFatPct = freezed,
    Object? musclePct = freezed,
    Object? waterPct = freezed,
    Object? lastUpdatedAt = null,
    Object? isDeleted = null,
  }) {
    return _then(_$MeasurementEntryImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      dateTime: null == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      waistCm: null == waistCm
          ? _value.waistCm
          : waistCm // ignore: cast_nullable_to_non_nullable
              as double,
      hipCm: null == hipCm
          ? _value.hipCm
          : hipCm // ignore: cast_nullable_to_non_nullable
              as double,
      chestCm: null == chestCm
          ? _value.chestCm
          : chestCm // ignore: cast_nullable_to_non_nullable
              as double,
      neckCm: null == neckCm
          ? _value.neckCm
          : neckCm // ignore: cast_nullable_to_non_nullable
              as double,
      armCm: null == armCm
          ? _value.armCm
          : armCm // ignore: cast_nullable_to_non_nullable
              as double,
      thighCm: null == thighCm
          ? _value.thighCm
          : thighCm // ignore: cast_nullable_to_non_nullable
              as double,
      bodyFatPct: freezed == bodyFatPct
          ? _value.bodyFatPct
          : bodyFatPct // ignore: cast_nullable_to_non_nullable
              as double?,
      musclePct: freezed == musclePct
          ? _value.musclePct
          : musclePct // ignore: cast_nullable_to_non_nullable
              as double?,
      waterPct: freezed == waterPct
          ? _value.waterPct
          : waterPct // ignore: cast_nullable_to_non_nullable
              as double?,
      lastUpdatedAt: null == lastUpdatedAt
          ? _value.lastUpdatedAt
          : lastUpdatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isDeleted: null == isDeleted
          ? _value.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MeasurementEntryImpl implements _MeasurementEntry {
  const _$MeasurementEntryImpl(
      {required this.id,
      required this.uid,
      @DateTimeMillisConverter() required this.dateTime,
      required this.waistCm,
      required this.hipCm,
      required this.chestCm,
      required this.neckCm,
      required this.armCm,
      required this.thighCm,
      this.bodyFatPct,
      this.musclePct,
      this.waterPct,
      @DateTimeMillisConverter() required this.lastUpdatedAt,
      this.isDeleted = false});

  factory _$MeasurementEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$MeasurementEntryImplFromJson(json);

  @override
  final String id;
  @override
  final String uid;
  @override
  @DateTimeMillisConverter()
  final DateTime dateTime;
  @override
  final double waistCm;
  @override
  final double hipCm;
  @override
  final double chestCm;
  @override
  final double neckCm;
  @override
  final double armCm;
  @override
  final double thighCm;
  @override
  final double? bodyFatPct;
  @override
  final double? musclePct;
  @override
  final double? waterPct;
  @override
  @DateTimeMillisConverter()
  final DateTime lastUpdatedAt;
  @override
  @JsonKey()
  final bool isDeleted;

  @override
  String toString() {
    return 'MeasurementEntry(id: $id, uid: $uid, dateTime: $dateTime, waistCm: $waistCm, hipCm: $hipCm, chestCm: $chestCm, neckCm: $neckCm, armCm: $armCm, thighCm: $thighCm, bodyFatPct: $bodyFatPct, musclePct: $musclePct, waterPct: $waterPct, lastUpdatedAt: $lastUpdatedAt, isDeleted: $isDeleted)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MeasurementEntryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.dateTime, dateTime) ||
                other.dateTime == dateTime) &&
            (identical(other.waistCm, waistCm) || other.waistCm == waistCm) &&
            (identical(other.hipCm, hipCm) || other.hipCm == hipCm) &&
            (identical(other.chestCm, chestCm) || other.chestCm == chestCm) &&
            (identical(other.neckCm, neckCm) || other.neckCm == neckCm) &&
            (identical(other.armCm, armCm) || other.armCm == armCm) &&
            (identical(other.thighCm, thighCm) || other.thighCm == thighCm) &&
            (identical(other.bodyFatPct, bodyFatPct) ||
                other.bodyFatPct == bodyFatPct) &&
            (identical(other.musclePct, musclePct) ||
                other.musclePct == musclePct) &&
            (identical(other.waterPct, waterPct) ||
                other.waterPct == waterPct) &&
            (identical(other.lastUpdatedAt, lastUpdatedAt) ||
                other.lastUpdatedAt == lastUpdatedAt) &&
            (identical(other.isDeleted, isDeleted) ||
                other.isDeleted == isDeleted));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      uid,
      dateTime,
      waistCm,
      hipCm,
      chestCm,
      neckCm,
      armCm,
      thighCm,
      bodyFatPct,
      musclePct,
      waterPct,
      lastUpdatedAt,
      isDeleted);

  /// Create a copy of MeasurementEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MeasurementEntryImplCopyWith<_$MeasurementEntryImpl> get copyWith =>
      __$$MeasurementEntryImplCopyWithImpl<_$MeasurementEntryImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MeasurementEntryImplToJson(
      this,
    );
  }
}

abstract class _MeasurementEntry implements MeasurementEntry {
  const factory _MeasurementEntry(
      {required final String id,
      required final String uid,
      @DateTimeMillisConverter() required final DateTime dateTime,
      required final double waistCm,
      required final double hipCm,
      required final double chestCm,
      required final double neckCm,
      required final double armCm,
      required final double thighCm,
      final double? bodyFatPct,
      final double? musclePct,
      final double? waterPct,
      @DateTimeMillisConverter() required final DateTime lastUpdatedAt,
      final bool isDeleted}) = _$MeasurementEntryImpl;

  factory _MeasurementEntry.fromJson(Map<String, dynamic> json) =
      _$MeasurementEntryImpl.fromJson;

  @override
  String get id;
  @override
  String get uid;
  @override
  @DateTimeMillisConverter()
  DateTime get dateTime;
  @override
  double get waistCm;
  @override
  double get hipCm;
  @override
  double get chestCm;
  @override
  double get neckCm;
  @override
  double get armCm;
  @override
  double get thighCm;
  @override
  double? get bodyFatPct;
  @override
  double? get musclePct;
  @override
  double? get waterPct;
  @override
  @DateTimeMillisConverter()
  DateTime get lastUpdatedAt;
  @override
  bool get isDeleted;

  /// Create a copy of MeasurementEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MeasurementEntryImplCopyWith<_$MeasurementEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WaterEntry _$WaterEntryFromJson(Map<String, dynamic> json) {
  return _WaterEntry.fromJson(json);
}

/// @nodoc
mixin _$WaterEntry {
  String get id => throw _privateConstructorUsedError;
  String get uid => throw _privateConstructorUsedError;
  @DateTimeMillisConverter()
  DateTime get date => throw _privateConstructorUsedError;
  int get ml => throw _privateConstructorUsedError;
  @DateTimeMillisConverter()
  DateTime get lastUpdatedAt => throw _privateConstructorUsedError;
  bool get isDeleted => throw _privateConstructorUsedError;

  /// Serializes this WaterEntry to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WaterEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WaterEntryCopyWith<WaterEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WaterEntryCopyWith<$Res> {
  factory $WaterEntryCopyWith(
          WaterEntry value, $Res Function(WaterEntry) then) =
      _$WaterEntryCopyWithImpl<$Res, WaterEntry>;
  @useResult
  $Res call(
      {String id,
      String uid,
      @DateTimeMillisConverter() DateTime date,
      int ml,
      @DateTimeMillisConverter() DateTime lastUpdatedAt,
      bool isDeleted});
}

/// @nodoc
class _$WaterEntryCopyWithImpl<$Res, $Val extends WaterEntry>
    implements $WaterEntryCopyWith<$Res> {
  _$WaterEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WaterEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? uid = null,
    Object? date = null,
    Object? ml = null,
    Object? lastUpdatedAt = null,
    Object? isDeleted = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      ml: null == ml
          ? _value.ml
          : ml // ignore: cast_nullable_to_non_nullable
              as int,
      lastUpdatedAt: null == lastUpdatedAt
          ? _value.lastUpdatedAt
          : lastUpdatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isDeleted: null == isDeleted
          ? _value.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WaterEntryImplCopyWith<$Res>
    implements $WaterEntryCopyWith<$Res> {
  factory _$$WaterEntryImplCopyWith(
          _$WaterEntryImpl value, $Res Function(_$WaterEntryImpl) then) =
      __$$WaterEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String uid,
      @DateTimeMillisConverter() DateTime date,
      int ml,
      @DateTimeMillisConverter() DateTime lastUpdatedAt,
      bool isDeleted});
}

/// @nodoc
class __$$WaterEntryImplCopyWithImpl<$Res>
    extends _$WaterEntryCopyWithImpl<$Res, _$WaterEntryImpl>
    implements _$$WaterEntryImplCopyWith<$Res> {
  __$$WaterEntryImplCopyWithImpl(
      _$WaterEntryImpl _value, $Res Function(_$WaterEntryImpl) _then)
      : super(_value, _then);

  /// Create a copy of WaterEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? uid = null,
    Object? date = null,
    Object? ml = null,
    Object? lastUpdatedAt = null,
    Object? isDeleted = null,
  }) {
    return _then(_$WaterEntryImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      ml: null == ml
          ? _value.ml
          : ml // ignore: cast_nullable_to_non_nullable
              as int,
      lastUpdatedAt: null == lastUpdatedAt
          ? _value.lastUpdatedAt
          : lastUpdatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isDeleted: null == isDeleted
          ? _value.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WaterEntryImpl implements _WaterEntry {
  const _$WaterEntryImpl(
      {required this.id,
      required this.uid,
      @DateTimeMillisConverter() required this.date,
      required this.ml,
      @DateTimeMillisConverter() required this.lastUpdatedAt,
      this.isDeleted = false});

  factory _$WaterEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$WaterEntryImplFromJson(json);

  @override
  final String id;
  @override
  final String uid;
  @override
  @DateTimeMillisConverter()
  final DateTime date;
  @override
  final int ml;
  @override
  @DateTimeMillisConverter()
  final DateTime lastUpdatedAt;
  @override
  @JsonKey()
  final bool isDeleted;

  @override
  String toString() {
    return 'WaterEntry(id: $id, uid: $uid, date: $date, ml: $ml, lastUpdatedAt: $lastUpdatedAt, isDeleted: $isDeleted)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WaterEntryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.ml, ml) || other.ml == ml) &&
            (identical(other.lastUpdatedAt, lastUpdatedAt) ||
                other.lastUpdatedAt == lastUpdatedAt) &&
            (identical(other.isDeleted, isDeleted) ||
                other.isDeleted == isDeleted));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, uid, date, ml, lastUpdatedAt, isDeleted);

  /// Create a copy of WaterEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WaterEntryImplCopyWith<_$WaterEntryImpl> get copyWith =>
      __$$WaterEntryImplCopyWithImpl<_$WaterEntryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WaterEntryImplToJson(
      this,
    );
  }
}

abstract class _WaterEntry implements WaterEntry {
  const factory _WaterEntry(
      {required final String id,
      required final String uid,
      @DateTimeMillisConverter() required final DateTime date,
      required final int ml,
      @DateTimeMillisConverter() required final DateTime lastUpdatedAt,
      final bool isDeleted}) = _$WaterEntryImpl;

  factory _WaterEntry.fromJson(Map<String, dynamic> json) =
      _$WaterEntryImpl.fromJson;

  @override
  String get id;
  @override
  String get uid;
  @override
  @DateTimeMillisConverter()
  DateTime get date;
  @override
  int get ml;
  @override
  @DateTimeMillisConverter()
  DateTime get lastUpdatedAt;
  @override
  bool get isDeleted;

  /// Create a copy of WaterEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WaterEntryImplCopyWith<_$WaterEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FoodTotals _$FoodTotalsFromJson(Map<String, dynamic> json) {
  return _FoodTotals.fromJson(json);
}

/// @nodoc
mixin _$FoodTotals {
  double get cal => throw _privateConstructorUsedError;
  double get protein => throw _privateConstructorUsedError;
  double get carb => throw _privateConstructorUsedError;
  double get fat => throw _privateConstructorUsedError;
  double? get fiber => throw _privateConstructorUsedError;
  double? get sodium => throw _privateConstructorUsedError;
  double? get sugar => throw _privateConstructorUsedError;

  /// Serializes this FoodTotals to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FoodTotals
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FoodTotalsCopyWith<FoodTotals> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FoodTotalsCopyWith<$Res> {
  factory $FoodTotalsCopyWith(
          FoodTotals value, $Res Function(FoodTotals) then) =
      _$FoodTotalsCopyWithImpl<$Res, FoodTotals>;
  @useResult
  $Res call(
      {double cal,
      double protein,
      double carb,
      double fat,
      double? fiber,
      double? sodium,
      double? sugar});
}

/// @nodoc
class _$FoodTotalsCopyWithImpl<$Res, $Val extends FoodTotals>
    implements $FoodTotalsCopyWith<$Res> {
  _$FoodTotalsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FoodTotals
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cal = null,
    Object? protein = null,
    Object? carb = null,
    Object? fat = null,
    Object? fiber = freezed,
    Object? sodium = freezed,
    Object? sugar = freezed,
  }) {
    return _then(_value.copyWith(
      cal: null == cal
          ? _value.cal
          : cal // ignore: cast_nullable_to_non_nullable
              as double,
      protein: null == protein
          ? _value.protein
          : protein // ignore: cast_nullable_to_non_nullable
              as double,
      carb: null == carb
          ? _value.carb
          : carb // ignore: cast_nullable_to_non_nullable
              as double,
      fat: null == fat
          ? _value.fat
          : fat // ignore: cast_nullable_to_non_nullable
              as double,
      fiber: freezed == fiber
          ? _value.fiber
          : fiber // ignore: cast_nullable_to_non_nullable
              as double?,
      sodium: freezed == sodium
          ? _value.sodium
          : sodium // ignore: cast_nullable_to_non_nullable
              as double?,
      sugar: freezed == sugar
          ? _value.sugar
          : sugar // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FoodTotalsImplCopyWith<$Res>
    implements $FoodTotalsCopyWith<$Res> {
  factory _$$FoodTotalsImplCopyWith(
          _$FoodTotalsImpl value, $Res Function(_$FoodTotalsImpl) then) =
      __$$FoodTotalsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double cal,
      double protein,
      double carb,
      double fat,
      double? fiber,
      double? sodium,
      double? sugar});
}

/// @nodoc
class __$$FoodTotalsImplCopyWithImpl<$Res>
    extends _$FoodTotalsCopyWithImpl<$Res, _$FoodTotalsImpl>
    implements _$$FoodTotalsImplCopyWith<$Res> {
  __$$FoodTotalsImplCopyWithImpl(
      _$FoodTotalsImpl _value, $Res Function(_$FoodTotalsImpl) _then)
      : super(_value, _then);

  /// Create a copy of FoodTotals
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cal = null,
    Object? protein = null,
    Object? carb = null,
    Object? fat = null,
    Object? fiber = freezed,
    Object? sodium = freezed,
    Object? sugar = freezed,
  }) {
    return _then(_$FoodTotalsImpl(
      cal: null == cal
          ? _value.cal
          : cal // ignore: cast_nullable_to_non_nullable
              as double,
      protein: null == protein
          ? _value.protein
          : protein // ignore: cast_nullable_to_non_nullable
              as double,
      carb: null == carb
          ? _value.carb
          : carb // ignore: cast_nullable_to_non_nullable
              as double,
      fat: null == fat
          ? _value.fat
          : fat // ignore: cast_nullable_to_non_nullable
              as double,
      fiber: freezed == fiber
          ? _value.fiber
          : fiber // ignore: cast_nullable_to_non_nullable
              as double?,
      sodium: freezed == sodium
          ? _value.sodium
          : sodium // ignore: cast_nullable_to_non_nullable
              as double?,
      sugar: freezed == sugar
          ? _value.sugar
          : sugar // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FoodTotalsImpl implements _FoodTotals {
  const _$FoodTotalsImpl(
      {required this.cal,
      required this.protein,
      required this.carb,
      required this.fat,
      this.fiber,
      this.sodium,
      this.sugar});

  factory _$FoodTotalsImpl.fromJson(Map<String, dynamic> json) =>
      _$$FoodTotalsImplFromJson(json);

  @override
  final double cal;
  @override
  final double protein;
  @override
  final double carb;
  @override
  final double fat;
  @override
  final double? fiber;
  @override
  final double? sodium;
  @override
  final double? sugar;

  @override
  String toString() {
    return 'FoodTotals(cal: $cal, protein: $protein, carb: $carb, fat: $fat, fiber: $fiber, sodium: $sodium, sugar: $sugar)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FoodTotalsImpl &&
            (identical(other.cal, cal) || other.cal == cal) &&
            (identical(other.protein, protein) || other.protein == protein) &&
            (identical(other.carb, carb) || other.carb == carb) &&
            (identical(other.fat, fat) || other.fat == fat) &&
            (identical(other.fiber, fiber) || other.fiber == fiber) &&
            (identical(other.sodium, sodium) || other.sodium == sodium) &&
            (identical(other.sugar, sugar) || other.sugar == sugar));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, cal, protein, carb, fat, fiber, sodium, sugar);

  /// Create a copy of FoodTotals
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FoodTotalsImplCopyWith<_$FoodTotalsImpl> get copyWith =>
      __$$FoodTotalsImplCopyWithImpl<_$FoodTotalsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FoodTotalsImplToJson(
      this,
    );
  }
}

abstract class _FoodTotals implements FoodTotals {
  const factory _FoodTotals(
      {required final double cal,
      required final double protein,
      required final double carb,
      required final double fat,
      final double? fiber,
      final double? sodium,
      final double? sugar}) = _$FoodTotalsImpl;

  factory _FoodTotals.fromJson(Map<String, dynamic> json) =
      _$FoodTotalsImpl.fromJson;

  @override
  double get cal;
  @override
  double get protein;
  @override
  double get carb;
  @override
  double get fat;
  @override
  double? get fiber;
  @override
  double? get sodium;
  @override
  double? get sugar;

  /// Create a copy of FoodTotals
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FoodTotalsImplCopyWith<_$FoodTotalsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FoodItem _$FoodItemFromJson(Map<String, dynamic> json) {
  return _FoodItem.fromJson(json);
}

/// @nodoc
mixin _$FoodItem {
  String? get customFoodId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  double get grams => throw _privateConstructorUsedError;
  double get cal => throw _privateConstructorUsedError;
  double get protein => throw _privateConstructorUsedError;
  double get carb => throw _privateConstructorUsedError;
  double get fat => throw _privateConstructorUsedError;
  double? get fiber => throw _privateConstructorUsedError;
  double? get sodium => throw _privateConstructorUsedError;
  double? get sugar => throw _privateConstructorUsedError;

  /// Serializes this FoodItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FoodItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FoodItemCopyWith<FoodItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FoodItemCopyWith<$Res> {
  factory $FoodItemCopyWith(FoodItem value, $Res Function(FoodItem) then) =
      _$FoodItemCopyWithImpl<$Res, FoodItem>;
  @useResult
  $Res call(
      {String? customFoodId,
      String name,
      double grams,
      double cal,
      double protein,
      double carb,
      double fat,
      double? fiber,
      double? sodium,
      double? sugar});
}

/// @nodoc
class _$FoodItemCopyWithImpl<$Res, $Val extends FoodItem>
    implements $FoodItemCopyWith<$Res> {
  _$FoodItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FoodItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? customFoodId = freezed,
    Object? name = null,
    Object? grams = null,
    Object? cal = null,
    Object? protein = null,
    Object? carb = null,
    Object? fat = null,
    Object? fiber = freezed,
    Object? sodium = freezed,
    Object? sugar = freezed,
  }) {
    return _then(_value.copyWith(
      customFoodId: freezed == customFoodId
          ? _value.customFoodId
          : customFoodId // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      grams: null == grams
          ? _value.grams
          : grams // ignore: cast_nullable_to_non_nullable
              as double,
      cal: null == cal
          ? _value.cal
          : cal // ignore: cast_nullable_to_non_nullable
              as double,
      protein: null == protein
          ? _value.protein
          : protein // ignore: cast_nullable_to_non_nullable
              as double,
      carb: null == carb
          ? _value.carb
          : carb // ignore: cast_nullable_to_non_nullable
              as double,
      fat: null == fat
          ? _value.fat
          : fat // ignore: cast_nullable_to_non_nullable
              as double,
      fiber: freezed == fiber
          ? _value.fiber
          : fiber // ignore: cast_nullable_to_non_nullable
              as double?,
      sodium: freezed == sodium
          ? _value.sodium
          : sodium // ignore: cast_nullable_to_non_nullable
              as double?,
      sugar: freezed == sugar
          ? _value.sugar
          : sugar // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FoodItemImplCopyWith<$Res>
    implements $FoodItemCopyWith<$Res> {
  factory _$$FoodItemImplCopyWith(
          _$FoodItemImpl value, $Res Function(_$FoodItemImpl) then) =
      __$$FoodItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? customFoodId,
      String name,
      double grams,
      double cal,
      double protein,
      double carb,
      double fat,
      double? fiber,
      double? sodium,
      double? sugar});
}

/// @nodoc
class __$$FoodItemImplCopyWithImpl<$Res>
    extends _$FoodItemCopyWithImpl<$Res, _$FoodItemImpl>
    implements _$$FoodItemImplCopyWith<$Res> {
  __$$FoodItemImplCopyWithImpl(
      _$FoodItemImpl _value, $Res Function(_$FoodItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of FoodItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? customFoodId = freezed,
    Object? name = null,
    Object? grams = null,
    Object? cal = null,
    Object? protein = null,
    Object? carb = null,
    Object? fat = null,
    Object? fiber = freezed,
    Object? sodium = freezed,
    Object? sugar = freezed,
  }) {
    return _then(_$FoodItemImpl(
      customFoodId: freezed == customFoodId
          ? _value.customFoodId
          : customFoodId // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      grams: null == grams
          ? _value.grams
          : grams // ignore: cast_nullable_to_non_nullable
              as double,
      cal: null == cal
          ? _value.cal
          : cal // ignore: cast_nullable_to_non_nullable
              as double,
      protein: null == protein
          ? _value.protein
          : protein // ignore: cast_nullable_to_non_nullable
              as double,
      carb: null == carb
          ? _value.carb
          : carb // ignore: cast_nullable_to_non_nullable
              as double,
      fat: null == fat
          ? _value.fat
          : fat // ignore: cast_nullable_to_non_nullable
              as double,
      fiber: freezed == fiber
          ? _value.fiber
          : fiber // ignore: cast_nullable_to_non_nullable
              as double?,
      sodium: freezed == sodium
          ? _value.sodium
          : sodium // ignore: cast_nullable_to_non_nullable
              as double?,
      sugar: freezed == sugar
          ? _value.sugar
          : sugar // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FoodItemImpl implements _FoodItem {
  const _$FoodItemImpl(
      {this.customFoodId,
      required this.name,
      required this.grams,
      required this.cal,
      required this.protein,
      required this.carb,
      required this.fat,
      this.fiber,
      this.sodium,
      this.sugar});

  factory _$FoodItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$FoodItemImplFromJson(json);

  @override
  final String? customFoodId;
  @override
  final String name;
  @override
  final double grams;
  @override
  final double cal;
  @override
  final double protein;
  @override
  final double carb;
  @override
  final double fat;
  @override
  final double? fiber;
  @override
  final double? sodium;
  @override
  final double? sugar;

  @override
  String toString() {
    return 'FoodItem(customFoodId: $customFoodId, name: $name, grams: $grams, cal: $cal, protein: $protein, carb: $carb, fat: $fat, fiber: $fiber, sodium: $sodium, sugar: $sugar)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FoodItemImpl &&
            (identical(other.customFoodId, customFoodId) ||
                other.customFoodId == customFoodId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.grams, grams) || other.grams == grams) &&
            (identical(other.cal, cal) || other.cal == cal) &&
            (identical(other.protein, protein) || other.protein == protein) &&
            (identical(other.carb, carb) || other.carb == carb) &&
            (identical(other.fat, fat) || other.fat == fat) &&
            (identical(other.fiber, fiber) || other.fiber == fiber) &&
            (identical(other.sodium, sodium) || other.sodium == sodium) &&
            (identical(other.sugar, sugar) || other.sugar == sugar));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, customFoodId, name, grams, cal,
      protein, carb, fat, fiber, sodium, sugar);

  /// Create a copy of FoodItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FoodItemImplCopyWith<_$FoodItemImpl> get copyWith =>
      __$$FoodItemImplCopyWithImpl<_$FoodItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FoodItemImplToJson(
      this,
    );
  }
}

abstract class _FoodItem implements FoodItem {
  const factory _FoodItem(
      {final String? customFoodId,
      required final String name,
      required final double grams,
      required final double cal,
      required final double protein,
      required final double carb,
      required final double fat,
      final double? fiber,
      final double? sodium,
      final double? sugar}) = _$FoodItemImpl;

  factory _FoodItem.fromJson(Map<String, dynamic> json) =
      _$FoodItemImpl.fromJson;

  @override
  String? get customFoodId;
  @override
  String get name;
  @override
  double get grams;
  @override
  double get cal;
  @override
  double get protein;
  @override
  double get carb;
  @override
  double get fat;
  @override
  double? get fiber;
  @override
  double? get sodium;
  @override
  double? get sugar;

  /// Create a copy of FoodItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FoodItemImplCopyWith<_$FoodItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FoodEntry _$FoodEntryFromJson(Map<String, dynamic> json) {
  return _FoodEntry.fromJson(json);
}

/// @nodoc
mixin _$FoodEntry {
  String get id => throw _privateConstructorUsedError;
  String get uid => throw _privateConstructorUsedError;
  @DateTimeMillisConverter()
  DateTime get dateTime => throw _privateConstructorUsedError;
  MealType get mealType => throw _privateConstructorUsedError;
  List<FoodItem> get items => throw _privateConstructorUsedError;
  FoodTotals get totals => throw _privateConstructorUsedError;
  @DateTimeMillisConverter()
  DateTime get lastUpdatedAt => throw _privateConstructorUsedError;
  bool get isDeleted => throw _privateConstructorUsedError;

  /// Serializes this FoodEntry to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FoodEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FoodEntryCopyWith<FoodEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FoodEntryCopyWith<$Res> {
  factory $FoodEntryCopyWith(FoodEntry value, $Res Function(FoodEntry) then) =
      _$FoodEntryCopyWithImpl<$Res, FoodEntry>;
  @useResult
  $Res call(
      {String id,
      String uid,
      @DateTimeMillisConverter() DateTime dateTime,
      MealType mealType,
      List<FoodItem> items,
      FoodTotals totals,
      @DateTimeMillisConverter() DateTime lastUpdatedAt,
      bool isDeleted});

  $FoodTotalsCopyWith<$Res> get totals;
}

/// @nodoc
class _$FoodEntryCopyWithImpl<$Res, $Val extends FoodEntry>
    implements $FoodEntryCopyWith<$Res> {
  _$FoodEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FoodEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? uid = null,
    Object? dateTime = null,
    Object? mealType = null,
    Object? items = null,
    Object? totals = null,
    Object? lastUpdatedAt = null,
    Object? isDeleted = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      dateTime: null == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      mealType: null == mealType
          ? _value.mealType
          : mealType // ignore: cast_nullable_to_non_nullable
              as MealType,
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<FoodItem>,
      totals: null == totals
          ? _value.totals
          : totals // ignore: cast_nullable_to_non_nullable
              as FoodTotals,
      lastUpdatedAt: null == lastUpdatedAt
          ? _value.lastUpdatedAt
          : lastUpdatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isDeleted: null == isDeleted
          ? _value.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  /// Create a copy of FoodEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FoodTotalsCopyWith<$Res> get totals {
    return $FoodTotalsCopyWith<$Res>(_value.totals, (value) {
      return _then(_value.copyWith(totals: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$FoodEntryImplCopyWith<$Res>
    implements $FoodEntryCopyWith<$Res> {
  factory _$$FoodEntryImplCopyWith(
          _$FoodEntryImpl value, $Res Function(_$FoodEntryImpl) then) =
      __$$FoodEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String uid,
      @DateTimeMillisConverter() DateTime dateTime,
      MealType mealType,
      List<FoodItem> items,
      FoodTotals totals,
      @DateTimeMillisConverter() DateTime lastUpdatedAt,
      bool isDeleted});

  @override
  $FoodTotalsCopyWith<$Res> get totals;
}

/// @nodoc
class __$$FoodEntryImplCopyWithImpl<$Res>
    extends _$FoodEntryCopyWithImpl<$Res, _$FoodEntryImpl>
    implements _$$FoodEntryImplCopyWith<$Res> {
  __$$FoodEntryImplCopyWithImpl(
      _$FoodEntryImpl _value, $Res Function(_$FoodEntryImpl) _then)
      : super(_value, _then);

  /// Create a copy of FoodEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? uid = null,
    Object? dateTime = null,
    Object? mealType = null,
    Object? items = null,
    Object? totals = null,
    Object? lastUpdatedAt = null,
    Object? isDeleted = null,
  }) {
    return _then(_$FoodEntryImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      dateTime: null == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      mealType: null == mealType
          ? _value.mealType
          : mealType // ignore: cast_nullable_to_non_nullable
              as MealType,
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<FoodItem>,
      totals: null == totals
          ? _value.totals
          : totals // ignore: cast_nullable_to_non_nullable
              as FoodTotals,
      lastUpdatedAt: null == lastUpdatedAt
          ? _value.lastUpdatedAt
          : lastUpdatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isDeleted: null == isDeleted
          ? _value.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FoodEntryImpl implements _FoodEntry {
  const _$FoodEntryImpl(
      {required this.id,
      required this.uid,
      @DateTimeMillisConverter() required this.dateTime,
      required this.mealType,
      final List<FoodItem> items = const <FoodItem>[],
      required this.totals,
      @DateTimeMillisConverter() required this.lastUpdatedAt,
      this.isDeleted = false})
      : _items = items;

  factory _$FoodEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$FoodEntryImplFromJson(json);

  @override
  final String id;
  @override
  final String uid;
  @override
  @DateTimeMillisConverter()
  final DateTime dateTime;
  @override
  final MealType mealType;
  final List<FoodItem> _items;
  @override
  @JsonKey()
  List<FoodItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final FoodTotals totals;
  @override
  @DateTimeMillisConverter()
  final DateTime lastUpdatedAt;
  @override
  @JsonKey()
  final bool isDeleted;

  @override
  String toString() {
    return 'FoodEntry(id: $id, uid: $uid, dateTime: $dateTime, mealType: $mealType, items: $items, totals: $totals, lastUpdatedAt: $lastUpdatedAt, isDeleted: $isDeleted)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FoodEntryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.dateTime, dateTime) ||
                other.dateTime == dateTime) &&
            (identical(other.mealType, mealType) ||
                other.mealType == mealType) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.totals, totals) || other.totals == totals) &&
            (identical(other.lastUpdatedAt, lastUpdatedAt) ||
                other.lastUpdatedAt == lastUpdatedAt) &&
            (identical(other.isDeleted, isDeleted) ||
                other.isDeleted == isDeleted));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      uid,
      dateTime,
      mealType,
      const DeepCollectionEquality().hash(_items),
      totals,
      lastUpdatedAt,
      isDeleted);

  /// Create a copy of FoodEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FoodEntryImplCopyWith<_$FoodEntryImpl> get copyWith =>
      __$$FoodEntryImplCopyWithImpl<_$FoodEntryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FoodEntryImplToJson(
      this,
    );
  }
}

abstract class _FoodEntry implements FoodEntry {
  const factory _FoodEntry(
      {required final String id,
      required final String uid,
      @DateTimeMillisConverter() required final DateTime dateTime,
      required final MealType mealType,
      final List<FoodItem> items,
      required final FoodTotals totals,
      @DateTimeMillisConverter() required final DateTime lastUpdatedAt,
      final bool isDeleted}) = _$FoodEntryImpl;

  factory _FoodEntry.fromJson(Map<String, dynamic> json) =
      _$FoodEntryImpl.fromJson;

  @override
  String get id;
  @override
  String get uid;
  @override
  @DateTimeMillisConverter()
  DateTime get dateTime;
  @override
  MealType get mealType;
  @override
  List<FoodItem> get items;
  @override
  FoodTotals get totals;
  @override
  @DateTimeMillisConverter()
  DateTime get lastUpdatedAt;
  @override
  bool get isDeleted;

  /// Create a copy of FoodEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FoodEntryImplCopyWith<_$FoodEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CustomFood _$CustomFoodFromJson(Map<String, dynamic> json) {
  return _CustomFood.fromJson(json);
}

/// @nodoc
mixin _$CustomFood {
  String get id => throw _privateConstructorUsedError;
  String get uid => throw _privateConstructorUsedError;
  String get nameTr => throw _privateConstructorUsedError;
  String get nameEn => throw _privateConstructorUsedError;
  String? get barcode => throw _privateConstructorUsedError;
  double get cal => throw _privateConstructorUsedError;
  double get protein => throw _privateConstructorUsedError;
  double get carb => throw _privateConstructorUsedError;
  double get fat => throw _privateConstructorUsedError;
  double? get fiber => throw _privateConstructorUsedError;
  double? get sodium => throw _privateConstructorUsedError;
  double? get sugar => throw _privateConstructorUsedError;
  @DateTimeMillisConverter()
  DateTime get lastUpdatedAt => throw _privateConstructorUsedError;
  bool get isDeleted => throw _privateConstructorUsedError;

  /// Serializes this CustomFood to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CustomFood
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CustomFoodCopyWith<CustomFood> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomFoodCopyWith<$Res> {
  factory $CustomFoodCopyWith(
          CustomFood value, $Res Function(CustomFood) then) =
      _$CustomFoodCopyWithImpl<$Res, CustomFood>;
  @useResult
  $Res call(
      {String id,
      String uid,
      String nameTr,
      String nameEn,
      String? barcode,
      double cal,
      double protein,
      double carb,
      double fat,
      double? fiber,
      double? sodium,
      double? sugar,
      @DateTimeMillisConverter() DateTime lastUpdatedAt,
      bool isDeleted});
}

/// @nodoc
class _$CustomFoodCopyWithImpl<$Res, $Val extends CustomFood>
    implements $CustomFoodCopyWith<$Res> {
  _$CustomFoodCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CustomFood
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? uid = null,
    Object? nameTr = null,
    Object? nameEn = null,
    Object? barcode = freezed,
    Object? cal = null,
    Object? protein = null,
    Object? carb = null,
    Object? fat = null,
    Object? fiber = freezed,
    Object? sodium = freezed,
    Object? sugar = freezed,
    Object? lastUpdatedAt = null,
    Object? isDeleted = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      nameTr: null == nameTr
          ? _value.nameTr
          : nameTr // ignore: cast_nullable_to_non_nullable
              as String,
      nameEn: null == nameEn
          ? _value.nameEn
          : nameEn // ignore: cast_nullable_to_non_nullable
              as String,
      barcode: freezed == barcode
          ? _value.barcode
          : barcode // ignore: cast_nullable_to_non_nullable
              as String?,
      cal: null == cal
          ? _value.cal
          : cal // ignore: cast_nullable_to_non_nullable
              as double,
      protein: null == protein
          ? _value.protein
          : protein // ignore: cast_nullable_to_non_nullable
              as double,
      carb: null == carb
          ? _value.carb
          : carb // ignore: cast_nullable_to_non_nullable
              as double,
      fat: null == fat
          ? _value.fat
          : fat // ignore: cast_nullable_to_non_nullable
              as double,
      fiber: freezed == fiber
          ? _value.fiber
          : fiber // ignore: cast_nullable_to_non_nullable
              as double?,
      sodium: freezed == sodium
          ? _value.sodium
          : sodium // ignore: cast_nullable_to_non_nullable
              as double?,
      sugar: freezed == sugar
          ? _value.sugar
          : sugar // ignore: cast_nullable_to_non_nullable
              as double?,
      lastUpdatedAt: null == lastUpdatedAt
          ? _value.lastUpdatedAt
          : lastUpdatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isDeleted: null == isDeleted
          ? _value.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CustomFoodImplCopyWith<$Res>
    implements $CustomFoodCopyWith<$Res> {
  factory _$$CustomFoodImplCopyWith(
          _$CustomFoodImpl value, $Res Function(_$CustomFoodImpl) then) =
      __$$CustomFoodImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String uid,
      String nameTr,
      String nameEn,
      String? barcode,
      double cal,
      double protein,
      double carb,
      double fat,
      double? fiber,
      double? sodium,
      double? sugar,
      @DateTimeMillisConverter() DateTime lastUpdatedAt,
      bool isDeleted});
}

/// @nodoc
class __$$CustomFoodImplCopyWithImpl<$Res>
    extends _$CustomFoodCopyWithImpl<$Res, _$CustomFoodImpl>
    implements _$$CustomFoodImplCopyWith<$Res> {
  __$$CustomFoodImplCopyWithImpl(
      _$CustomFoodImpl _value, $Res Function(_$CustomFoodImpl) _then)
      : super(_value, _then);

  /// Create a copy of CustomFood
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? uid = null,
    Object? nameTr = null,
    Object? nameEn = null,
    Object? barcode = freezed,
    Object? cal = null,
    Object? protein = null,
    Object? carb = null,
    Object? fat = null,
    Object? fiber = freezed,
    Object? sodium = freezed,
    Object? sugar = freezed,
    Object? lastUpdatedAt = null,
    Object? isDeleted = null,
  }) {
    return _then(_$CustomFoodImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      nameTr: null == nameTr
          ? _value.nameTr
          : nameTr // ignore: cast_nullable_to_non_nullable
              as String,
      nameEn: null == nameEn
          ? _value.nameEn
          : nameEn // ignore: cast_nullable_to_non_nullable
              as String,
      barcode: freezed == barcode
          ? _value.barcode
          : barcode // ignore: cast_nullable_to_non_nullable
              as String?,
      cal: null == cal
          ? _value.cal
          : cal // ignore: cast_nullable_to_non_nullable
              as double,
      protein: null == protein
          ? _value.protein
          : protein // ignore: cast_nullable_to_non_nullable
              as double,
      carb: null == carb
          ? _value.carb
          : carb // ignore: cast_nullable_to_non_nullable
              as double,
      fat: null == fat
          ? _value.fat
          : fat // ignore: cast_nullable_to_non_nullable
              as double,
      fiber: freezed == fiber
          ? _value.fiber
          : fiber // ignore: cast_nullable_to_non_nullable
              as double?,
      sodium: freezed == sodium
          ? _value.sodium
          : sodium // ignore: cast_nullable_to_non_nullable
              as double?,
      sugar: freezed == sugar
          ? _value.sugar
          : sugar // ignore: cast_nullable_to_non_nullable
              as double?,
      lastUpdatedAt: null == lastUpdatedAt
          ? _value.lastUpdatedAt
          : lastUpdatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isDeleted: null == isDeleted
          ? _value.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CustomFoodImpl implements _CustomFood {
  const _$CustomFoodImpl(
      {required this.id,
      required this.uid,
      required this.nameTr,
      required this.nameEn,
      this.barcode,
      required this.cal,
      required this.protein,
      required this.carb,
      required this.fat,
      this.fiber,
      this.sodium,
      this.sugar,
      @DateTimeMillisConverter() required this.lastUpdatedAt,
      this.isDeleted = false});

  factory _$CustomFoodImpl.fromJson(Map<String, dynamic> json) =>
      _$$CustomFoodImplFromJson(json);

  @override
  final String id;
  @override
  final String uid;
  @override
  final String nameTr;
  @override
  final String nameEn;
  @override
  final String? barcode;
  @override
  final double cal;
  @override
  final double protein;
  @override
  final double carb;
  @override
  final double fat;
  @override
  final double? fiber;
  @override
  final double? sodium;
  @override
  final double? sugar;
  @override
  @DateTimeMillisConverter()
  final DateTime lastUpdatedAt;
  @override
  @JsonKey()
  final bool isDeleted;

  @override
  String toString() {
    return 'CustomFood(id: $id, uid: $uid, nameTr: $nameTr, nameEn: $nameEn, barcode: $barcode, cal: $cal, protein: $protein, carb: $carb, fat: $fat, fiber: $fiber, sodium: $sodium, sugar: $sugar, lastUpdatedAt: $lastUpdatedAt, isDeleted: $isDeleted)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomFoodImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.nameTr, nameTr) || other.nameTr == nameTr) &&
            (identical(other.nameEn, nameEn) || other.nameEn == nameEn) &&
            (identical(other.barcode, barcode) || other.barcode == barcode) &&
            (identical(other.cal, cal) || other.cal == cal) &&
            (identical(other.protein, protein) || other.protein == protein) &&
            (identical(other.carb, carb) || other.carb == carb) &&
            (identical(other.fat, fat) || other.fat == fat) &&
            (identical(other.fiber, fiber) || other.fiber == fiber) &&
            (identical(other.sodium, sodium) || other.sodium == sodium) &&
            (identical(other.sugar, sugar) || other.sugar == sugar) &&
            (identical(other.lastUpdatedAt, lastUpdatedAt) ||
                other.lastUpdatedAt == lastUpdatedAt) &&
            (identical(other.isDeleted, isDeleted) ||
                other.isDeleted == isDeleted));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, uid, nameTr, nameEn, barcode,
      cal, protein, carb, fat, fiber, sodium, sugar, lastUpdatedAt, isDeleted);

  /// Create a copy of CustomFood
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomFoodImplCopyWith<_$CustomFoodImpl> get copyWith =>
      __$$CustomFoodImplCopyWithImpl<_$CustomFoodImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CustomFoodImplToJson(
      this,
    );
  }
}

abstract class _CustomFood implements CustomFood {
  const factory _CustomFood(
      {required final String id,
      required final String uid,
      required final String nameTr,
      required final String nameEn,
      final String? barcode,
      required final double cal,
      required final double protein,
      required final double carb,
      required final double fat,
      final double? fiber,
      final double? sodium,
      final double? sugar,
      @DateTimeMillisConverter() required final DateTime lastUpdatedAt,
      final bool isDeleted}) = _$CustomFoodImpl;

  factory _CustomFood.fromJson(Map<String, dynamic> json) =
      _$CustomFoodImpl.fromJson;

  @override
  String get id;
  @override
  String get uid;
  @override
  String get nameTr;
  @override
  String get nameEn;
  @override
  String? get barcode;
  @override
  double get cal;
  @override
  double get protein;
  @override
  double get carb;
  @override
  double get fat;
  @override
  double? get fiber;
  @override
  double? get sodium;
  @override
  double? get sugar;
  @override
  @DateTimeMillisConverter()
  DateTime get lastUpdatedAt;
  @override
  bool get isDeleted;

  /// Create a copy of CustomFood
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CustomFoodImplCopyWith<_$CustomFoodImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FastingSession _$FastingSessionFromJson(Map<String, dynamic> json) {
  return _FastingSession.fromJson(json);
}

/// @nodoc
mixin _$FastingSession {
  String get id => throw _privateConstructorUsedError;
  String get uid => throw _privateConstructorUsedError;
  @DateTimeMillisConverter()
  DateTime get start => throw _privateConstructorUsedError;
  @DateTimeMillisConverter()
  DateTime? get end => throw _privateConstructorUsedError;
  FastingPlanType get planType => throw _privateConstructorUsedError;
  int get goalHours => throw _privateConstructorUsedError;
  bool get completed => throw _privateConstructorUsedError;
  @DateTimeMillisConverter()
  DateTime get lastUpdatedAt => throw _privateConstructorUsedError;
  bool get isDeleted => throw _privateConstructorUsedError;

  /// Serializes this FastingSession to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FastingSession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FastingSessionCopyWith<FastingSession> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FastingSessionCopyWith<$Res> {
  factory $FastingSessionCopyWith(
          FastingSession value, $Res Function(FastingSession) then) =
      _$FastingSessionCopyWithImpl<$Res, FastingSession>;
  @useResult
  $Res call(
      {String id,
      String uid,
      @DateTimeMillisConverter() DateTime start,
      @DateTimeMillisConverter() DateTime? end,
      FastingPlanType planType,
      int goalHours,
      bool completed,
      @DateTimeMillisConverter() DateTime lastUpdatedAt,
      bool isDeleted});
}

/// @nodoc
class _$FastingSessionCopyWithImpl<$Res, $Val extends FastingSession>
    implements $FastingSessionCopyWith<$Res> {
  _$FastingSessionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FastingSession
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? uid = null,
    Object? start = null,
    Object? end = freezed,
    Object? planType = null,
    Object? goalHours = null,
    Object? completed = null,
    Object? lastUpdatedAt = null,
    Object? isDeleted = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as DateTime,
      end: freezed == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      planType: null == planType
          ? _value.planType
          : planType // ignore: cast_nullable_to_non_nullable
              as FastingPlanType,
      goalHours: null == goalHours
          ? _value.goalHours
          : goalHours // ignore: cast_nullable_to_non_nullable
              as int,
      completed: null == completed
          ? _value.completed
          : completed // ignore: cast_nullable_to_non_nullable
              as bool,
      lastUpdatedAt: null == lastUpdatedAt
          ? _value.lastUpdatedAt
          : lastUpdatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isDeleted: null == isDeleted
          ? _value.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FastingSessionImplCopyWith<$Res>
    implements $FastingSessionCopyWith<$Res> {
  factory _$$FastingSessionImplCopyWith(_$FastingSessionImpl value,
          $Res Function(_$FastingSessionImpl) then) =
      __$$FastingSessionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String uid,
      @DateTimeMillisConverter() DateTime start,
      @DateTimeMillisConverter() DateTime? end,
      FastingPlanType planType,
      int goalHours,
      bool completed,
      @DateTimeMillisConverter() DateTime lastUpdatedAt,
      bool isDeleted});
}

/// @nodoc
class __$$FastingSessionImplCopyWithImpl<$Res>
    extends _$FastingSessionCopyWithImpl<$Res, _$FastingSessionImpl>
    implements _$$FastingSessionImplCopyWith<$Res> {
  __$$FastingSessionImplCopyWithImpl(
      _$FastingSessionImpl _value, $Res Function(_$FastingSessionImpl) _then)
      : super(_value, _then);

  /// Create a copy of FastingSession
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? uid = null,
    Object? start = null,
    Object? end = freezed,
    Object? planType = null,
    Object? goalHours = null,
    Object? completed = null,
    Object? lastUpdatedAt = null,
    Object? isDeleted = null,
  }) {
    return _then(_$FastingSessionImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      start: null == start
          ? _value.start
          : start // ignore: cast_nullable_to_non_nullable
              as DateTime,
      end: freezed == end
          ? _value.end
          : end // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      planType: null == planType
          ? _value.planType
          : planType // ignore: cast_nullable_to_non_nullable
              as FastingPlanType,
      goalHours: null == goalHours
          ? _value.goalHours
          : goalHours // ignore: cast_nullable_to_non_nullable
              as int,
      completed: null == completed
          ? _value.completed
          : completed // ignore: cast_nullable_to_non_nullable
              as bool,
      lastUpdatedAt: null == lastUpdatedAt
          ? _value.lastUpdatedAt
          : lastUpdatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isDeleted: null == isDeleted
          ? _value.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FastingSessionImpl implements _FastingSession {
  const _$FastingSessionImpl(
      {required this.id,
      required this.uid,
      @DateTimeMillisConverter() required this.start,
      @DateTimeMillisConverter() this.end,
      required this.planType,
      required this.goalHours,
      required this.completed,
      @DateTimeMillisConverter() required this.lastUpdatedAt,
      this.isDeleted = false});

  factory _$FastingSessionImpl.fromJson(Map<String, dynamic> json) =>
      _$$FastingSessionImplFromJson(json);

  @override
  final String id;
  @override
  final String uid;
  @override
  @DateTimeMillisConverter()
  final DateTime start;
  @override
  @DateTimeMillisConverter()
  final DateTime? end;
  @override
  final FastingPlanType planType;
  @override
  final int goalHours;
  @override
  final bool completed;
  @override
  @DateTimeMillisConverter()
  final DateTime lastUpdatedAt;
  @override
  @JsonKey()
  final bool isDeleted;

  @override
  String toString() {
    return 'FastingSession(id: $id, uid: $uid, start: $start, end: $end, planType: $planType, goalHours: $goalHours, completed: $completed, lastUpdatedAt: $lastUpdatedAt, isDeleted: $isDeleted)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FastingSessionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.start, start) || other.start == start) &&
            (identical(other.end, end) || other.end == end) &&
            (identical(other.planType, planType) ||
                other.planType == planType) &&
            (identical(other.goalHours, goalHours) ||
                other.goalHours == goalHours) &&
            (identical(other.completed, completed) ||
                other.completed == completed) &&
            (identical(other.lastUpdatedAt, lastUpdatedAt) ||
                other.lastUpdatedAt == lastUpdatedAt) &&
            (identical(other.isDeleted, isDeleted) ||
                other.isDeleted == isDeleted));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, uid, start, end, planType,
      goalHours, completed, lastUpdatedAt, isDeleted);

  /// Create a copy of FastingSession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FastingSessionImplCopyWith<_$FastingSessionImpl> get copyWith =>
      __$$FastingSessionImplCopyWithImpl<_$FastingSessionImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FastingSessionImplToJson(
      this,
    );
  }
}

abstract class _FastingSession implements FastingSession {
  const factory _FastingSession(
      {required final String id,
      required final String uid,
      @DateTimeMillisConverter() required final DateTime start,
      @DateTimeMillisConverter() final DateTime? end,
      required final FastingPlanType planType,
      required final int goalHours,
      required final bool completed,
      @DateTimeMillisConverter() required final DateTime lastUpdatedAt,
      final bool isDeleted}) = _$FastingSessionImpl;

  factory _FastingSession.fromJson(Map<String, dynamic> json) =
      _$FastingSessionImpl.fromJson;

  @override
  String get id;
  @override
  String get uid;
  @override
  @DateTimeMillisConverter()
  DateTime get start;
  @override
  @DateTimeMillisConverter()
  DateTime? get end;
  @override
  FastingPlanType get planType;
  @override
  int get goalHours;
  @override
  bool get completed;
  @override
  @DateTimeMillisConverter()
  DateTime get lastUpdatedAt;
  @override
  bool get isDeleted;

  /// Create a copy of FastingSession
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FastingSessionImplCopyWith<_$FastingSessionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ActivityEntry _$ActivityEntryFromJson(Map<String, dynamic> json) {
  return _ActivityEntry.fromJson(json);
}

/// @nodoc
mixin _$ActivityEntry {
  String get id => throw _privateConstructorUsedError;
  String get uid => throw _privateConstructorUsedError;
  @DateTimeMillisConverter()
  DateTime get dateTime => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  int get durationMin => throw _privateConstructorUsedError;
  double get calories => throw _privateConstructorUsedError;
  int? get steps => throw _privateConstructorUsedError;
  ActivitySource get source => throw _privateConstructorUsedError;
  @DateTimeMillisConverter()
  DateTime get lastUpdatedAt => throw _privateConstructorUsedError;
  bool get isDeleted => throw _privateConstructorUsedError;

  /// Serializes this ActivityEntry to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ActivityEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ActivityEntryCopyWith<ActivityEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ActivityEntryCopyWith<$Res> {
  factory $ActivityEntryCopyWith(
          ActivityEntry value, $Res Function(ActivityEntry) then) =
      _$ActivityEntryCopyWithImpl<$Res, ActivityEntry>;
  @useResult
  $Res call(
      {String id,
      String uid,
      @DateTimeMillisConverter() DateTime dateTime,
      String type,
      int durationMin,
      double calories,
      int? steps,
      ActivitySource source,
      @DateTimeMillisConverter() DateTime lastUpdatedAt,
      bool isDeleted});
}

/// @nodoc
class _$ActivityEntryCopyWithImpl<$Res, $Val extends ActivityEntry>
    implements $ActivityEntryCopyWith<$Res> {
  _$ActivityEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ActivityEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? uid = null,
    Object? dateTime = null,
    Object? type = null,
    Object? durationMin = null,
    Object? calories = null,
    Object? steps = freezed,
    Object? source = null,
    Object? lastUpdatedAt = null,
    Object? isDeleted = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      dateTime: null == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      durationMin: null == durationMin
          ? _value.durationMin
          : durationMin // ignore: cast_nullable_to_non_nullable
              as int,
      calories: null == calories
          ? _value.calories
          : calories // ignore: cast_nullable_to_non_nullable
              as double,
      steps: freezed == steps
          ? _value.steps
          : steps // ignore: cast_nullable_to_non_nullable
              as int?,
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as ActivitySource,
      lastUpdatedAt: null == lastUpdatedAt
          ? _value.lastUpdatedAt
          : lastUpdatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isDeleted: null == isDeleted
          ? _value.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ActivityEntryImplCopyWith<$Res>
    implements $ActivityEntryCopyWith<$Res> {
  factory _$$ActivityEntryImplCopyWith(
          _$ActivityEntryImpl value, $Res Function(_$ActivityEntryImpl) then) =
      __$$ActivityEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String uid,
      @DateTimeMillisConverter() DateTime dateTime,
      String type,
      int durationMin,
      double calories,
      int? steps,
      ActivitySource source,
      @DateTimeMillisConverter() DateTime lastUpdatedAt,
      bool isDeleted});
}

/// @nodoc
class __$$ActivityEntryImplCopyWithImpl<$Res>
    extends _$ActivityEntryCopyWithImpl<$Res, _$ActivityEntryImpl>
    implements _$$ActivityEntryImplCopyWith<$Res> {
  __$$ActivityEntryImplCopyWithImpl(
      _$ActivityEntryImpl _value, $Res Function(_$ActivityEntryImpl) _then)
      : super(_value, _then);

  /// Create a copy of ActivityEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? uid = null,
    Object? dateTime = null,
    Object? type = null,
    Object? durationMin = null,
    Object? calories = null,
    Object? steps = freezed,
    Object? source = null,
    Object? lastUpdatedAt = null,
    Object? isDeleted = null,
  }) {
    return _then(_$ActivityEntryImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      dateTime: null == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      durationMin: null == durationMin
          ? _value.durationMin
          : durationMin // ignore: cast_nullable_to_non_nullable
              as int,
      calories: null == calories
          ? _value.calories
          : calories // ignore: cast_nullable_to_non_nullable
              as double,
      steps: freezed == steps
          ? _value.steps
          : steps // ignore: cast_nullable_to_non_nullable
              as int?,
      source: null == source
          ? _value.source
          : source // ignore: cast_nullable_to_non_nullable
              as ActivitySource,
      lastUpdatedAt: null == lastUpdatedAt
          ? _value.lastUpdatedAt
          : lastUpdatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isDeleted: null == isDeleted
          ? _value.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ActivityEntryImpl implements _ActivityEntry {
  const _$ActivityEntryImpl(
      {required this.id,
      required this.uid,
      @DateTimeMillisConverter() required this.dateTime,
      required this.type,
      required this.durationMin,
      required this.calories,
      this.steps,
      required this.source,
      @DateTimeMillisConverter() required this.lastUpdatedAt,
      this.isDeleted = false});

  factory _$ActivityEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$ActivityEntryImplFromJson(json);

  @override
  final String id;
  @override
  final String uid;
  @override
  @DateTimeMillisConverter()
  final DateTime dateTime;
  @override
  final String type;
  @override
  final int durationMin;
  @override
  final double calories;
  @override
  final int? steps;
  @override
  final ActivitySource source;
  @override
  @DateTimeMillisConverter()
  final DateTime lastUpdatedAt;
  @override
  @JsonKey()
  final bool isDeleted;

  @override
  String toString() {
    return 'ActivityEntry(id: $id, uid: $uid, dateTime: $dateTime, type: $type, durationMin: $durationMin, calories: $calories, steps: $steps, source: $source, lastUpdatedAt: $lastUpdatedAt, isDeleted: $isDeleted)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ActivityEntryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.dateTime, dateTime) ||
                other.dateTime == dateTime) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.durationMin, durationMin) ||
                other.durationMin == durationMin) &&
            (identical(other.calories, calories) ||
                other.calories == calories) &&
            (identical(other.steps, steps) || other.steps == steps) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.lastUpdatedAt, lastUpdatedAt) ||
                other.lastUpdatedAt == lastUpdatedAt) &&
            (identical(other.isDeleted, isDeleted) ||
                other.isDeleted == isDeleted));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, uid, dateTime, type,
      durationMin, calories, steps, source, lastUpdatedAt, isDeleted);

  /// Create a copy of ActivityEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ActivityEntryImplCopyWith<_$ActivityEntryImpl> get copyWith =>
      __$$ActivityEntryImplCopyWithImpl<_$ActivityEntryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ActivityEntryImplToJson(
      this,
    );
  }
}

abstract class _ActivityEntry implements ActivityEntry {
  const factory _ActivityEntry(
      {required final String id,
      required final String uid,
      @DateTimeMillisConverter() required final DateTime dateTime,
      required final String type,
      required final int durationMin,
      required final double calories,
      final int? steps,
      required final ActivitySource source,
      @DateTimeMillisConverter() required final DateTime lastUpdatedAt,
      final bool isDeleted}) = _$ActivityEntryImpl;

  factory _ActivityEntry.fromJson(Map<String, dynamic> json) =
      _$ActivityEntryImpl.fromJson;

  @override
  String get id;
  @override
  String get uid;
  @override
  @DateTimeMillisConverter()
  DateTime get dateTime;
  @override
  String get type;
  @override
  int get durationMin;
  @override
  double get calories;
  @override
  int? get steps;
  @override
  ActivitySource get source;
  @override
  @DateTimeMillisConverter()
  DateTime get lastUpdatedAt;
  @override
  bool get isDeleted;

  /// Create a copy of ActivityEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ActivityEntryImplCopyWith<_$ActivityEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PhotoEntry _$PhotoEntryFromJson(Map<String, dynamic> json) {
  return _PhotoEntry.fromJson(json);
}

/// @nodoc
mixin _$PhotoEntry {
  String get id => throw _privateConstructorUsedError;
  String get uid => throw _privateConstructorUsedError;
  @DateTimeMillisConverter()
  DateTime get date => throw _privateConstructorUsedError;
  PhotoType get type => throw _privateConstructorUsedError;
  String? get storageUrl => throw _privateConstructorUsedError;
  String? get localPath => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  @DateTimeMillisConverter()
  DateTime get lastUpdatedAt => throw _privateConstructorUsedError;
  bool get isDeleted => throw _privateConstructorUsedError;

  /// Serializes this PhotoEntry to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PhotoEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PhotoEntryCopyWith<PhotoEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PhotoEntryCopyWith<$Res> {
  factory $PhotoEntryCopyWith(
          PhotoEntry value, $Res Function(PhotoEntry) then) =
      _$PhotoEntryCopyWithImpl<$Res, PhotoEntry>;
  @useResult
  $Res call(
      {String id,
      String uid,
      @DateTimeMillisConverter() DateTime date,
      PhotoType type,
      String? storageUrl,
      String? localPath,
      String? notes,
      @DateTimeMillisConverter() DateTime lastUpdatedAt,
      bool isDeleted});
}

/// @nodoc
class _$PhotoEntryCopyWithImpl<$Res, $Val extends PhotoEntry>
    implements $PhotoEntryCopyWith<$Res> {
  _$PhotoEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PhotoEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? uid = null,
    Object? date = null,
    Object? type = null,
    Object? storageUrl = freezed,
    Object? localPath = freezed,
    Object? notes = freezed,
    Object? lastUpdatedAt = null,
    Object? isDeleted = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as PhotoType,
      storageUrl: freezed == storageUrl
          ? _value.storageUrl
          : storageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      localPath: freezed == localPath
          ? _value.localPath
          : localPath // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      lastUpdatedAt: null == lastUpdatedAt
          ? _value.lastUpdatedAt
          : lastUpdatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isDeleted: null == isDeleted
          ? _value.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PhotoEntryImplCopyWith<$Res>
    implements $PhotoEntryCopyWith<$Res> {
  factory _$$PhotoEntryImplCopyWith(
          _$PhotoEntryImpl value, $Res Function(_$PhotoEntryImpl) then) =
      __$$PhotoEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String uid,
      @DateTimeMillisConverter() DateTime date,
      PhotoType type,
      String? storageUrl,
      String? localPath,
      String? notes,
      @DateTimeMillisConverter() DateTime lastUpdatedAt,
      bool isDeleted});
}

/// @nodoc
class __$$PhotoEntryImplCopyWithImpl<$Res>
    extends _$PhotoEntryCopyWithImpl<$Res, _$PhotoEntryImpl>
    implements _$$PhotoEntryImplCopyWith<$Res> {
  __$$PhotoEntryImplCopyWithImpl(
      _$PhotoEntryImpl _value, $Res Function(_$PhotoEntryImpl) _then)
      : super(_value, _then);

  /// Create a copy of PhotoEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? uid = null,
    Object? date = null,
    Object? type = null,
    Object? storageUrl = freezed,
    Object? localPath = freezed,
    Object? notes = freezed,
    Object? lastUpdatedAt = null,
    Object? isDeleted = null,
  }) {
    return _then(_$PhotoEntryImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as PhotoType,
      storageUrl: freezed == storageUrl
          ? _value.storageUrl
          : storageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      localPath: freezed == localPath
          ? _value.localPath
          : localPath // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      lastUpdatedAt: null == lastUpdatedAt
          ? _value.lastUpdatedAt
          : lastUpdatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      isDeleted: null == isDeleted
          ? _value.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PhotoEntryImpl implements _PhotoEntry {
  const _$PhotoEntryImpl(
      {required this.id,
      required this.uid,
      @DateTimeMillisConverter() required this.date,
      required this.type,
      this.storageUrl,
      this.localPath,
      this.notes,
      @DateTimeMillisConverter() required this.lastUpdatedAt,
      this.isDeleted = false});

  factory _$PhotoEntryImpl.fromJson(Map<String, dynamic> json) =>
      _$$PhotoEntryImplFromJson(json);

  @override
  final String id;
  @override
  final String uid;
  @override
  @DateTimeMillisConverter()
  final DateTime date;
  @override
  final PhotoType type;
  @override
  final String? storageUrl;
  @override
  final String? localPath;
  @override
  final String? notes;
  @override
  @DateTimeMillisConverter()
  final DateTime lastUpdatedAt;
  @override
  @JsonKey()
  final bool isDeleted;

  @override
  String toString() {
    return 'PhotoEntry(id: $id, uid: $uid, date: $date, type: $type, storageUrl: $storageUrl, localPath: $localPath, notes: $notes, lastUpdatedAt: $lastUpdatedAt, isDeleted: $isDeleted)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PhotoEntryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.storageUrl, storageUrl) ||
                other.storageUrl == storageUrl) &&
            (identical(other.localPath, localPath) ||
                other.localPath == localPath) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.lastUpdatedAt, lastUpdatedAt) ||
                other.lastUpdatedAt == lastUpdatedAt) &&
            (identical(other.isDeleted, isDeleted) ||
                other.isDeleted == isDeleted));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, uid, date, type, storageUrl,
      localPath, notes, lastUpdatedAt, isDeleted);

  /// Create a copy of PhotoEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PhotoEntryImplCopyWith<_$PhotoEntryImpl> get copyWith =>
      __$$PhotoEntryImplCopyWithImpl<_$PhotoEntryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PhotoEntryImplToJson(
      this,
    );
  }
}

abstract class _PhotoEntry implements PhotoEntry {
  const factory _PhotoEntry(
      {required final String id,
      required final String uid,
      @DateTimeMillisConverter() required final DateTime date,
      required final PhotoType type,
      final String? storageUrl,
      final String? localPath,
      final String? notes,
      @DateTimeMillisConverter() required final DateTime lastUpdatedAt,
      final bool isDeleted}) = _$PhotoEntryImpl;

  factory _PhotoEntry.fromJson(Map<String, dynamic> json) =
      _$PhotoEntryImpl.fromJson;

  @override
  String get id;
  @override
  String get uid;
  @override
  @DateTimeMillisConverter()
  DateTime get date;
  @override
  PhotoType get type;
  @override
  String? get storageUrl;
  @override
  String? get localPath;
  @override
  String? get notes;
  @override
  @DateTimeMillisConverter()
  DateTime get lastUpdatedAt;
  @override
  bool get isDeleted;

  /// Create a copy of PhotoEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PhotoEntryImplCopyWith<_$PhotoEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SyncLog _$SyncLogFromJson(Map<String, dynamic> json) {
  return _SyncLog.fromJson(json);
}

/// @nodoc
mixin _$SyncLog {
  String get id => throw _privateConstructorUsedError;
  String get uid => throw _privateConstructorUsedError;
  String get entityType => throw _privateConstructorUsedError;
  String get entityId => throw _privateConstructorUsedError;
  String? get conflictInfo => throw _privateConstructorUsedError;
  @DateTimeMillisConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this SyncLog to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SyncLog
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SyncLogCopyWith<SyncLog> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SyncLogCopyWith<$Res> {
  factory $SyncLogCopyWith(SyncLog value, $Res Function(SyncLog) then) =
      _$SyncLogCopyWithImpl<$Res, SyncLog>;
  @useResult
  $Res call(
      {String id,
      String uid,
      String entityType,
      String entityId,
      String? conflictInfo,
      @DateTimeMillisConverter() DateTime createdAt});
}

/// @nodoc
class _$SyncLogCopyWithImpl<$Res, $Val extends SyncLog>
    implements $SyncLogCopyWith<$Res> {
  _$SyncLogCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SyncLog
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? uid = null,
    Object? entityType = null,
    Object? entityId = null,
    Object? conflictInfo = freezed,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      entityType: null == entityType
          ? _value.entityType
          : entityType // ignore: cast_nullable_to_non_nullable
              as String,
      entityId: null == entityId
          ? _value.entityId
          : entityId // ignore: cast_nullable_to_non_nullable
              as String,
      conflictInfo: freezed == conflictInfo
          ? _value.conflictInfo
          : conflictInfo // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SyncLogImplCopyWith<$Res> implements $SyncLogCopyWith<$Res> {
  factory _$$SyncLogImplCopyWith(
          _$SyncLogImpl value, $Res Function(_$SyncLogImpl) then) =
      __$$SyncLogImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String uid,
      String entityType,
      String entityId,
      String? conflictInfo,
      @DateTimeMillisConverter() DateTime createdAt});
}

/// @nodoc
class __$$SyncLogImplCopyWithImpl<$Res>
    extends _$SyncLogCopyWithImpl<$Res, _$SyncLogImpl>
    implements _$$SyncLogImplCopyWith<$Res> {
  __$$SyncLogImplCopyWithImpl(
      _$SyncLogImpl _value, $Res Function(_$SyncLogImpl) _then)
      : super(_value, _then);

  /// Create a copy of SyncLog
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? uid = null,
    Object? entityType = null,
    Object? entityId = null,
    Object? conflictInfo = freezed,
    Object? createdAt = null,
  }) {
    return _then(_$SyncLogImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      entityType: null == entityType
          ? _value.entityType
          : entityType // ignore: cast_nullable_to_non_nullable
              as String,
      entityId: null == entityId
          ? _value.entityId
          : entityId // ignore: cast_nullable_to_non_nullable
              as String,
      conflictInfo: freezed == conflictInfo
          ? _value.conflictInfo
          : conflictInfo // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SyncLogImpl implements _SyncLog {
  const _$SyncLogImpl(
      {required this.id,
      required this.uid,
      required this.entityType,
      required this.entityId,
      this.conflictInfo,
      @DateTimeMillisConverter() required this.createdAt});

  factory _$SyncLogImpl.fromJson(Map<String, dynamic> json) =>
      _$$SyncLogImplFromJson(json);

  @override
  final String id;
  @override
  final String uid;
  @override
  final String entityType;
  @override
  final String entityId;
  @override
  final String? conflictInfo;
  @override
  @DateTimeMillisConverter()
  final DateTime createdAt;

  @override
  String toString() {
    return 'SyncLog(id: $id, uid: $uid, entityType: $entityType, entityId: $entityId, conflictInfo: $conflictInfo, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SyncLogImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.entityType, entityType) ||
                other.entityType == entityType) &&
            (identical(other.entityId, entityId) ||
                other.entityId == entityId) &&
            (identical(other.conflictInfo, conflictInfo) ||
                other.conflictInfo == conflictInfo) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, uid, entityType, entityId, conflictInfo, createdAt);

  /// Create a copy of SyncLog
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SyncLogImplCopyWith<_$SyncLogImpl> get copyWith =>
      __$$SyncLogImplCopyWithImpl<_$SyncLogImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SyncLogImplToJson(
      this,
    );
  }
}

abstract class _SyncLog implements SyncLog {
  const factory _SyncLog(
          {required final String id,
          required final String uid,
          required final String entityType,
          required final String entityId,
          final String? conflictInfo,
          @DateTimeMillisConverter() required final DateTime createdAt}) =
      _$SyncLogImpl;

  factory _SyncLog.fromJson(Map<String, dynamic> json) = _$SyncLogImpl.fromJson;

  @override
  String get id;
  @override
  String get uid;
  @override
  String get entityType;
  @override
  String get entityId;
  @override
  String? get conflictInfo;
  @override
  @DateTimeMillisConverter()
  DateTime get createdAt;

  /// Create a copy of SyncLog
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SyncLogImplCopyWith<_$SyncLogImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
