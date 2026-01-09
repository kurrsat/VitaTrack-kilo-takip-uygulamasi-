// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $UserProfilesTable extends UserProfiles
    with TableInfo<$UserProfilesTable, UserProfileRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _uidMeta = const VerificationMeta('uid');
  @override
  late final GeneratedColumn<String> uid = GeneratedColumn<String>(
      'uid', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _heightCmMeta =
      const VerificationMeta('heightCm');
  @override
  late final GeneratedColumn<double> heightCm = GeneratedColumn<double>(
      'height_cm', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _birthYearMeta =
      const VerificationMeta('birthYear');
  @override
  late final GeneratedColumn<int> birthYear = GeneratedColumn<int>(
      'birth_year', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _genderMeta = const VerificationMeta('gender');
  @override
  late final GeneratedColumn<String> gender = GeneratedColumn<String>(
      'gender', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _unitsMeta = const VerificationMeta('units');
  @override
  late final GeneratedColumnWithTypeConverter<UnitsSystem, String> units =
      GeneratedColumn<String>('units', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<UnitsSystem>($UserProfilesTable.$converterunits);
  static const VerificationMeta _goalTypeMeta =
      const VerificationMeta('goalType');
  @override
  late final GeneratedColumnWithTypeConverter<GoalType, String> goalType =
      GeneratedColumn<String>('goal_type', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<GoalType>($UserProfilesTable.$convertergoalType);
  static const VerificationMeta _goalWeightMeta =
      const VerificationMeta('goalWeight');
  @override
  late final GeneratedColumn<double> goalWeight = GeneratedColumn<double>(
      'goal_weight', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _goalDateMeta =
      const VerificationMeta('goalDate');
  @override
  late final GeneratedColumn<int> goalDate = GeneratedColumn<int>(
      'goal_date', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _tdeeTargetMeta =
      const VerificationMeta('tdeeTarget');
  @override
  late final GeneratedColumn<double> tdeeTarget = GeneratedColumn<double>(
      'tdee_target', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _adaptiveGoalsEnabledMeta =
      const VerificationMeta('adaptiveGoalsEnabled');
  @override
  late final GeneratedColumn<bool> adaptiveGoalsEnabled = GeneratedColumn<bool>(
      'adaptive_goals_enabled', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("adaptive_goals_enabled" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _lastUpdatedAtMeta =
      const VerificationMeta('lastUpdatedAt');
  @override
  late final GeneratedColumn<int> lastUpdatedAt = GeneratedColumn<int>(
      'last_updated_at', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
      'created_at', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _isDirtyMeta =
      const VerificationMeta('isDirty');
  @override
  late final GeneratedColumn<bool> isDirty = GeneratedColumn<bool>(
      'is_dirty', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_dirty" IN (0, 1))'),
      defaultValue: const Constant(true));
  @override
  List<GeneratedColumn> get $columns => [
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
        createdAt,
        isDirty
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_profiles';
  @override
  VerificationContext validateIntegrity(Insertable<UserProfileRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('uid')) {
      context.handle(
          _uidMeta, uid.isAcceptableOrUnknown(data['uid']!, _uidMeta));
    } else if (isInserting) {
      context.missing(_uidMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('height_cm')) {
      context.handle(_heightCmMeta,
          heightCm.isAcceptableOrUnknown(data['height_cm']!, _heightCmMeta));
    } else if (isInserting) {
      context.missing(_heightCmMeta);
    }
    if (data.containsKey('birth_year')) {
      context.handle(_birthYearMeta,
          birthYear.isAcceptableOrUnknown(data['birth_year']!, _birthYearMeta));
    }
    if (data.containsKey('gender')) {
      context.handle(_genderMeta,
          gender.isAcceptableOrUnknown(data['gender']!, _genderMeta));
    }
    context.handle(_unitsMeta, const VerificationResult.success());
    context.handle(_goalTypeMeta, const VerificationResult.success());
    if (data.containsKey('goal_weight')) {
      context.handle(
          _goalWeightMeta,
          goalWeight.isAcceptableOrUnknown(
              data['goal_weight']!, _goalWeightMeta));
    } else if (isInserting) {
      context.missing(_goalWeightMeta);
    }
    if (data.containsKey('goal_date')) {
      context.handle(_goalDateMeta,
          goalDate.isAcceptableOrUnknown(data['goal_date']!, _goalDateMeta));
    } else if (isInserting) {
      context.missing(_goalDateMeta);
    }
    if (data.containsKey('tdee_target')) {
      context.handle(
          _tdeeTargetMeta,
          tdeeTarget.isAcceptableOrUnknown(
              data['tdee_target']!, _tdeeTargetMeta));
    }
    if (data.containsKey('adaptive_goals_enabled')) {
      context.handle(
          _adaptiveGoalsEnabledMeta,
          adaptiveGoalsEnabled.isAcceptableOrUnknown(
              data['adaptive_goals_enabled']!, _adaptiveGoalsEnabledMeta));
    }
    if (data.containsKey('last_updated_at')) {
      context.handle(
          _lastUpdatedAtMeta,
          lastUpdatedAt.isAcceptableOrUnknown(
              data['last_updated_at']!, _lastUpdatedAtMeta));
    } else if (isInserting) {
      context.missing(_lastUpdatedAtMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('is_dirty')) {
      context.handle(_isDirtyMeta,
          isDirty.isAcceptableOrUnknown(data['is_dirty']!, _isDirtyMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {uid};
  @override
  UserProfileRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserProfileRow(
      uid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}uid'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      heightCm: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}height_cm'])!,
      birthYear: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}birth_year']),
      gender: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}gender']),
      units: $UserProfilesTable.$converterunits.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}units'])!),
      goalType: $UserProfilesTable.$convertergoalType.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}goal_type'])!),
      goalWeight: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}goal_weight'])!,
      goalDate: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}goal_date'])!,
      tdeeTarget: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}tdee_target']),
      adaptiveGoalsEnabled: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}adaptive_goals_enabled'])!,
      lastUpdatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}last_updated_at'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}created_at'])!,
      isDirty: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_dirty'])!,
    );
  }

  @override
  $UserProfilesTable createAlias(String alias) {
    return $UserProfilesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<UnitsSystem, String, String> $converterunits =
      const EnumNameConverter<UnitsSystem>(UnitsSystem.values);
  static JsonTypeConverter2<GoalType, String, String> $convertergoalType =
      const EnumNameConverter<GoalType>(GoalType.values);
}

class UserProfileRow extends DataClass implements Insertable<UserProfileRow> {
  final String uid;
  final String name;
  final double heightCm;
  final int? birthYear;
  final String? gender;
  final UnitsSystem units;
  final GoalType goalType;
  final double goalWeight;
  final int goalDate;
  final double? tdeeTarget;
  final bool adaptiveGoalsEnabled;
  final int lastUpdatedAt;
  final int createdAt;
  final bool isDirty;
  const UserProfileRow(
      {required this.uid,
      required this.name,
      required this.heightCm,
      this.birthYear,
      this.gender,
      required this.units,
      required this.goalType,
      required this.goalWeight,
      required this.goalDate,
      this.tdeeTarget,
      required this.adaptiveGoalsEnabled,
      required this.lastUpdatedAt,
      required this.createdAt,
      required this.isDirty});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['uid'] = Variable<String>(uid);
    map['name'] = Variable<String>(name);
    map['height_cm'] = Variable<double>(heightCm);
    if (!nullToAbsent || birthYear != null) {
      map['birth_year'] = Variable<int>(birthYear);
    }
    if (!nullToAbsent || gender != null) {
      map['gender'] = Variable<String>(gender);
    }
    {
      map['units'] =
          Variable<String>($UserProfilesTable.$converterunits.toSql(units));
    }
    {
      map['goal_type'] = Variable<String>(
          $UserProfilesTable.$convertergoalType.toSql(goalType));
    }
    map['goal_weight'] = Variable<double>(goalWeight);
    map['goal_date'] = Variable<int>(goalDate);
    if (!nullToAbsent || tdeeTarget != null) {
      map['tdee_target'] = Variable<double>(tdeeTarget);
    }
    map['adaptive_goals_enabled'] = Variable<bool>(adaptiveGoalsEnabled);
    map['last_updated_at'] = Variable<int>(lastUpdatedAt);
    map['created_at'] = Variable<int>(createdAt);
    map['is_dirty'] = Variable<bool>(isDirty);
    return map;
  }

  UserProfilesCompanion toCompanion(bool nullToAbsent) {
    return UserProfilesCompanion(
      uid: Value(uid),
      name: Value(name),
      heightCm: Value(heightCm),
      birthYear: birthYear == null && nullToAbsent
          ? const Value.absent()
          : Value(birthYear),
      gender:
          gender == null && nullToAbsent ? const Value.absent() : Value(gender),
      units: Value(units),
      goalType: Value(goalType),
      goalWeight: Value(goalWeight),
      goalDate: Value(goalDate),
      tdeeTarget: tdeeTarget == null && nullToAbsent
          ? const Value.absent()
          : Value(tdeeTarget),
      adaptiveGoalsEnabled: Value(adaptiveGoalsEnabled),
      lastUpdatedAt: Value(lastUpdatedAt),
      createdAt: Value(createdAt),
      isDirty: Value(isDirty),
    );
  }

  factory UserProfileRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserProfileRow(
      uid: serializer.fromJson<String>(json['uid']),
      name: serializer.fromJson<String>(json['name']),
      heightCm: serializer.fromJson<double>(json['heightCm']),
      birthYear: serializer.fromJson<int?>(json['birthYear']),
      gender: serializer.fromJson<String?>(json['gender']),
      units: $UserProfilesTable.$converterunits
          .fromJson(serializer.fromJson<String>(json['units'])),
      goalType: $UserProfilesTable.$convertergoalType
          .fromJson(serializer.fromJson<String>(json['goalType'])),
      goalWeight: serializer.fromJson<double>(json['goalWeight']),
      goalDate: serializer.fromJson<int>(json['goalDate']),
      tdeeTarget: serializer.fromJson<double?>(json['tdeeTarget']),
      adaptiveGoalsEnabled:
          serializer.fromJson<bool>(json['adaptiveGoalsEnabled']),
      lastUpdatedAt: serializer.fromJson<int>(json['lastUpdatedAt']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      isDirty: serializer.fromJson<bool>(json['isDirty']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'uid': serializer.toJson<String>(uid),
      'name': serializer.toJson<String>(name),
      'heightCm': serializer.toJson<double>(heightCm),
      'birthYear': serializer.toJson<int?>(birthYear),
      'gender': serializer.toJson<String?>(gender),
      'units': serializer
          .toJson<String>($UserProfilesTable.$converterunits.toJson(units)),
      'goalType': serializer.toJson<String>(
          $UserProfilesTable.$convertergoalType.toJson(goalType)),
      'goalWeight': serializer.toJson<double>(goalWeight),
      'goalDate': serializer.toJson<int>(goalDate),
      'tdeeTarget': serializer.toJson<double?>(tdeeTarget),
      'adaptiveGoalsEnabled': serializer.toJson<bool>(adaptiveGoalsEnabled),
      'lastUpdatedAt': serializer.toJson<int>(lastUpdatedAt),
      'createdAt': serializer.toJson<int>(createdAt),
      'isDirty': serializer.toJson<bool>(isDirty),
    };
  }

  UserProfileRow copyWith(
          {String? uid,
          String? name,
          double? heightCm,
          Value<int?> birthYear = const Value.absent(),
          Value<String?> gender = const Value.absent(),
          UnitsSystem? units,
          GoalType? goalType,
          double? goalWeight,
          int? goalDate,
          Value<double?> tdeeTarget = const Value.absent(),
          bool? adaptiveGoalsEnabled,
          int? lastUpdatedAt,
          int? createdAt,
          bool? isDirty}) =>
      UserProfileRow(
        uid: uid ?? this.uid,
        name: name ?? this.name,
        heightCm: heightCm ?? this.heightCm,
        birthYear: birthYear.present ? birthYear.value : this.birthYear,
        gender: gender.present ? gender.value : this.gender,
        units: units ?? this.units,
        goalType: goalType ?? this.goalType,
        goalWeight: goalWeight ?? this.goalWeight,
        goalDate: goalDate ?? this.goalDate,
        tdeeTarget: tdeeTarget.present ? tdeeTarget.value : this.tdeeTarget,
        adaptiveGoalsEnabled: adaptiveGoalsEnabled ?? this.adaptiveGoalsEnabled,
        lastUpdatedAt: lastUpdatedAt ?? this.lastUpdatedAt,
        createdAt: createdAt ?? this.createdAt,
        isDirty: isDirty ?? this.isDirty,
      );
  UserProfileRow copyWithCompanion(UserProfilesCompanion data) {
    return UserProfileRow(
      uid: data.uid.present ? data.uid.value : this.uid,
      name: data.name.present ? data.name.value : this.name,
      heightCm: data.heightCm.present ? data.heightCm.value : this.heightCm,
      birthYear: data.birthYear.present ? data.birthYear.value : this.birthYear,
      gender: data.gender.present ? data.gender.value : this.gender,
      units: data.units.present ? data.units.value : this.units,
      goalType: data.goalType.present ? data.goalType.value : this.goalType,
      goalWeight:
          data.goalWeight.present ? data.goalWeight.value : this.goalWeight,
      goalDate: data.goalDate.present ? data.goalDate.value : this.goalDate,
      tdeeTarget:
          data.tdeeTarget.present ? data.tdeeTarget.value : this.tdeeTarget,
      adaptiveGoalsEnabled: data.adaptiveGoalsEnabled.present
          ? data.adaptiveGoalsEnabled.value
          : this.adaptiveGoalsEnabled,
      lastUpdatedAt: data.lastUpdatedAt.present
          ? data.lastUpdatedAt.value
          : this.lastUpdatedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      isDirty: data.isDirty.present ? data.isDirty.value : this.isDirty,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserProfileRow(')
          ..write('uid: $uid, ')
          ..write('name: $name, ')
          ..write('heightCm: $heightCm, ')
          ..write('birthYear: $birthYear, ')
          ..write('gender: $gender, ')
          ..write('units: $units, ')
          ..write('goalType: $goalType, ')
          ..write('goalWeight: $goalWeight, ')
          ..write('goalDate: $goalDate, ')
          ..write('tdeeTarget: $tdeeTarget, ')
          ..write('adaptiveGoalsEnabled: $adaptiveGoalsEnabled, ')
          ..write('lastUpdatedAt: $lastUpdatedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('isDirty: $isDirty')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
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
      createdAt,
      isDirty);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserProfileRow &&
          other.uid == this.uid &&
          other.name == this.name &&
          other.heightCm == this.heightCm &&
          other.birthYear == this.birthYear &&
          other.gender == this.gender &&
          other.units == this.units &&
          other.goalType == this.goalType &&
          other.goalWeight == this.goalWeight &&
          other.goalDate == this.goalDate &&
          other.tdeeTarget == this.tdeeTarget &&
          other.adaptiveGoalsEnabled == this.adaptiveGoalsEnabled &&
          other.lastUpdatedAt == this.lastUpdatedAt &&
          other.createdAt == this.createdAt &&
          other.isDirty == this.isDirty);
}

class UserProfilesCompanion extends UpdateCompanion<UserProfileRow> {
  final Value<String> uid;
  final Value<String> name;
  final Value<double> heightCm;
  final Value<int?> birthYear;
  final Value<String?> gender;
  final Value<UnitsSystem> units;
  final Value<GoalType> goalType;
  final Value<double> goalWeight;
  final Value<int> goalDate;
  final Value<double?> tdeeTarget;
  final Value<bool> adaptiveGoalsEnabled;
  final Value<int> lastUpdatedAt;
  final Value<int> createdAt;
  final Value<bool> isDirty;
  final Value<int> rowid;
  const UserProfilesCompanion({
    this.uid = const Value.absent(),
    this.name = const Value.absent(),
    this.heightCm = const Value.absent(),
    this.birthYear = const Value.absent(),
    this.gender = const Value.absent(),
    this.units = const Value.absent(),
    this.goalType = const Value.absent(),
    this.goalWeight = const Value.absent(),
    this.goalDate = const Value.absent(),
    this.tdeeTarget = const Value.absent(),
    this.adaptiveGoalsEnabled = const Value.absent(),
    this.lastUpdatedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.isDirty = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UserProfilesCompanion.insert({
    required String uid,
    required String name,
    required double heightCm,
    this.birthYear = const Value.absent(),
    this.gender = const Value.absent(),
    required UnitsSystem units,
    required GoalType goalType,
    required double goalWeight,
    required int goalDate,
    this.tdeeTarget = const Value.absent(),
    this.adaptiveGoalsEnabled = const Value.absent(),
    required int lastUpdatedAt,
    required int createdAt,
    this.isDirty = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : uid = Value(uid),
        name = Value(name),
        heightCm = Value(heightCm),
        units = Value(units),
        goalType = Value(goalType),
        goalWeight = Value(goalWeight),
        goalDate = Value(goalDate),
        lastUpdatedAt = Value(lastUpdatedAt),
        createdAt = Value(createdAt);
  static Insertable<UserProfileRow> custom({
    Expression<String>? uid,
    Expression<String>? name,
    Expression<double>? heightCm,
    Expression<int>? birthYear,
    Expression<String>? gender,
    Expression<String>? units,
    Expression<String>? goalType,
    Expression<double>? goalWeight,
    Expression<int>? goalDate,
    Expression<double>? tdeeTarget,
    Expression<bool>? adaptiveGoalsEnabled,
    Expression<int>? lastUpdatedAt,
    Expression<int>? createdAt,
    Expression<bool>? isDirty,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (uid != null) 'uid': uid,
      if (name != null) 'name': name,
      if (heightCm != null) 'height_cm': heightCm,
      if (birthYear != null) 'birth_year': birthYear,
      if (gender != null) 'gender': gender,
      if (units != null) 'units': units,
      if (goalType != null) 'goal_type': goalType,
      if (goalWeight != null) 'goal_weight': goalWeight,
      if (goalDate != null) 'goal_date': goalDate,
      if (tdeeTarget != null) 'tdee_target': tdeeTarget,
      if (adaptiveGoalsEnabled != null)
        'adaptive_goals_enabled': adaptiveGoalsEnabled,
      if (lastUpdatedAt != null) 'last_updated_at': lastUpdatedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (isDirty != null) 'is_dirty': isDirty,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UserProfilesCompanion copyWith(
      {Value<String>? uid,
      Value<String>? name,
      Value<double>? heightCm,
      Value<int?>? birthYear,
      Value<String?>? gender,
      Value<UnitsSystem>? units,
      Value<GoalType>? goalType,
      Value<double>? goalWeight,
      Value<int>? goalDate,
      Value<double?>? tdeeTarget,
      Value<bool>? adaptiveGoalsEnabled,
      Value<int>? lastUpdatedAt,
      Value<int>? createdAt,
      Value<bool>? isDirty,
      Value<int>? rowid}) {
    return UserProfilesCompanion(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      heightCm: heightCm ?? this.heightCm,
      birthYear: birthYear ?? this.birthYear,
      gender: gender ?? this.gender,
      units: units ?? this.units,
      goalType: goalType ?? this.goalType,
      goalWeight: goalWeight ?? this.goalWeight,
      goalDate: goalDate ?? this.goalDate,
      tdeeTarget: tdeeTarget ?? this.tdeeTarget,
      adaptiveGoalsEnabled: adaptiveGoalsEnabled ?? this.adaptiveGoalsEnabled,
      lastUpdatedAt: lastUpdatedAt ?? this.lastUpdatedAt,
      createdAt: createdAt ?? this.createdAt,
      isDirty: isDirty ?? this.isDirty,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (uid.present) {
      map['uid'] = Variable<String>(uid.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (heightCm.present) {
      map['height_cm'] = Variable<double>(heightCm.value);
    }
    if (birthYear.present) {
      map['birth_year'] = Variable<int>(birthYear.value);
    }
    if (gender.present) {
      map['gender'] = Variable<String>(gender.value);
    }
    if (units.present) {
      map['units'] = Variable<String>(
          $UserProfilesTable.$converterunits.toSql(units.value));
    }
    if (goalType.present) {
      map['goal_type'] = Variable<String>(
          $UserProfilesTable.$convertergoalType.toSql(goalType.value));
    }
    if (goalWeight.present) {
      map['goal_weight'] = Variable<double>(goalWeight.value);
    }
    if (goalDate.present) {
      map['goal_date'] = Variable<int>(goalDate.value);
    }
    if (tdeeTarget.present) {
      map['tdee_target'] = Variable<double>(tdeeTarget.value);
    }
    if (adaptiveGoalsEnabled.present) {
      map['adaptive_goals_enabled'] =
          Variable<bool>(adaptiveGoalsEnabled.value);
    }
    if (lastUpdatedAt.present) {
      map['last_updated_at'] = Variable<int>(lastUpdatedAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (isDirty.present) {
      map['is_dirty'] = Variable<bool>(isDirty.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserProfilesCompanion(')
          ..write('uid: $uid, ')
          ..write('name: $name, ')
          ..write('heightCm: $heightCm, ')
          ..write('birthYear: $birthYear, ')
          ..write('gender: $gender, ')
          ..write('units: $units, ')
          ..write('goalType: $goalType, ')
          ..write('goalWeight: $goalWeight, ')
          ..write('goalDate: $goalDate, ')
          ..write('tdeeTarget: $tdeeTarget, ')
          ..write('adaptiveGoalsEnabled: $adaptiveGoalsEnabled, ')
          ..write('lastUpdatedAt: $lastUpdatedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('isDirty: $isDirty, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WeightEntriesTable extends WeightEntries
    with TableInfo<$WeightEntriesTable, WeightEntryRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WeightEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _uidMeta = const VerificationMeta('uid');
  @override
  late final GeneratedColumn<String> uid = GeneratedColumn<String>(
      'uid', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _recordedAtMeta =
      const VerificationMeta('recordedAt');
  @override
  late final GeneratedColumn<int> recordedAt = GeneratedColumn<int>(
      'date_time', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _weightKgMeta =
      const VerificationMeta('weightKg');
  @override
  late final GeneratedColumn<double> weightKg = GeneratedColumn<double>(
      'weight_kg', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
      'note', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _conditionTagMeta =
      const VerificationMeta('conditionTag');
  @override
  late final GeneratedColumnWithTypeConverter<ConditionTag?, String>
      conditionTag = GeneratedColumn<String>('condition_tag', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<ConditionTag?>(
              $WeightEntriesTable.$converterconditionTagn);
  static const VerificationMeta _moodTagMeta =
      const VerificationMeta('moodTag');
  @override
  late final GeneratedColumnWithTypeConverter<MoodTag?, String> moodTag =
      GeneratedColumn<String>('mood_tag', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<MoodTag?>($WeightEntriesTable.$convertermoodTagn);
  static const VerificationMeta _lastUpdatedAtMeta =
      const VerificationMeta('lastUpdatedAt');
  @override
  late final GeneratedColumn<int> lastUpdatedAt = GeneratedColumn<int>(
      'last_updated_at', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _isDeletedMeta =
      const VerificationMeta('isDeleted');
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
      'is_deleted', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_deleted" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _isDirtyMeta =
      const VerificationMeta('isDirty');
  @override
  late final GeneratedColumn<bool> isDirty = GeneratedColumn<bool>(
      'is_dirty', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_dirty" IN (0, 1))'),
      defaultValue: const Constant(true));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        uid,
        recordedAt,
        weightKg,
        note,
        conditionTag,
        moodTag,
        lastUpdatedAt,
        isDeleted,
        isDirty
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'weight_entries';
  @override
  VerificationContext validateIntegrity(Insertable<WeightEntryRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('uid')) {
      context.handle(
          _uidMeta, uid.isAcceptableOrUnknown(data['uid']!, _uidMeta));
    } else if (isInserting) {
      context.missing(_uidMeta);
    }
    if (data.containsKey('date_time')) {
      context.handle(
          _recordedAtMeta,
          recordedAt.isAcceptableOrUnknown(
              data['date_time']!, _recordedAtMeta));
    } else if (isInserting) {
      context.missing(_recordedAtMeta);
    }
    if (data.containsKey('weight_kg')) {
      context.handle(_weightKgMeta,
          weightKg.isAcceptableOrUnknown(data['weight_kg']!, _weightKgMeta));
    } else if (isInserting) {
      context.missing(_weightKgMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
          _noteMeta, note.isAcceptableOrUnknown(data['note']!, _noteMeta));
    }
    context.handle(_conditionTagMeta, const VerificationResult.success());
    context.handle(_moodTagMeta, const VerificationResult.success());
    if (data.containsKey('last_updated_at')) {
      context.handle(
          _lastUpdatedAtMeta,
          lastUpdatedAt.isAcceptableOrUnknown(
              data['last_updated_at']!, _lastUpdatedAtMeta));
    } else if (isInserting) {
      context.missing(_lastUpdatedAtMeta);
    }
    if (data.containsKey('is_deleted')) {
      context.handle(_isDeletedMeta,
          isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta));
    }
    if (data.containsKey('is_dirty')) {
      context.handle(_isDirtyMeta,
          isDirty.isAcceptableOrUnknown(data['is_dirty']!, _isDirtyMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WeightEntryRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WeightEntryRow(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      uid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}uid'])!,
      recordedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}date_time'])!,
      weightKg: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}weight_kg'])!,
      note: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note']),
      conditionTag: $WeightEntriesTable.$converterconditionTagn.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}condition_tag'])),
      moodTag: $WeightEntriesTable.$convertermoodTagn.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}mood_tag'])),
      lastUpdatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}last_updated_at'])!,
      isDeleted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_deleted'])!,
      isDirty: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_dirty'])!,
    );
  }

  @override
  $WeightEntriesTable createAlias(String alias) {
    return $WeightEntriesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<ConditionTag, String, String>
      $converterconditionTag =
      const EnumNameConverter<ConditionTag>(ConditionTag.values);
  static JsonTypeConverter2<ConditionTag?, String?, String?>
      $converterconditionTagn =
      JsonTypeConverter2.asNullable($converterconditionTag);
  static JsonTypeConverter2<MoodTag, String, String> $convertermoodTag =
      const EnumNameConverter<MoodTag>(MoodTag.values);
  static JsonTypeConverter2<MoodTag?, String?, String?> $convertermoodTagn =
      JsonTypeConverter2.asNullable($convertermoodTag);
}

class WeightEntryRow extends DataClass implements Insertable<WeightEntryRow> {
  final String id;
  final String uid;
  final int recordedAt;
  final double weightKg;
  final String? note;
  final ConditionTag? conditionTag;
  final MoodTag? moodTag;
  final int lastUpdatedAt;
  final bool isDeleted;
  final bool isDirty;
  const WeightEntryRow(
      {required this.id,
      required this.uid,
      required this.recordedAt,
      required this.weightKg,
      this.note,
      this.conditionTag,
      this.moodTag,
      required this.lastUpdatedAt,
      required this.isDeleted,
      required this.isDirty});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['uid'] = Variable<String>(uid);
    map['date_time'] = Variable<int>(recordedAt);
    map['weight_kg'] = Variable<double>(weightKg);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    if (!nullToAbsent || conditionTag != null) {
      map['condition_tag'] = Variable<String>(
          $WeightEntriesTable.$converterconditionTagn.toSql(conditionTag));
    }
    if (!nullToAbsent || moodTag != null) {
      map['mood_tag'] = Variable<String>(
          $WeightEntriesTable.$convertermoodTagn.toSql(moodTag));
    }
    map['last_updated_at'] = Variable<int>(lastUpdatedAt);
    map['is_deleted'] = Variable<bool>(isDeleted);
    map['is_dirty'] = Variable<bool>(isDirty);
    return map;
  }

  WeightEntriesCompanion toCompanion(bool nullToAbsent) {
    return WeightEntriesCompanion(
      id: Value(id),
      uid: Value(uid),
      recordedAt: Value(recordedAt),
      weightKg: Value(weightKg),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      conditionTag: conditionTag == null && nullToAbsent
          ? const Value.absent()
          : Value(conditionTag),
      moodTag: moodTag == null && nullToAbsent
          ? const Value.absent()
          : Value(moodTag),
      lastUpdatedAt: Value(lastUpdatedAt),
      isDeleted: Value(isDeleted),
      isDirty: Value(isDirty),
    );
  }

  factory WeightEntryRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WeightEntryRow(
      id: serializer.fromJson<String>(json['id']),
      uid: serializer.fromJson<String>(json['uid']),
      recordedAt: serializer.fromJson<int>(json['recordedAt']),
      weightKg: serializer.fromJson<double>(json['weightKg']),
      note: serializer.fromJson<String?>(json['note']),
      conditionTag: $WeightEntriesTable.$converterconditionTagn
          .fromJson(serializer.fromJson<String?>(json['conditionTag'])),
      moodTag: $WeightEntriesTable.$convertermoodTagn
          .fromJson(serializer.fromJson<String?>(json['moodTag'])),
      lastUpdatedAt: serializer.fromJson<int>(json['lastUpdatedAt']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      isDirty: serializer.fromJson<bool>(json['isDirty']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'uid': serializer.toJson<String>(uid),
      'recordedAt': serializer.toJson<int>(recordedAt),
      'weightKg': serializer.toJson<double>(weightKg),
      'note': serializer.toJson<String?>(note),
      'conditionTag': serializer.toJson<String?>(
          $WeightEntriesTable.$converterconditionTagn.toJson(conditionTag)),
      'moodTag': serializer.toJson<String?>(
          $WeightEntriesTable.$convertermoodTagn.toJson(moodTag)),
      'lastUpdatedAt': serializer.toJson<int>(lastUpdatedAt),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'isDirty': serializer.toJson<bool>(isDirty),
    };
  }

  WeightEntryRow copyWith(
          {String? id,
          String? uid,
          int? recordedAt,
          double? weightKg,
          Value<String?> note = const Value.absent(),
          Value<ConditionTag?> conditionTag = const Value.absent(),
          Value<MoodTag?> moodTag = const Value.absent(),
          int? lastUpdatedAt,
          bool? isDeleted,
          bool? isDirty}) =>
      WeightEntryRow(
        id: id ?? this.id,
        uid: uid ?? this.uid,
        recordedAt: recordedAt ?? this.recordedAt,
        weightKg: weightKg ?? this.weightKg,
        note: note.present ? note.value : this.note,
        conditionTag:
            conditionTag.present ? conditionTag.value : this.conditionTag,
        moodTag: moodTag.present ? moodTag.value : this.moodTag,
        lastUpdatedAt: lastUpdatedAt ?? this.lastUpdatedAt,
        isDeleted: isDeleted ?? this.isDeleted,
        isDirty: isDirty ?? this.isDirty,
      );
  WeightEntryRow copyWithCompanion(WeightEntriesCompanion data) {
    return WeightEntryRow(
      id: data.id.present ? data.id.value : this.id,
      uid: data.uid.present ? data.uid.value : this.uid,
      recordedAt:
          data.recordedAt.present ? data.recordedAt.value : this.recordedAt,
      weightKg: data.weightKg.present ? data.weightKg.value : this.weightKg,
      note: data.note.present ? data.note.value : this.note,
      conditionTag: data.conditionTag.present
          ? data.conditionTag.value
          : this.conditionTag,
      moodTag: data.moodTag.present ? data.moodTag.value : this.moodTag,
      lastUpdatedAt: data.lastUpdatedAt.present
          ? data.lastUpdatedAt.value
          : this.lastUpdatedAt,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      isDirty: data.isDirty.present ? data.isDirty.value : this.isDirty,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WeightEntryRow(')
          ..write('id: $id, ')
          ..write('uid: $uid, ')
          ..write('recordedAt: $recordedAt, ')
          ..write('weightKg: $weightKg, ')
          ..write('note: $note, ')
          ..write('conditionTag: $conditionTag, ')
          ..write('moodTag: $moodTag, ')
          ..write('lastUpdatedAt: $lastUpdatedAt, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('isDirty: $isDirty')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, uid, recordedAt, weightKg, note,
      conditionTag, moodTag, lastUpdatedAt, isDeleted, isDirty);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WeightEntryRow &&
          other.id == this.id &&
          other.uid == this.uid &&
          other.recordedAt == this.recordedAt &&
          other.weightKg == this.weightKg &&
          other.note == this.note &&
          other.conditionTag == this.conditionTag &&
          other.moodTag == this.moodTag &&
          other.lastUpdatedAt == this.lastUpdatedAt &&
          other.isDeleted == this.isDeleted &&
          other.isDirty == this.isDirty);
}

class WeightEntriesCompanion extends UpdateCompanion<WeightEntryRow> {
  final Value<String> id;
  final Value<String> uid;
  final Value<int> recordedAt;
  final Value<double> weightKg;
  final Value<String?> note;
  final Value<ConditionTag?> conditionTag;
  final Value<MoodTag?> moodTag;
  final Value<int> lastUpdatedAt;
  final Value<bool> isDeleted;
  final Value<bool> isDirty;
  final Value<int> rowid;
  const WeightEntriesCompanion({
    this.id = const Value.absent(),
    this.uid = const Value.absent(),
    this.recordedAt = const Value.absent(),
    this.weightKg = const Value.absent(),
    this.note = const Value.absent(),
    this.conditionTag = const Value.absent(),
    this.moodTag = const Value.absent(),
    this.lastUpdatedAt = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.isDirty = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WeightEntriesCompanion.insert({
    required String id,
    required String uid,
    required int recordedAt,
    required double weightKg,
    this.note = const Value.absent(),
    this.conditionTag = const Value.absent(),
    this.moodTag = const Value.absent(),
    required int lastUpdatedAt,
    this.isDeleted = const Value.absent(),
    this.isDirty = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        uid = Value(uid),
        recordedAt = Value(recordedAt),
        weightKg = Value(weightKg),
        lastUpdatedAt = Value(lastUpdatedAt);
  static Insertable<WeightEntryRow> custom({
    Expression<String>? id,
    Expression<String>? uid,
    Expression<int>? recordedAt,
    Expression<double>? weightKg,
    Expression<String>? note,
    Expression<String>? conditionTag,
    Expression<String>? moodTag,
    Expression<int>? lastUpdatedAt,
    Expression<bool>? isDeleted,
    Expression<bool>? isDirty,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uid != null) 'uid': uid,
      if (recordedAt != null) 'date_time': recordedAt,
      if (weightKg != null) 'weight_kg': weightKg,
      if (note != null) 'note': note,
      if (conditionTag != null) 'condition_tag': conditionTag,
      if (moodTag != null) 'mood_tag': moodTag,
      if (lastUpdatedAt != null) 'last_updated_at': lastUpdatedAt,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (isDirty != null) 'is_dirty': isDirty,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WeightEntriesCompanion copyWith(
      {Value<String>? id,
      Value<String>? uid,
      Value<int>? recordedAt,
      Value<double>? weightKg,
      Value<String?>? note,
      Value<ConditionTag?>? conditionTag,
      Value<MoodTag?>? moodTag,
      Value<int>? lastUpdatedAt,
      Value<bool>? isDeleted,
      Value<bool>? isDirty,
      Value<int>? rowid}) {
    return WeightEntriesCompanion(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      recordedAt: recordedAt ?? this.recordedAt,
      weightKg: weightKg ?? this.weightKg,
      note: note ?? this.note,
      conditionTag: conditionTag ?? this.conditionTag,
      moodTag: moodTag ?? this.moodTag,
      lastUpdatedAt: lastUpdatedAt ?? this.lastUpdatedAt,
      isDeleted: isDeleted ?? this.isDeleted,
      isDirty: isDirty ?? this.isDirty,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (uid.present) {
      map['uid'] = Variable<String>(uid.value);
    }
    if (recordedAt.present) {
      map['date_time'] = Variable<int>(recordedAt.value);
    }
    if (weightKg.present) {
      map['weight_kg'] = Variable<double>(weightKg.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (conditionTag.present) {
      map['condition_tag'] = Variable<String>($WeightEntriesTable
          .$converterconditionTagn
          .toSql(conditionTag.value));
    }
    if (moodTag.present) {
      map['mood_tag'] = Variable<String>(
          $WeightEntriesTable.$convertermoodTagn.toSql(moodTag.value));
    }
    if (lastUpdatedAt.present) {
      map['last_updated_at'] = Variable<int>(lastUpdatedAt.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (isDirty.present) {
      map['is_dirty'] = Variable<bool>(isDirty.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WeightEntriesCompanion(')
          ..write('id: $id, ')
          ..write('uid: $uid, ')
          ..write('recordedAt: $recordedAt, ')
          ..write('weightKg: $weightKg, ')
          ..write('note: $note, ')
          ..write('conditionTag: $conditionTag, ')
          ..write('moodTag: $moodTag, ')
          ..write('lastUpdatedAt: $lastUpdatedAt, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('isDirty: $isDirty, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MeasurementEntriesTable extends MeasurementEntries
    with TableInfo<$MeasurementEntriesTable, MeasurementEntryRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MeasurementEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _uidMeta = const VerificationMeta('uid');
  @override
  late final GeneratedColumn<String> uid = GeneratedColumn<String>(
      'uid', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _recordedAtMeta =
      const VerificationMeta('recordedAt');
  @override
  late final GeneratedColumn<int> recordedAt = GeneratedColumn<int>(
      'date_time', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _waistCmMeta =
      const VerificationMeta('waistCm');
  @override
  late final GeneratedColumn<double> waistCm = GeneratedColumn<double>(
      'waist_cm', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _hipCmMeta = const VerificationMeta('hipCm');
  @override
  late final GeneratedColumn<double> hipCm = GeneratedColumn<double>(
      'hip_cm', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _chestCmMeta =
      const VerificationMeta('chestCm');
  @override
  late final GeneratedColumn<double> chestCm = GeneratedColumn<double>(
      'chest_cm', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _neckCmMeta = const VerificationMeta('neckCm');
  @override
  late final GeneratedColumn<double> neckCm = GeneratedColumn<double>(
      'neck_cm', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _armCmMeta = const VerificationMeta('armCm');
  @override
  late final GeneratedColumn<double> armCm = GeneratedColumn<double>(
      'arm_cm', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _thighCmMeta =
      const VerificationMeta('thighCm');
  @override
  late final GeneratedColumn<double> thighCm = GeneratedColumn<double>(
      'thigh_cm', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _bodyFatPctMeta =
      const VerificationMeta('bodyFatPct');
  @override
  late final GeneratedColumn<double> bodyFatPct = GeneratedColumn<double>(
      'body_fat_pct', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _musclePctMeta =
      const VerificationMeta('musclePct');
  @override
  late final GeneratedColumn<double> musclePct = GeneratedColumn<double>(
      'muscle_pct', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _waterPctMeta =
      const VerificationMeta('waterPct');
  @override
  late final GeneratedColumn<double> waterPct = GeneratedColumn<double>(
      'water_pct', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _lastUpdatedAtMeta =
      const VerificationMeta('lastUpdatedAt');
  @override
  late final GeneratedColumn<int> lastUpdatedAt = GeneratedColumn<int>(
      'last_updated_at', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _isDeletedMeta =
      const VerificationMeta('isDeleted');
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
      'is_deleted', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_deleted" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _isDirtyMeta =
      const VerificationMeta('isDirty');
  @override
  late final GeneratedColumn<bool> isDirty = GeneratedColumn<bool>(
      'is_dirty', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_dirty" IN (0, 1))'),
      defaultValue: const Constant(true));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        uid,
        recordedAt,
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
        isDeleted,
        isDirty
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'measurement_entries';
  @override
  VerificationContext validateIntegrity(
      Insertable<MeasurementEntryRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('uid')) {
      context.handle(
          _uidMeta, uid.isAcceptableOrUnknown(data['uid']!, _uidMeta));
    } else if (isInserting) {
      context.missing(_uidMeta);
    }
    if (data.containsKey('date_time')) {
      context.handle(
          _recordedAtMeta,
          recordedAt.isAcceptableOrUnknown(
              data['date_time']!, _recordedAtMeta));
    } else if (isInserting) {
      context.missing(_recordedAtMeta);
    }
    if (data.containsKey('waist_cm')) {
      context.handle(_waistCmMeta,
          waistCm.isAcceptableOrUnknown(data['waist_cm']!, _waistCmMeta));
    } else if (isInserting) {
      context.missing(_waistCmMeta);
    }
    if (data.containsKey('hip_cm')) {
      context.handle(
          _hipCmMeta, hipCm.isAcceptableOrUnknown(data['hip_cm']!, _hipCmMeta));
    } else if (isInserting) {
      context.missing(_hipCmMeta);
    }
    if (data.containsKey('chest_cm')) {
      context.handle(_chestCmMeta,
          chestCm.isAcceptableOrUnknown(data['chest_cm']!, _chestCmMeta));
    } else if (isInserting) {
      context.missing(_chestCmMeta);
    }
    if (data.containsKey('neck_cm')) {
      context.handle(_neckCmMeta,
          neckCm.isAcceptableOrUnknown(data['neck_cm']!, _neckCmMeta));
    } else if (isInserting) {
      context.missing(_neckCmMeta);
    }
    if (data.containsKey('arm_cm')) {
      context.handle(
          _armCmMeta, armCm.isAcceptableOrUnknown(data['arm_cm']!, _armCmMeta));
    } else if (isInserting) {
      context.missing(_armCmMeta);
    }
    if (data.containsKey('thigh_cm')) {
      context.handle(_thighCmMeta,
          thighCm.isAcceptableOrUnknown(data['thigh_cm']!, _thighCmMeta));
    } else if (isInserting) {
      context.missing(_thighCmMeta);
    }
    if (data.containsKey('body_fat_pct')) {
      context.handle(
          _bodyFatPctMeta,
          bodyFatPct.isAcceptableOrUnknown(
              data['body_fat_pct']!, _bodyFatPctMeta));
    }
    if (data.containsKey('muscle_pct')) {
      context.handle(_musclePctMeta,
          musclePct.isAcceptableOrUnknown(data['muscle_pct']!, _musclePctMeta));
    }
    if (data.containsKey('water_pct')) {
      context.handle(_waterPctMeta,
          waterPct.isAcceptableOrUnknown(data['water_pct']!, _waterPctMeta));
    }
    if (data.containsKey('last_updated_at')) {
      context.handle(
          _lastUpdatedAtMeta,
          lastUpdatedAt.isAcceptableOrUnknown(
              data['last_updated_at']!, _lastUpdatedAtMeta));
    } else if (isInserting) {
      context.missing(_lastUpdatedAtMeta);
    }
    if (data.containsKey('is_deleted')) {
      context.handle(_isDeletedMeta,
          isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta));
    }
    if (data.containsKey('is_dirty')) {
      context.handle(_isDirtyMeta,
          isDirty.isAcceptableOrUnknown(data['is_dirty']!, _isDirtyMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MeasurementEntryRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MeasurementEntryRow(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      uid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}uid'])!,
      recordedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}date_time'])!,
      waistCm: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}waist_cm'])!,
      hipCm: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}hip_cm'])!,
      chestCm: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}chest_cm'])!,
      neckCm: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}neck_cm'])!,
      armCm: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}arm_cm'])!,
      thighCm: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}thigh_cm'])!,
      bodyFatPct: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}body_fat_pct']),
      musclePct: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}muscle_pct']),
      waterPct: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}water_pct']),
      lastUpdatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}last_updated_at'])!,
      isDeleted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_deleted'])!,
      isDirty: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_dirty'])!,
    );
  }

  @override
  $MeasurementEntriesTable createAlias(String alias) {
    return $MeasurementEntriesTable(attachedDatabase, alias);
  }
}

class MeasurementEntryRow extends DataClass
    implements Insertable<MeasurementEntryRow> {
  final String id;
  final String uid;
  final int recordedAt;
  final double waistCm;
  final double hipCm;
  final double chestCm;
  final double neckCm;
  final double armCm;
  final double thighCm;
  final double? bodyFatPct;
  final double? musclePct;
  final double? waterPct;
  final int lastUpdatedAt;
  final bool isDeleted;
  final bool isDirty;
  const MeasurementEntryRow(
      {required this.id,
      required this.uid,
      required this.recordedAt,
      required this.waistCm,
      required this.hipCm,
      required this.chestCm,
      required this.neckCm,
      required this.armCm,
      required this.thighCm,
      this.bodyFatPct,
      this.musclePct,
      this.waterPct,
      required this.lastUpdatedAt,
      required this.isDeleted,
      required this.isDirty});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['uid'] = Variable<String>(uid);
    map['date_time'] = Variable<int>(recordedAt);
    map['waist_cm'] = Variable<double>(waistCm);
    map['hip_cm'] = Variable<double>(hipCm);
    map['chest_cm'] = Variable<double>(chestCm);
    map['neck_cm'] = Variable<double>(neckCm);
    map['arm_cm'] = Variable<double>(armCm);
    map['thigh_cm'] = Variable<double>(thighCm);
    if (!nullToAbsent || bodyFatPct != null) {
      map['body_fat_pct'] = Variable<double>(bodyFatPct);
    }
    if (!nullToAbsent || musclePct != null) {
      map['muscle_pct'] = Variable<double>(musclePct);
    }
    if (!nullToAbsent || waterPct != null) {
      map['water_pct'] = Variable<double>(waterPct);
    }
    map['last_updated_at'] = Variable<int>(lastUpdatedAt);
    map['is_deleted'] = Variable<bool>(isDeleted);
    map['is_dirty'] = Variable<bool>(isDirty);
    return map;
  }

  MeasurementEntriesCompanion toCompanion(bool nullToAbsent) {
    return MeasurementEntriesCompanion(
      id: Value(id),
      uid: Value(uid),
      recordedAt: Value(recordedAt),
      waistCm: Value(waistCm),
      hipCm: Value(hipCm),
      chestCm: Value(chestCm),
      neckCm: Value(neckCm),
      armCm: Value(armCm),
      thighCm: Value(thighCm),
      bodyFatPct: bodyFatPct == null && nullToAbsent
          ? const Value.absent()
          : Value(bodyFatPct),
      musclePct: musclePct == null && nullToAbsent
          ? const Value.absent()
          : Value(musclePct),
      waterPct: waterPct == null && nullToAbsent
          ? const Value.absent()
          : Value(waterPct),
      lastUpdatedAt: Value(lastUpdatedAt),
      isDeleted: Value(isDeleted),
      isDirty: Value(isDirty),
    );
  }

  factory MeasurementEntryRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MeasurementEntryRow(
      id: serializer.fromJson<String>(json['id']),
      uid: serializer.fromJson<String>(json['uid']),
      recordedAt: serializer.fromJson<int>(json['recordedAt']),
      waistCm: serializer.fromJson<double>(json['waistCm']),
      hipCm: serializer.fromJson<double>(json['hipCm']),
      chestCm: serializer.fromJson<double>(json['chestCm']),
      neckCm: serializer.fromJson<double>(json['neckCm']),
      armCm: serializer.fromJson<double>(json['armCm']),
      thighCm: serializer.fromJson<double>(json['thighCm']),
      bodyFatPct: serializer.fromJson<double?>(json['bodyFatPct']),
      musclePct: serializer.fromJson<double?>(json['musclePct']),
      waterPct: serializer.fromJson<double?>(json['waterPct']),
      lastUpdatedAt: serializer.fromJson<int>(json['lastUpdatedAt']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      isDirty: serializer.fromJson<bool>(json['isDirty']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'uid': serializer.toJson<String>(uid),
      'recordedAt': serializer.toJson<int>(recordedAt),
      'waistCm': serializer.toJson<double>(waistCm),
      'hipCm': serializer.toJson<double>(hipCm),
      'chestCm': serializer.toJson<double>(chestCm),
      'neckCm': serializer.toJson<double>(neckCm),
      'armCm': serializer.toJson<double>(armCm),
      'thighCm': serializer.toJson<double>(thighCm),
      'bodyFatPct': serializer.toJson<double?>(bodyFatPct),
      'musclePct': serializer.toJson<double?>(musclePct),
      'waterPct': serializer.toJson<double?>(waterPct),
      'lastUpdatedAt': serializer.toJson<int>(lastUpdatedAt),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'isDirty': serializer.toJson<bool>(isDirty),
    };
  }

  MeasurementEntryRow copyWith(
          {String? id,
          String? uid,
          int? recordedAt,
          double? waistCm,
          double? hipCm,
          double? chestCm,
          double? neckCm,
          double? armCm,
          double? thighCm,
          Value<double?> bodyFatPct = const Value.absent(),
          Value<double?> musclePct = const Value.absent(),
          Value<double?> waterPct = const Value.absent(),
          int? lastUpdatedAt,
          bool? isDeleted,
          bool? isDirty}) =>
      MeasurementEntryRow(
        id: id ?? this.id,
        uid: uid ?? this.uid,
        recordedAt: recordedAt ?? this.recordedAt,
        waistCm: waistCm ?? this.waistCm,
        hipCm: hipCm ?? this.hipCm,
        chestCm: chestCm ?? this.chestCm,
        neckCm: neckCm ?? this.neckCm,
        armCm: armCm ?? this.armCm,
        thighCm: thighCm ?? this.thighCm,
        bodyFatPct: bodyFatPct.present ? bodyFatPct.value : this.bodyFatPct,
        musclePct: musclePct.present ? musclePct.value : this.musclePct,
        waterPct: waterPct.present ? waterPct.value : this.waterPct,
        lastUpdatedAt: lastUpdatedAt ?? this.lastUpdatedAt,
        isDeleted: isDeleted ?? this.isDeleted,
        isDirty: isDirty ?? this.isDirty,
      );
  MeasurementEntryRow copyWithCompanion(MeasurementEntriesCompanion data) {
    return MeasurementEntryRow(
      id: data.id.present ? data.id.value : this.id,
      uid: data.uid.present ? data.uid.value : this.uid,
      recordedAt:
          data.recordedAt.present ? data.recordedAt.value : this.recordedAt,
      waistCm: data.waistCm.present ? data.waistCm.value : this.waistCm,
      hipCm: data.hipCm.present ? data.hipCm.value : this.hipCm,
      chestCm: data.chestCm.present ? data.chestCm.value : this.chestCm,
      neckCm: data.neckCm.present ? data.neckCm.value : this.neckCm,
      armCm: data.armCm.present ? data.armCm.value : this.armCm,
      thighCm: data.thighCm.present ? data.thighCm.value : this.thighCm,
      bodyFatPct:
          data.bodyFatPct.present ? data.bodyFatPct.value : this.bodyFatPct,
      musclePct: data.musclePct.present ? data.musclePct.value : this.musclePct,
      waterPct: data.waterPct.present ? data.waterPct.value : this.waterPct,
      lastUpdatedAt: data.lastUpdatedAt.present
          ? data.lastUpdatedAt.value
          : this.lastUpdatedAt,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      isDirty: data.isDirty.present ? data.isDirty.value : this.isDirty,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MeasurementEntryRow(')
          ..write('id: $id, ')
          ..write('uid: $uid, ')
          ..write('recordedAt: $recordedAt, ')
          ..write('waistCm: $waistCm, ')
          ..write('hipCm: $hipCm, ')
          ..write('chestCm: $chestCm, ')
          ..write('neckCm: $neckCm, ')
          ..write('armCm: $armCm, ')
          ..write('thighCm: $thighCm, ')
          ..write('bodyFatPct: $bodyFatPct, ')
          ..write('musclePct: $musclePct, ')
          ..write('waterPct: $waterPct, ')
          ..write('lastUpdatedAt: $lastUpdatedAt, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('isDirty: $isDirty')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      uid,
      recordedAt,
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
      isDeleted,
      isDirty);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MeasurementEntryRow &&
          other.id == this.id &&
          other.uid == this.uid &&
          other.recordedAt == this.recordedAt &&
          other.waistCm == this.waistCm &&
          other.hipCm == this.hipCm &&
          other.chestCm == this.chestCm &&
          other.neckCm == this.neckCm &&
          other.armCm == this.armCm &&
          other.thighCm == this.thighCm &&
          other.bodyFatPct == this.bodyFatPct &&
          other.musclePct == this.musclePct &&
          other.waterPct == this.waterPct &&
          other.lastUpdatedAt == this.lastUpdatedAt &&
          other.isDeleted == this.isDeleted &&
          other.isDirty == this.isDirty);
}

class MeasurementEntriesCompanion extends UpdateCompanion<MeasurementEntryRow> {
  final Value<String> id;
  final Value<String> uid;
  final Value<int> recordedAt;
  final Value<double> waistCm;
  final Value<double> hipCm;
  final Value<double> chestCm;
  final Value<double> neckCm;
  final Value<double> armCm;
  final Value<double> thighCm;
  final Value<double?> bodyFatPct;
  final Value<double?> musclePct;
  final Value<double?> waterPct;
  final Value<int> lastUpdatedAt;
  final Value<bool> isDeleted;
  final Value<bool> isDirty;
  final Value<int> rowid;
  const MeasurementEntriesCompanion({
    this.id = const Value.absent(),
    this.uid = const Value.absent(),
    this.recordedAt = const Value.absent(),
    this.waistCm = const Value.absent(),
    this.hipCm = const Value.absent(),
    this.chestCm = const Value.absent(),
    this.neckCm = const Value.absent(),
    this.armCm = const Value.absent(),
    this.thighCm = const Value.absent(),
    this.bodyFatPct = const Value.absent(),
    this.musclePct = const Value.absent(),
    this.waterPct = const Value.absent(),
    this.lastUpdatedAt = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.isDirty = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MeasurementEntriesCompanion.insert({
    required String id,
    required String uid,
    required int recordedAt,
    required double waistCm,
    required double hipCm,
    required double chestCm,
    required double neckCm,
    required double armCm,
    required double thighCm,
    this.bodyFatPct = const Value.absent(),
    this.musclePct = const Value.absent(),
    this.waterPct = const Value.absent(),
    required int lastUpdatedAt,
    this.isDeleted = const Value.absent(),
    this.isDirty = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        uid = Value(uid),
        recordedAt = Value(recordedAt),
        waistCm = Value(waistCm),
        hipCm = Value(hipCm),
        chestCm = Value(chestCm),
        neckCm = Value(neckCm),
        armCm = Value(armCm),
        thighCm = Value(thighCm),
        lastUpdatedAt = Value(lastUpdatedAt);
  static Insertable<MeasurementEntryRow> custom({
    Expression<String>? id,
    Expression<String>? uid,
    Expression<int>? recordedAt,
    Expression<double>? waistCm,
    Expression<double>? hipCm,
    Expression<double>? chestCm,
    Expression<double>? neckCm,
    Expression<double>? armCm,
    Expression<double>? thighCm,
    Expression<double>? bodyFatPct,
    Expression<double>? musclePct,
    Expression<double>? waterPct,
    Expression<int>? lastUpdatedAt,
    Expression<bool>? isDeleted,
    Expression<bool>? isDirty,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uid != null) 'uid': uid,
      if (recordedAt != null) 'date_time': recordedAt,
      if (waistCm != null) 'waist_cm': waistCm,
      if (hipCm != null) 'hip_cm': hipCm,
      if (chestCm != null) 'chest_cm': chestCm,
      if (neckCm != null) 'neck_cm': neckCm,
      if (armCm != null) 'arm_cm': armCm,
      if (thighCm != null) 'thigh_cm': thighCm,
      if (bodyFatPct != null) 'body_fat_pct': bodyFatPct,
      if (musclePct != null) 'muscle_pct': musclePct,
      if (waterPct != null) 'water_pct': waterPct,
      if (lastUpdatedAt != null) 'last_updated_at': lastUpdatedAt,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (isDirty != null) 'is_dirty': isDirty,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MeasurementEntriesCompanion copyWith(
      {Value<String>? id,
      Value<String>? uid,
      Value<int>? recordedAt,
      Value<double>? waistCm,
      Value<double>? hipCm,
      Value<double>? chestCm,
      Value<double>? neckCm,
      Value<double>? armCm,
      Value<double>? thighCm,
      Value<double?>? bodyFatPct,
      Value<double?>? musclePct,
      Value<double?>? waterPct,
      Value<int>? lastUpdatedAt,
      Value<bool>? isDeleted,
      Value<bool>? isDirty,
      Value<int>? rowid}) {
    return MeasurementEntriesCompanion(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      recordedAt: recordedAt ?? this.recordedAt,
      waistCm: waistCm ?? this.waistCm,
      hipCm: hipCm ?? this.hipCm,
      chestCm: chestCm ?? this.chestCm,
      neckCm: neckCm ?? this.neckCm,
      armCm: armCm ?? this.armCm,
      thighCm: thighCm ?? this.thighCm,
      bodyFatPct: bodyFatPct ?? this.bodyFatPct,
      musclePct: musclePct ?? this.musclePct,
      waterPct: waterPct ?? this.waterPct,
      lastUpdatedAt: lastUpdatedAt ?? this.lastUpdatedAt,
      isDeleted: isDeleted ?? this.isDeleted,
      isDirty: isDirty ?? this.isDirty,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (uid.present) {
      map['uid'] = Variable<String>(uid.value);
    }
    if (recordedAt.present) {
      map['date_time'] = Variable<int>(recordedAt.value);
    }
    if (waistCm.present) {
      map['waist_cm'] = Variable<double>(waistCm.value);
    }
    if (hipCm.present) {
      map['hip_cm'] = Variable<double>(hipCm.value);
    }
    if (chestCm.present) {
      map['chest_cm'] = Variable<double>(chestCm.value);
    }
    if (neckCm.present) {
      map['neck_cm'] = Variable<double>(neckCm.value);
    }
    if (armCm.present) {
      map['arm_cm'] = Variable<double>(armCm.value);
    }
    if (thighCm.present) {
      map['thigh_cm'] = Variable<double>(thighCm.value);
    }
    if (bodyFatPct.present) {
      map['body_fat_pct'] = Variable<double>(bodyFatPct.value);
    }
    if (musclePct.present) {
      map['muscle_pct'] = Variable<double>(musclePct.value);
    }
    if (waterPct.present) {
      map['water_pct'] = Variable<double>(waterPct.value);
    }
    if (lastUpdatedAt.present) {
      map['last_updated_at'] = Variable<int>(lastUpdatedAt.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (isDirty.present) {
      map['is_dirty'] = Variable<bool>(isDirty.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MeasurementEntriesCompanion(')
          ..write('id: $id, ')
          ..write('uid: $uid, ')
          ..write('recordedAt: $recordedAt, ')
          ..write('waistCm: $waistCm, ')
          ..write('hipCm: $hipCm, ')
          ..write('chestCm: $chestCm, ')
          ..write('neckCm: $neckCm, ')
          ..write('armCm: $armCm, ')
          ..write('thighCm: $thighCm, ')
          ..write('bodyFatPct: $bodyFatPct, ')
          ..write('musclePct: $musclePct, ')
          ..write('waterPct: $waterPct, ')
          ..write('lastUpdatedAt: $lastUpdatedAt, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('isDirty: $isDirty, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WaterEntriesTable extends WaterEntries
    with TableInfo<$WaterEntriesTable, WaterEntryRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WaterEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _uidMeta = const VerificationMeta('uid');
  @override
  late final GeneratedColumn<String> uid = GeneratedColumn<String>(
      'uid', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<int> date = GeneratedColumn<int>(
      'date', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _mlMeta = const VerificationMeta('ml');
  @override
  late final GeneratedColumn<int> ml = GeneratedColumn<int>(
      'ml', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _lastUpdatedAtMeta =
      const VerificationMeta('lastUpdatedAt');
  @override
  late final GeneratedColumn<int> lastUpdatedAt = GeneratedColumn<int>(
      'last_updated_at', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _isDeletedMeta =
      const VerificationMeta('isDeleted');
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
      'is_deleted', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_deleted" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _isDirtyMeta =
      const VerificationMeta('isDirty');
  @override
  late final GeneratedColumn<bool> isDirty = GeneratedColumn<bool>(
      'is_dirty', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_dirty" IN (0, 1))'),
      defaultValue: const Constant(true));
  @override
  List<GeneratedColumn> get $columns =>
      [id, uid, date, ml, lastUpdatedAt, isDeleted, isDirty];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'water_entries';
  @override
  VerificationContext validateIntegrity(Insertable<WaterEntryRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('uid')) {
      context.handle(
          _uidMeta, uid.isAcceptableOrUnknown(data['uid']!, _uidMeta));
    } else if (isInserting) {
      context.missing(_uidMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('ml')) {
      context.handle(_mlMeta, ml.isAcceptableOrUnknown(data['ml']!, _mlMeta));
    } else if (isInserting) {
      context.missing(_mlMeta);
    }
    if (data.containsKey('last_updated_at')) {
      context.handle(
          _lastUpdatedAtMeta,
          lastUpdatedAt.isAcceptableOrUnknown(
              data['last_updated_at']!, _lastUpdatedAtMeta));
    } else if (isInserting) {
      context.missing(_lastUpdatedAtMeta);
    }
    if (data.containsKey('is_deleted')) {
      context.handle(_isDeletedMeta,
          isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta));
    }
    if (data.containsKey('is_dirty')) {
      context.handle(_isDirtyMeta,
          isDirty.isAcceptableOrUnknown(data['is_dirty']!, _isDirtyMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WaterEntryRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WaterEntryRow(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      uid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}uid'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}date'])!,
      ml: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}ml'])!,
      lastUpdatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}last_updated_at'])!,
      isDeleted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_deleted'])!,
      isDirty: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_dirty'])!,
    );
  }

  @override
  $WaterEntriesTable createAlias(String alias) {
    return $WaterEntriesTable(attachedDatabase, alias);
  }
}

class WaterEntryRow extends DataClass implements Insertable<WaterEntryRow> {
  final String id;
  final String uid;
  final int date;
  final int ml;
  final int lastUpdatedAt;
  final bool isDeleted;
  final bool isDirty;
  const WaterEntryRow(
      {required this.id,
      required this.uid,
      required this.date,
      required this.ml,
      required this.lastUpdatedAt,
      required this.isDeleted,
      required this.isDirty});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['uid'] = Variable<String>(uid);
    map['date'] = Variable<int>(date);
    map['ml'] = Variable<int>(ml);
    map['last_updated_at'] = Variable<int>(lastUpdatedAt);
    map['is_deleted'] = Variable<bool>(isDeleted);
    map['is_dirty'] = Variable<bool>(isDirty);
    return map;
  }

  WaterEntriesCompanion toCompanion(bool nullToAbsent) {
    return WaterEntriesCompanion(
      id: Value(id),
      uid: Value(uid),
      date: Value(date),
      ml: Value(ml),
      lastUpdatedAt: Value(lastUpdatedAt),
      isDeleted: Value(isDeleted),
      isDirty: Value(isDirty),
    );
  }

  factory WaterEntryRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WaterEntryRow(
      id: serializer.fromJson<String>(json['id']),
      uid: serializer.fromJson<String>(json['uid']),
      date: serializer.fromJson<int>(json['date']),
      ml: serializer.fromJson<int>(json['ml']),
      lastUpdatedAt: serializer.fromJson<int>(json['lastUpdatedAt']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      isDirty: serializer.fromJson<bool>(json['isDirty']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'uid': serializer.toJson<String>(uid),
      'date': serializer.toJson<int>(date),
      'ml': serializer.toJson<int>(ml),
      'lastUpdatedAt': serializer.toJson<int>(lastUpdatedAt),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'isDirty': serializer.toJson<bool>(isDirty),
    };
  }

  WaterEntryRow copyWith(
          {String? id,
          String? uid,
          int? date,
          int? ml,
          int? lastUpdatedAt,
          bool? isDeleted,
          bool? isDirty}) =>
      WaterEntryRow(
        id: id ?? this.id,
        uid: uid ?? this.uid,
        date: date ?? this.date,
        ml: ml ?? this.ml,
        lastUpdatedAt: lastUpdatedAt ?? this.lastUpdatedAt,
        isDeleted: isDeleted ?? this.isDeleted,
        isDirty: isDirty ?? this.isDirty,
      );
  WaterEntryRow copyWithCompanion(WaterEntriesCompanion data) {
    return WaterEntryRow(
      id: data.id.present ? data.id.value : this.id,
      uid: data.uid.present ? data.uid.value : this.uid,
      date: data.date.present ? data.date.value : this.date,
      ml: data.ml.present ? data.ml.value : this.ml,
      lastUpdatedAt: data.lastUpdatedAt.present
          ? data.lastUpdatedAt.value
          : this.lastUpdatedAt,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      isDirty: data.isDirty.present ? data.isDirty.value : this.isDirty,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WaterEntryRow(')
          ..write('id: $id, ')
          ..write('uid: $uid, ')
          ..write('date: $date, ')
          ..write('ml: $ml, ')
          ..write('lastUpdatedAt: $lastUpdatedAt, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('isDirty: $isDirty')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, uid, date, ml, lastUpdatedAt, isDeleted, isDirty);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WaterEntryRow &&
          other.id == this.id &&
          other.uid == this.uid &&
          other.date == this.date &&
          other.ml == this.ml &&
          other.lastUpdatedAt == this.lastUpdatedAt &&
          other.isDeleted == this.isDeleted &&
          other.isDirty == this.isDirty);
}

class WaterEntriesCompanion extends UpdateCompanion<WaterEntryRow> {
  final Value<String> id;
  final Value<String> uid;
  final Value<int> date;
  final Value<int> ml;
  final Value<int> lastUpdatedAt;
  final Value<bool> isDeleted;
  final Value<bool> isDirty;
  final Value<int> rowid;
  const WaterEntriesCompanion({
    this.id = const Value.absent(),
    this.uid = const Value.absent(),
    this.date = const Value.absent(),
    this.ml = const Value.absent(),
    this.lastUpdatedAt = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.isDirty = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WaterEntriesCompanion.insert({
    required String id,
    required String uid,
    required int date,
    required int ml,
    required int lastUpdatedAt,
    this.isDeleted = const Value.absent(),
    this.isDirty = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        uid = Value(uid),
        date = Value(date),
        ml = Value(ml),
        lastUpdatedAt = Value(lastUpdatedAt);
  static Insertable<WaterEntryRow> custom({
    Expression<String>? id,
    Expression<String>? uid,
    Expression<int>? date,
    Expression<int>? ml,
    Expression<int>? lastUpdatedAt,
    Expression<bool>? isDeleted,
    Expression<bool>? isDirty,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uid != null) 'uid': uid,
      if (date != null) 'date': date,
      if (ml != null) 'ml': ml,
      if (lastUpdatedAt != null) 'last_updated_at': lastUpdatedAt,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (isDirty != null) 'is_dirty': isDirty,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WaterEntriesCompanion copyWith(
      {Value<String>? id,
      Value<String>? uid,
      Value<int>? date,
      Value<int>? ml,
      Value<int>? lastUpdatedAt,
      Value<bool>? isDeleted,
      Value<bool>? isDirty,
      Value<int>? rowid}) {
    return WaterEntriesCompanion(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      date: date ?? this.date,
      ml: ml ?? this.ml,
      lastUpdatedAt: lastUpdatedAt ?? this.lastUpdatedAt,
      isDeleted: isDeleted ?? this.isDeleted,
      isDirty: isDirty ?? this.isDirty,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (uid.present) {
      map['uid'] = Variable<String>(uid.value);
    }
    if (date.present) {
      map['date'] = Variable<int>(date.value);
    }
    if (ml.present) {
      map['ml'] = Variable<int>(ml.value);
    }
    if (lastUpdatedAt.present) {
      map['last_updated_at'] = Variable<int>(lastUpdatedAt.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (isDirty.present) {
      map['is_dirty'] = Variable<bool>(isDirty.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WaterEntriesCompanion(')
          ..write('id: $id, ')
          ..write('uid: $uid, ')
          ..write('date: $date, ')
          ..write('ml: $ml, ')
          ..write('lastUpdatedAt: $lastUpdatedAt, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('isDirty: $isDirty, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FoodEntriesTable extends FoodEntries
    with TableInfo<$FoodEntriesTable, FoodEntryRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FoodEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _uidMeta = const VerificationMeta('uid');
  @override
  late final GeneratedColumn<String> uid = GeneratedColumn<String>(
      'uid', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _recordedAtMeta =
      const VerificationMeta('recordedAt');
  @override
  late final GeneratedColumn<int> recordedAt = GeneratedColumn<int>(
      'date_time', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _mealTypeMeta =
      const VerificationMeta('mealType');
  @override
  late final GeneratedColumnWithTypeConverter<MealType, String> mealType =
      GeneratedColumn<String>('meal_type', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<MealType>($FoodEntriesTable.$convertermealType);
  static const VerificationMeta _itemsMeta = const VerificationMeta('items');
  @override
  late final GeneratedColumnWithTypeConverter<List<FoodItem>, String> items =
      GeneratedColumn<String>('items', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<List<FoodItem>>($FoodEntriesTable.$converteritems);
  static const VerificationMeta _totalsMeta = const VerificationMeta('totals');
  @override
  late final GeneratedColumnWithTypeConverter<FoodTotals, String> totals =
      GeneratedColumn<String>('totals', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<FoodTotals>($FoodEntriesTable.$convertertotals);
  static const VerificationMeta _lastUpdatedAtMeta =
      const VerificationMeta('lastUpdatedAt');
  @override
  late final GeneratedColumn<int> lastUpdatedAt = GeneratedColumn<int>(
      'last_updated_at', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _isDeletedMeta =
      const VerificationMeta('isDeleted');
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
      'is_deleted', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_deleted" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _isDirtyMeta =
      const VerificationMeta('isDirty');
  @override
  late final GeneratedColumn<bool> isDirty = GeneratedColumn<bool>(
      'is_dirty', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_dirty" IN (0, 1))'),
      defaultValue: const Constant(true));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        uid,
        recordedAt,
        mealType,
        items,
        totals,
        lastUpdatedAt,
        isDeleted,
        isDirty
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'food_entries';
  @override
  VerificationContext validateIntegrity(Insertable<FoodEntryRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('uid')) {
      context.handle(
          _uidMeta, uid.isAcceptableOrUnknown(data['uid']!, _uidMeta));
    } else if (isInserting) {
      context.missing(_uidMeta);
    }
    if (data.containsKey('date_time')) {
      context.handle(
          _recordedAtMeta,
          recordedAt.isAcceptableOrUnknown(
              data['date_time']!, _recordedAtMeta));
    } else if (isInserting) {
      context.missing(_recordedAtMeta);
    }
    context.handle(_mealTypeMeta, const VerificationResult.success());
    context.handle(_itemsMeta, const VerificationResult.success());
    context.handle(_totalsMeta, const VerificationResult.success());
    if (data.containsKey('last_updated_at')) {
      context.handle(
          _lastUpdatedAtMeta,
          lastUpdatedAt.isAcceptableOrUnknown(
              data['last_updated_at']!, _lastUpdatedAtMeta));
    } else if (isInserting) {
      context.missing(_lastUpdatedAtMeta);
    }
    if (data.containsKey('is_deleted')) {
      context.handle(_isDeletedMeta,
          isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta));
    }
    if (data.containsKey('is_dirty')) {
      context.handle(_isDirtyMeta,
          isDirty.isAcceptableOrUnknown(data['is_dirty']!, _isDirtyMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FoodEntryRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FoodEntryRow(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      uid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}uid'])!,
      recordedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}date_time'])!,
      mealType: $FoodEntriesTable.$convertermealType.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}meal_type'])!),
      items: $FoodEntriesTable.$converteritems.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}items'])!),
      totals: $FoodEntriesTable.$convertertotals.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}totals'])!),
      lastUpdatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}last_updated_at'])!,
      isDeleted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_deleted'])!,
      isDirty: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_dirty'])!,
    );
  }

  @override
  $FoodEntriesTable createAlias(String alias) {
    return $FoodEntriesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<MealType, String, String> $convertermealType =
      const EnumNameConverter<MealType>(MealType.values);
  static TypeConverter<List<FoodItem>, String> $converteritems =
      const FoodItemsConverter();
  static TypeConverter<FoodTotals, String> $convertertotals =
      const FoodTotalsConverter();
}

class FoodEntryRow extends DataClass implements Insertable<FoodEntryRow> {
  final String id;
  final String uid;
  final int recordedAt;
  final MealType mealType;
  final List<FoodItem> items;
  final FoodTotals totals;
  final int lastUpdatedAt;
  final bool isDeleted;
  final bool isDirty;
  const FoodEntryRow(
      {required this.id,
      required this.uid,
      required this.recordedAt,
      required this.mealType,
      required this.items,
      required this.totals,
      required this.lastUpdatedAt,
      required this.isDeleted,
      required this.isDirty});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['uid'] = Variable<String>(uid);
    map['date_time'] = Variable<int>(recordedAt);
    {
      map['meal_type'] = Variable<String>(
          $FoodEntriesTable.$convertermealType.toSql(mealType));
    }
    {
      map['items'] =
          Variable<String>($FoodEntriesTable.$converteritems.toSql(items));
    }
    {
      map['totals'] =
          Variable<String>($FoodEntriesTable.$convertertotals.toSql(totals));
    }
    map['last_updated_at'] = Variable<int>(lastUpdatedAt);
    map['is_deleted'] = Variable<bool>(isDeleted);
    map['is_dirty'] = Variable<bool>(isDirty);
    return map;
  }

  FoodEntriesCompanion toCompanion(bool nullToAbsent) {
    return FoodEntriesCompanion(
      id: Value(id),
      uid: Value(uid),
      recordedAt: Value(recordedAt),
      mealType: Value(mealType),
      items: Value(items),
      totals: Value(totals),
      lastUpdatedAt: Value(lastUpdatedAt),
      isDeleted: Value(isDeleted),
      isDirty: Value(isDirty),
    );
  }

  factory FoodEntryRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FoodEntryRow(
      id: serializer.fromJson<String>(json['id']),
      uid: serializer.fromJson<String>(json['uid']),
      recordedAt: serializer.fromJson<int>(json['recordedAt']),
      mealType: $FoodEntriesTable.$convertermealType
          .fromJson(serializer.fromJson<String>(json['mealType'])),
      items: serializer.fromJson<List<FoodItem>>(json['items']),
      totals: serializer.fromJson<FoodTotals>(json['totals']),
      lastUpdatedAt: serializer.fromJson<int>(json['lastUpdatedAt']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      isDirty: serializer.fromJson<bool>(json['isDirty']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'uid': serializer.toJson<String>(uid),
      'recordedAt': serializer.toJson<int>(recordedAt),
      'mealType': serializer.toJson<String>(
          $FoodEntriesTable.$convertermealType.toJson(mealType)),
      'items': serializer.toJson<List<FoodItem>>(items),
      'totals': serializer.toJson<FoodTotals>(totals),
      'lastUpdatedAt': serializer.toJson<int>(lastUpdatedAt),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'isDirty': serializer.toJson<bool>(isDirty),
    };
  }

  FoodEntryRow copyWith(
          {String? id,
          String? uid,
          int? recordedAt,
          MealType? mealType,
          List<FoodItem>? items,
          FoodTotals? totals,
          int? lastUpdatedAt,
          bool? isDeleted,
          bool? isDirty}) =>
      FoodEntryRow(
        id: id ?? this.id,
        uid: uid ?? this.uid,
        recordedAt: recordedAt ?? this.recordedAt,
        mealType: mealType ?? this.mealType,
        items: items ?? this.items,
        totals: totals ?? this.totals,
        lastUpdatedAt: lastUpdatedAt ?? this.lastUpdatedAt,
        isDeleted: isDeleted ?? this.isDeleted,
        isDirty: isDirty ?? this.isDirty,
      );
  FoodEntryRow copyWithCompanion(FoodEntriesCompanion data) {
    return FoodEntryRow(
      id: data.id.present ? data.id.value : this.id,
      uid: data.uid.present ? data.uid.value : this.uid,
      recordedAt:
          data.recordedAt.present ? data.recordedAt.value : this.recordedAt,
      mealType: data.mealType.present ? data.mealType.value : this.mealType,
      items: data.items.present ? data.items.value : this.items,
      totals: data.totals.present ? data.totals.value : this.totals,
      lastUpdatedAt: data.lastUpdatedAt.present
          ? data.lastUpdatedAt.value
          : this.lastUpdatedAt,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      isDirty: data.isDirty.present ? data.isDirty.value : this.isDirty,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FoodEntryRow(')
          ..write('id: $id, ')
          ..write('uid: $uid, ')
          ..write('recordedAt: $recordedAt, ')
          ..write('mealType: $mealType, ')
          ..write('items: $items, ')
          ..write('totals: $totals, ')
          ..write('lastUpdatedAt: $lastUpdatedAt, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('isDirty: $isDirty')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, uid, recordedAt, mealType, items, totals,
      lastUpdatedAt, isDeleted, isDirty);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FoodEntryRow &&
          other.id == this.id &&
          other.uid == this.uid &&
          other.recordedAt == this.recordedAt &&
          other.mealType == this.mealType &&
          other.items == this.items &&
          other.totals == this.totals &&
          other.lastUpdatedAt == this.lastUpdatedAt &&
          other.isDeleted == this.isDeleted &&
          other.isDirty == this.isDirty);
}

class FoodEntriesCompanion extends UpdateCompanion<FoodEntryRow> {
  final Value<String> id;
  final Value<String> uid;
  final Value<int> recordedAt;
  final Value<MealType> mealType;
  final Value<List<FoodItem>> items;
  final Value<FoodTotals> totals;
  final Value<int> lastUpdatedAt;
  final Value<bool> isDeleted;
  final Value<bool> isDirty;
  final Value<int> rowid;
  const FoodEntriesCompanion({
    this.id = const Value.absent(),
    this.uid = const Value.absent(),
    this.recordedAt = const Value.absent(),
    this.mealType = const Value.absent(),
    this.items = const Value.absent(),
    this.totals = const Value.absent(),
    this.lastUpdatedAt = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.isDirty = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FoodEntriesCompanion.insert({
    required String id,
    required String uid,
    required int recordedAt,
    required MealType mealType,
    required List<FoodItem> items,
    required FoodTotals totals,
    required int lastUpdatedAt,
    this.isDeleted = const Value.absent(),
    this.isDirty = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        uid = Value(uid),
        recordedAt = Value(recordedAt),
        mealType = Value(mealType),
        items = Value(items),
        totals = Value(totals),
        lastUpdatedAt = Value(lastUpdatedAt);
  static Insertable<FoodEntryRow> custom({
    Expression<String>? id,
    Expression<String>? uid,
    Expression<int>? recordedAt,
    Expression<String>? mealType,
    Expression<String>? items,
    Expression<String>? totals,
    Expression<int>? lastUpdatedAt,
    Expression<bool>? isDeleted,
    Expression<bool>? isDirty,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uid != null) 'uid': uid,
      if (recordedAt != null) 'date_time': recordedAt,
      if (mealType != null) 'meal_type': mealType,
      if (items != null) 'items': items,
      if (totals != null) 'totals': totals,
      if (lastUpdatedAt != null) 'last_updated_at': lastUpdatedAt,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (isDirty != null) 'is_dirty': isDirty,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FoodEntriesCompanion copyWith(
      {Value<String>? id,
      Value<String>? uid,
      Value<int>? recordedAt,
      Value<MealType>? mealType,
      Value<List<FoodItem>>? items,
      Value<FoodTotals>? totals,
      Value<int>? lastUpdatedAt,
      Value<bool>? isDeleted,
      Value<bool>? isDirty,
      Value<int>? rowid}) {
    return FoodEntriesCompanion(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      recordedAt: recordedAt ?? this.recordedAt,
      mealType: mealType ?? this.mealType,
      items: items ?? this.items,
      totals: totals ?? this.totals,
      lastUpdatedAt: lastUpdatedAt ?? this.lastUpdatedAt,
      isDeleted: isDeleted ?? this.isDeleted,
      isDirty: isDirty ?? this.isDirty,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (uid.present) {
      map['uid'] = Variable<String>(uid.value);
    }
    if (recordedAt.present) {
      map['date_time'] = Variable<int>(recordedAt.value);
    }
    if (mealType.present) {
      map['meal_type'] = Variable<String>(
          $FoodEntriesTable.$convertermealType.toSql(mealType.value));
    }
    if (items.present) {
      map['items'] = Variable<String>(
          $FoodEntriesTable.$converteritems.toSql(items.value));
    }
    if (totals.present) {
      map['totals'] = Variable<String>(
          $FoodEntriesTable.$convertertotals.toSql(totals.value));
    }
    if (lastUpdatedAt.present) {
      map['last_updated_at'] = Variable<int>(lastUpdatedAt.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (isDirty.present) {
      map['is_dirty'] = Variable<bool>(isDirty.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FoodEntriesCompanion(')
          ..write('id: $id, ')
          ..write('uid: $uid, ')
          ..write('recordedAt: $recordedAt, ')
          ..write('mealType: $mealType, ')
          ..write('items: $items, ')
          ..write('totals: $totals, ')
          ..write('lastUpdatedAt: $lastUpdatedAt, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('isDirty: $isDirty, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CustomFoodsTable extends CustomFoods
    with TableInfo<$CustomFoodsTable, CustomFoodRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CustomFoodsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _uidMeta = const VerificationMeta('uid');
  @override
  late final GeneratedColumn<String> uid = GeneratedColumn<String>(
      'uid', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameTrMeta = const VerificationMeta('nameTr');
  @override
  late final GeneratedColumn<String> nameTr = GeneratedColumn<String>(
      'name_tr', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameEnMeta = const VerificationMeta('nameEn');
  @override
  late final GeneratedColumn<String> nameEn = GeneratedColumn<String>(
      'name_en', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _barcodeMeta =
      const VerificationMeta('barcode');
  @override
  late final GeneratedColumn<String> barcode = GeneratedColumn<String>(
      'barcode', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _calMeta = const VerificationMeta('cal');
  @override
  late final GeneratedColumn<double> cal = GeneratedColumn<double>(
      'cal', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _proteinMeta =
      const VerificationMeta('protein');
  @override
  late final GeneratedColumn<double> protein = GeneratedColumn<double>(
      'protein', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _carbMeta = const VerificationMeta('carb');
  @override
  late final GeneratedColumn<double> carb = GeneratedColumn<double>(
      'carb', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _fatMeta = const VerificationMeta('fat');
  @override
  late final GeneratedColumn<double> fat = GeneratedColumn<double>(
      'fat', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _fiberMeta = const VerificationMeta('fiber');
  @override
  late final GeneratedColumn<double> fiber = GeneratedColumn<double>(
      'fiber', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _sodiumMeta = const VerificationMeta('sodium');
  @override
  late final GeneratedColumn<double> sodium = GeneratedColumn<double>(
      'sodium', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _sugarMeta = const VerificationMeta('sugar');
  @override
  late final GeneratedColumn<double> sugar = GeneratedColumn<double>(
      'sugar', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _lastUpdatedAtMeta =
      const VerificationMeta('lastUpdatedAt');
  @override
  late final GeneratedColumn<int> lastUpdatedAt = GeneratedColumn<int>(
      'last_updated_at', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _isDeletedMeta =
      const VerificationMeta('isDeleted');
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
      'is_deleted', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_deleted" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _isDirtyMeta =
      const VerificationMeta('isDirty');
  @override
  late final GeneratedColumn<bool> isDirty = GeneratedColumn<bool>(
      'is_dirty', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_dirty" IN (0, 1))'),
      defaultValue: const Constant(true));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        uid,
        nameTr,
        nameEn,
        barcode,
        cal,
        protein,
        carb,
        fat,
        fiber,
        sodium,
        sugar,
        lastUpdatedAt,
        isDeleted,
        isDirty
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'custom_foods';
  @override
  VerificationContext validateIntegrity(Insertable<CustomFoodRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('uid')) {
      context.handle(
          _uidMeta, uid.isAcceptableOrUnknown(data['uid']!, _uidMeta));
    } else if (isInserting) {
      context.missing(_uidMeta);
    }
    if (data.containsKey('name_tr')) {
      context.handle(_nameTrMeta,
          nameTr.isAcceptableOrUnknown(data['name_tr']!, _nameTrMeta));
    } else if (isInserting) {
      context.missing(_nameTrMeta);
    }
    if (data.containsKey('name_en')) {
      context.handle(_nameEnMeta,
          nameEn.isAcceptableOrUnknown(data['name_en']!, _nameEnMeta));
    } else if (isInserting) {
      context.missing(_nameEnMeta);
    }
    if (data.containsKey('barcode')) {
      context.handle(_barcodeMeta,
          barcode.isAcceptableOrUnknown(data['barcode']!, _barcodeMeta));
    }
    if (data.containsKey('cal')) {
      context.handle(
          _calMeta, cal.isAcceptableOrUnknown(data['cal']!, _calMeta));
    } else if (isInserting) {
      context.missing(_calMeta);
    }
    if (data.containsKey('protein')) {
      context.handle(_proteinMeta,
          protein.isAcceptableOrUnknown(data['protein']!, _proteinMeta));
    } else if (isInserting) {
      context.missing(_proteinMeta);
    }
    if (data.containsKey('carb')) {
      context.handle(
          _carbMeta, carb.isAcceptableOrUnknown(data['carb']!, _carbMeta));
    } else if (isInserting) {
      context.missing(_carbMeta);
    }
    if (data.containsKey('fat')) {
      context.handle(
          _fatMeta, fat.isAcceptableOrUnknown(data['fat']!, _fatMeta));
    } else if (isInserting) {
      context.missing(_fatMeta);
    }
    if (data.containsKey('fiber')) {
      context.handle(
          _fiberMeta, fiber.isAcceptableOrUnknown(data['fiber']!, _fiberMeta));
    }
    if (data.containsKey('sodium')) {
      context.handle(_sodiumMeta,
          sodium.isAcceptableOrUnknown(data['sodium']!, _sodiumMeta));
    }
    if (data.containsKey('sugar')) {
      context.handle(
          _sugarMeta, sugar.isAcceptableOrUnknown(data['sugar']!, _sugarMeta));
    }
    if (data.containsKey('last_updated_at')) {
      context.handle(
          _lastUpdatedAtMeta,
          lastUpdatedAt.isAcceptableOrUnknown(
              data['last_updated_at']!, _lastUpdatedAtMeta));
    } else if (isInserting) {
      context.missing(_lastUpdatedAtMeta);
    }
    if (data.containsKey('is_deleted')) {
      context.handle(_isDeletedMeta,
          isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta));
    }
    if (data.containsKey('is_dirty')) {
      context.handle(_isDirtyMeta,
          isDirty.isAcceptableOrUnknown(data['is_dirty']!, _isDirtyMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CustomFoodRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CustomFoodRow(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      uid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}uid'])!,
      nameTr: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name_tr'])!,
      nameEn: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name_en'])!,
      barcode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}barcode']),
      cal: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}cal'])!,
      protein: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}protein'])!,
      carb: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}carb'])!,
      fat: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}fat'])!,
      fiber: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}fiber']),
      sodium: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}sodium']),
      sugar: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}sugar']),
      lastUpdatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}last_updated_at'])!,
      isDeleted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_deleted'])!,
      isDirty: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_dirty'])!,
    );
  }

  @override
  $CustomFoodsTable createAlias(String alias) {
    return $CustomFoodsTable(attachedDatabase, alias);
  }
}

class CustomFoodRow extends DataClass implements Insertable<CustomFoodRow> {
  final String id;
  final String uid;
  final String nameTr;
  final String nameEn;
  final String? barcode;
  final double cal;
  final double protein;
  final double carb;
  final double fat;
  final double? fiber;
  final double? sodium;
  final double? sugar;
  final int lastUpdatedAt;
  final bool isDeleted;
  final bool isDirty;
  const CustomFoodRow(
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
      required this.lastUpdatedAt,
      required this.isDeleted,
      required this.isDirty});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['uid'] = Variable<String>(uid);
    map['name_tr'] = Variable<String>(nameTr);
    map['name_en'] = Variable<String>(nameEn);
    if (!nullToAbsent || barcode != null) {
      map['barcode'] = Variable<String>(barcode);
    }
    map['cal'] = Variable<double>(cal);
    map['protein'] = Variable<double>(protein);
    map['carb'] = Variable<double>(carb);
    map['fat'] = Variable<double>(fat);
    if (!nullToAbsent || fiber != null) {
      map['fiber'] = Variable<double>(fiber);
    }
    if (!nullToAbsent || sodium != null) {
      map['sodium'] = Variable<double>(sodium);
    }
    if (!nullToAbsent || sugar != null) {
      map['sugar'] = Variable<double>(sugar);
    }
    map['last_updated_at'] = Variable<int>(lastUpdatedAt);
    map['is_deleted'] = Variable<bool>(isDeleted);
    map['is_dirty'] = Variable<bool>(isDirty);
    return map;
  }

  CustomFoodsCompanion toCompanion(bool nullToAbsent) {
    return CustomFoodsCompanion(
      id: Value(id),
      uid: Value(uid),
      nameTr: Value(nameTr),
      nameEn: Value(nameEn),
      barcode: barcode == null && nullToAbsent
          ? const Value.absent()
          : Value(barcode),
      cal: Value(cal),
      protein: Value(protein),
      carb: Value(carb),
      fat: Value(fat),
      fiber:
          fiber == null && nullToAbsent ? const Value.absent() : Value(fiber),
      sodium:
          sodium == null && nullToAbsent ? const Value.absent() : Value(sodium),
      sugar:
          sugar == null && nullToAbsent ? const Value.absent() : Value(sugar),
      lastUpdatedAt: Value(lastUpdatedAt),
      isDeleted: Value(isDeleted),
      isDirty: Value(isDirty),
    );
  }

  factory CustomFoodRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CustomFoodRow(
      id: serializer.fromJson<String>(json['id']),
      uid: serializer.fromJson<String>(json['uid']),
      nameTr: serializer.fromJson<String>(json['nameTr']),
      nameEn: serializer.fromJson<String>(json['nameEn']),
      barcode: serializer.fromJson<String?>(json['barcode']),
      cal: serializer.fromJson<double>(json['cal']),
      protein: serializer.fromJson<double>(json['protein']),
      carb: serializer.fromJson<double>(json['carb']),
      fat: serializer.fromJson<double>(json['fat']),
      fiber: serializer.fromJson<double?>(json['fiber']),
      sodium: serializer.fromJson<double?>(json['sodium']),
      sugar: serializer.fromJson<double?>(json['sugar']),
      lastUpdatedAt: serializer.fromJson<int>(json['lastUpdatedAt']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      isDirty: serializer.fromJson<bool>(json['isDirty']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'uid': serializer.toJson<String>(uid),
      'nameTr': serializer.toJson<String>(nameTr),
      'nameEn': serializer.toJson<String>(nameEn),
      'barcode': serializer.toJson<String?>(barcode),
      'cal': serializer.toJson<double>(cal),
      'protein': serializer.toJson<double>(protein),
      'carb': serializer.toJson<double>(carb),
      'fat': serializer.toJson<double>(fat),
      'fiber': serializer.toJson<double?>(fiber),
      'sodium': serializer.toJson<double?>(sodium),
      'sugar': serializer.toJson<double?>(sugar),
      'lastUpdatedAt': serializer.toJson<int>(lastUpdatedAt),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'isDirty': serializer.toJson<bool>(isDirty),
    };
  }

  CustomFoodRow copyWith(
          {String? id,
          String? uid,
          String? nameTr,
          String? nameEn,
          Value<String?> barcode = const Value.absent(),
          double? cal,
          double? protein,
          double? carb,
          double? fat,
          Value<double?> fiber = const Value.absent(),
          Value<double?> sodium = const Value.absent(),
          Value<double?> sugar = const Value.absent(),
          int? lastUpdatedAt,
          bool? isDeleted,
          bool? isDirty}) =>
      CustomFoodRow(
        id: id ?? this.id,
        uid: uid ?? this.uid,
        nameTr: nameTr ?? this.nameTr,
        nameEn: nameEn ?? this.nameEn,
        barcode: barcode.present ? barcode.value : this.barcode,
        cal: cal ?? this.cal,
        protein: protein ?? this.protein,
        carb: carb ?? this.carb,
        fat: fat ?? this.fat,
        fiber: fiber.present ? fiber.value : this.fiber,
        sodium: sodium.present ? sodium.value : this.sodium,
        sugar: sugar.present ? sugar.value : this.sugar,
        lastUpdatedAt: lastUpdatedAt ?? this.lastUpdatedAt,
        isDeleted: isDeleted ?? this.isDeleted,
        isDirty: isDirty ?? this.isDirty,
      );
  CustomFoodRow copyWithCompanion(CustomFoodsCompanion data) {
    return CustomFoodRow(
      id: data.id.present ? data.id.value : this.id,
      uid: data.uid.present ? data.uid.value : this.uid,
      nameTr: data.nameTr.present ? data.nameTr.value : this.nameTr,
      nameEn: data.nameEn.present ? data.nameEn.value : this.nameEn,
      barcode: data.barcode.present ? data.barcode.value : this.barcode,
      cal: data.cal.present ? data.cal.value : this.cal,
      protein: data.protein.present ? data.protein.value : this.protein,
      carb: data.carb.present ? data.carb.value : this.carb,
      fat: data.fat.present ? data.fat.value : this.fat,
      fiber: data.fiber.present ? data.fiber.value : this.fiber,
      sodium: data.sodium.present ? data.sodium.value : this.sodium,
      sugar: data.sugar.present ? data.sugar.value : this.sugar,
      lastUpdatedAt: data.lastUpdatedAt.present
          ? data.lastUpdatedAt.value
          : this.lastUpdatedAt,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      isDirty: data.isDirty.present ? data.isDirty.value : this.isDirty,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CustomFoodRow(')
          ..write('id: $id, ')
          ..write('uid: $uid, ')
          ..write('nameTr: $nameTr, ')
          ..write('nameEn: $nameEn, ')
          ..write('barcode: $barcode, ')
          ..write('cal: $cal, ')
          ..write('protein: $protein, ')
          ..write('carb: $carb, ')
          ..write('fat: $fat, ')
          ..write('fiber: $fiber, ')
          ..write('sodium: $sodium, ')
          ..write('sugar: $sugar, ')
          ..write('lastUpdatedAt: $lastUpdatedAt, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('isDirty: $isDirty')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      uid,
      nameTr,
      nameEn,
      barcode,
      cal,
      protein,
      carb,
      fat,
      fiber,
      sodium,
      sugar,
      lastUpdatedAt,
      isDeleted,
      isDirty);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CustomFoodRow &&
          other.id == this.id &&
          other.uid == this.uid &&
          other.nameTr == this.nameTr &&
          other.nameEn == this.nameEn &&
          other.barcode == this.barcode &&
          other.cal == this.cal &&
          other.protein == this.protein &&
          other.carb == this.carb &&
          other.fat == this.fat &&
          other.fiber == this.fiber &&
          other.sodium == this.sodium &&
          other.sugar == this.sugar &&
          other.lastUpdatedAt == this.lastUpdatedAt &&
          other.isDeleted == this.isDeleted &&
          other.isDirty == this.isDirty);
}

class CustomFoodsCompanion extends UpdateCompanion<CustomFoodRow> {
  final Value<String> id;
  final Value<String> uid;
  final Value<String> nameTr;
  final Value<String> nameEn;
  final Value<String?> barcode;
  final Value<double> cal;
  final Value<double> protein;
  final Value<double> carb;
  final Value<double> fat;
  final Value<double?> fiber;
  final Value<double?> sodium;
  final Value<double?> sugar;
  final Value<int> lastUpdatedAt;
  final Value<bool> isDeleted;
  final Value<bool> isDirty;
  final Value<int> rowid;
  const CustomFoodsCompanion({
    this.id = const Value.absent(),
    this.uid = const Value.absent(),
    this.nameTr = const Value.absent(),
    this.nameEn = const Value.absent(),
    this.barcode = const Value.absent(),
    this.cal = const Value.absent(),
    this.protein = const Value.absent(),
    this.carb = const Value.absent(),
    this.fat = const Value.absent(),
    this.fiber = const Value.absent(),
    this.sodium = const Value.absent(),
    this.sugar = const Value.absent(),
    this.lastUpdatedAt = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.isDirty = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CustomFoodsCompanion.insert({
    required String id,
    required String uid,
    required String nameTr,
    required String nameEn,
    this.barcode = const Value.absent(),
    required double cal,
    required double protein,
    required double carb,
    required double fat,
    this.fiber = const Value.absent(),
    this.sodium = const Value.absent(),
    this.sugar = const Value.absent(),
    required int lastUpdatedAt,
    this.isDeleted = const Value.absent(),
    this.isDirty = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        uid = Value(uid),
        nameTr = Value(nameTr),
        nameEn = Value(nameEn),
        cal = Value(cal),
        protein = Value(protein),
        carb = Value(carb),
        fat = Value(fat),
        lastUpdatedAt = Value(lastUpdatedAt);
  static Insertable<CustomFoodRow> custom({
    Expression<String>? id,
    Expression<String>? uid,
    Expression<String>? nameTr,
    Expression<String>? nameEn,
    Expression<String>? barcode,
    Expression<double>? cal,
    Expression<double>? protein,
    Expression<double>? carb,
    Expression<double>? fat,
    Expression<double>? fiber,
    Expression<double>? sodium,
    Expression<double>? sugar,
    Expression<int>? lastUpdatedAt,
    Expression<bool>? isDeleted,
    Expression<bool>? isDirty,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uid != null) 'uid': uid,
      if (nameTr != null) 'name_tr': nameTr,
      if (nameEn != null) 'name_en': nameEn,
      if (barcode != null) 'barcode': barcode,
      if (cal != null) 'cal': cal,
      if (protein != null) 'protein': protein,
      if (carb != null) 'carb': carb,
      if (fat != null) 'fat': fat,
      if (fiber != null) 'fiber': fiber,
      if (sodium != null) 'sodium': sodium,
      if (sugar != null) 'sugar': sugar,
      if (lastUpdatedAt != null) 'last_updated_at': lastUpdatedAt,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (isDirty != null) 'is_dirty': isDirty,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CustomFoodsCompanion copyWith(
      {Value<String>? id,
      Value<String>? uid,
      Value<String>? nameTr,
      Value<String>? nameEn,
      Value<String?>? barcode,
      Value<double>? cal,
      Value<double>? protein,
      Value<double>? carb,
      Value<double>? fat,
      Value<double?>? fiber,
      Value<double?>? sodium,
      Value<double?>? sugar,
      Value<int>? lastUpdatedAt,
      Value<bool>? isDeleted,
      Value<bool>? isDirty,
      Value<int>? rowid}) {
    return CustomFoodsCompanion(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      nameTr: nameTr ?? this.nameTr,
      nameEn: nameEn ?? this.nameEn,
      barcode: barcode ?? this.barcode,
      cal: cal ?? this.cal,
      protein: protein ?? this.protein,
      carb: carb ?? this.carb,
      fat: fat ?? this.fat,
      fiber: fiber ?? this.fiber,
      sodium: sodium ?? this.sodium,
      sugar: sugar ?? this.sugar,
      lastUpdatedAt: lastUpdatedAt ?? this.lastUpdatedAt,
      isDeleted: isDeleted ?? this.isDeleted,
      isDirty: isDirty ?? this.isDirty,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (uid.present) {
      map['uid'] = Variable<String>(uid.value);
    }
    if (nameTr.present) {
      map['name_tr'] = Variable<String>(nameTr.value);
    }
    if (nameEn.present) {
      map['name_en'] = Variable<String>(nameEn.value);
    }
    if (barcode.present) {
      map['barcode'] = Variable<String>(barcode.value);
    }
    if (cal.present) {
      map['cal'] = Variable<double>(cal.value);
    }
    if (protein.present) {
      map['protein'] = Variable<double>(protein.value);
    }
    if (carb.present) {
      map['carb'] = Variable<double>(carb.value);
    }
    if (fat.present) {
      map['fat'] = Variable<double>(fat.value);
    }
    if (fiber.present) {
      map['fiber'] = Variable<double>(fiber.value);
    }
    if (sodium.present) {
      map['sodium'] = Variable<double>(sodium.value);
    }
    if (sugar.present) {
      map['sugar'] = Variable<double>(sugar.value);
    }
    if (lastUpdatedAt.present) {
      map['last_updated_at'] = Variable<int>(lastUpdatedAt.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (isDirty.present) {
      map['is_dirty'] = Variable<bool>(isDirty.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CustomFoodsCompanion(')
          ..write('id: $id, ')
          ..write('uid: $uid, ')
          ..write('nameTr: $nameTr, ')
          ..write('nameEn: $nameEn, ')
          ..write('barcode: $barcode, ')
          ..write('cal: $cal, ')
          ..write('protein: $protein, ')
          ..write('carb: $carb, ')
          ..write('fat: $fat, ')
          ..write('fiber: $fiber, ')
          ..write('sodium: $sodium, ')
          ..write('sugar: $sugar, ')
          ..write('lastUpdatedAt: $lastUpdatedAt, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('isDirty: $isDirty, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FastingSessionsTable extends FastingSessions
    with TableInfo<$FastingSessionsTable, FastingSessionRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FastingSessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _uidMeta = const VerificationMeta('uid');
  @override
  late final GeneratedColumn<String> uid = GeneratedColumn<String>(
      'uid', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _startMeta = const VerificationMeta('start');
  @override
  late final GeneratedColumn<int> start = GeneratedColumn<int>(
      'start', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _endMeta = const VerificationMeta('end');
  @override
  late final GeneratedColumn<int> end = GeneratedColumn<int>(
      'end', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _planTypeMeta =
      const VerificationMeta('planType');
  @override
  late final GeneratedColumnWithTypeConverter<FastingPlanType, String>
      planType = GeneratedColumn<String>('plan_type', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<FastingPlanType>(
              $FastingSessionsTable.$converterplanType);
  static const VerificationMeta _goalHoursMeta =
      const VerificationMeta('goalHours');
  @override
  late final GeneratedColumn<int> goalHours = GeneratedColumn<int>(
      'goal_hours', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _completedMeta =
      const VerificationMeta('completed');
  @override
  late final GeneratedColumn<bool> completed = GeneratedColumn<bool>(
      'completed', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("completed" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _lastUpdatedAtMeta =
      const VerificationMeta('lastUpdatedAt');
  @override
  late final GeneratedColumn<int> lastUpdatedAt = GeneratedColumn<int>(
      'last_updated_at', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _isDeletedMeta =
      const VerificationMeta('isDeleted');
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
      'is_deleted', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_deleted" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _isDirtyMeta =
      const VerificationMeta('isDirty');
  @override
  late final GeneratedColumn<bool> isDirty = GeneratedColumn<bool>(
      'is_dirty', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_dirty" IN (0, 1))'),
      defaultValue: const Constant(true));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        uid,
        start,
        end,
        planType,
        goalHours,
        completed,
        lastUpdatedAt,
        isDeleted,
        isDirty
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'fasting_sessions';
  @override
  VerificationContext validateIntegrity(Insertable<FastingSessionRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('uid')) {
      context.handle(
          _uidMeta, uid.isAcceptableOrUnknown(data['uid']!, _uidMeta));
    } else if (isInserting) {
      context.missing(_uidMeta);
    }
    if (data.containsKey('start')) {
      context.handle(
          _startMeta, start.isAcceptableOrUnknown(data['start']!, _startMeta));
    } else if (isInserting) {
      context.missing(_startMeta);
    }
    if (data.containsKey('end')) {
      context.handle(
          _endMeta, end.isAcceptableOrUnknown(data['end']!, _endMeta));
    }
    context.handle(_planTypeMeta, const VerificationResult.success());
    if (data.containsKey('goal_hours')) {
      context.handle(_goalHoursMeta,
          goalHours.isAcceptableOrUnknown(data['goal_hours']!, _goalHoursMeta));
    } else if (isInserting) {
      context.missing(_goalHoursMeta);
    }
    if (data.containsKey('completed')) {
      context.handle(_completedMeta,
          completed.isAcceptableOrUnknown(data['completed']!, _completedMeta));
    }
    if (data.containsKey('last_updated_at')) {
      context.handle(
          _lastUpdatedAtMeta,
          lastUpdatedAt.isAcceptableOrUnknown(
              data['last_updated_at']!, _lastUpdatedAtMeta));
    } else if (isInserting) {
      context.missing(_lastUpdatedAtMeta);
    }
    if (data.containsKey('is_deleted')) {
      context.handle(_isDeletedMeta,
          isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta));
    }
    if (data.containsKey('is_dirty')) {
      context.handle(_isDirtyMeta,
          isDirty.isAcceptableOrUnknown(data['is_dirty']!, _isDirtyMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FastingSessionRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FastingSessionRow(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      uid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}uid'])!,
      start: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}start'])!,
      end: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}end']),
      planType: $FastingSessionsTable.$converterplanType.fromSql(
          attachedDatabase.typeMapping
              .read(DriftSqlType.string, data['${effectivePrefix}plan_type'])!),
      goalHours: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}goal_hours'])!,
      completed: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}completed'])!,
      lastUpdatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}last_updated_at'])!,
      isDeleted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_deleted'])!,
      isDirty: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_dirty'])!,
    );
  }

  @override
  $FastingSessionsTable createAlias(String alias) {
    return $FastingSessionsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<FastingPlanType, String, String>
      $converterplanType =
      const EnumNameConverter<FastingPlanType>(FastingPlanType.values);
}

class FastingSessionRow extends DataClass
    implements Insertable<FastingSessionRow> {
  final String id;
  final String uid;
  final int start;
  final int? end;
  final FastingPlanType planType;
  final int goalHours;
  final bool completed;
  final int lastUpdatedAt;
  final bool isDeleted;
  final bool isDirty;
  const FastingSessionRow(
      {required this.id,
      required this.uid,
      required this.start,
      this.end,
      required this.planType,
      required this.goalHours,
      required this.completed,
      required this.lastUpdatedAt,
      required this.isDeleted,
      required this.isDirty});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['uid'] = Variable<String>(uid);
    map['start'] = Variable<int>(start);
    if (!nullToAbsent || end != null) {
      map['end'] = Variable<int>(end);
    }
    {
      map['plan_type'] = Variable<String>(
          $FastingSessionsTable.$converterplanType.toSql(planType));
    }
    map['goal_hours'] = Variable<int>(goalHours);
    map['completed'] = Variable<bool>(completed);
    map['last_updated_at'] = Variable<int>(lastUpdatedAt);
    map['is_deleted'] = Variable<bool>(isDeleted);
    map['is_dirty'] = Variable<bool>(isDirty);
    return map;
  }

  FastingSessionsCompanion toCompanion(bool nullToAbsent) {
    return FastingSessionsCompanion(
      id: Value(id),
      uid: Value(uid),
      start: Value(start),
      end: end == null && nullToAbsent ? const Value.absent() : Value(end),
      planType: Value(planType),
      goalHours: Value(goalHours),
      completed: Value(completed),
      lastUpdatedAt: Value(lastUpdatedAt),
      isDeleted: Value(isDeleted),
      isDirty: Value(isDirty),
    );
  }

  factory FastingSessionRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FastingSessionRow(
      id: serializer.fromJson<String>(json['id']),
      uid: serializer.fromJson<String>(json['uid']),
      start: serializer.fromJson<int>(json['start']),
      end: serializer.fromJson<int?>(json['end']),
      planType: $FastingSessionsTable.$converterplanType
          .fromJson(serializer.fromJson<String>(json['planType'])),
      goalHours: serializer.fromJson<int>(json['goalHours']),
      completed: serializer.fromJson<bool>(json['completed']),
      lastUpdatedAt: serializer.fromJson<int>(json['lastUpdatedAt']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      isDirty: serializer.fromJson<bool>(json['isDirty']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'uid': serializer.toJson<String>(uid),
      'start': serializer.toJson<int>(start),
      'end': serializer.toJson<int?>(end),
      'planType': serializer.toJson<String>(
          $FastingSessionsTable.$converterplanType.toJson(planType)),
      'goalHours': serializer.toJson<int>(goalHours),
      'completed': serializer.toJson<bool>(completed),
      'lastUpdatedAt': serializer.toJson<int>(lastUpdatedAt),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'isDirty': serializer.toJson<bool>(isDirty),
    };
  }

  FastingSessionRow copyWith(
          {String? id,
          String? uid,
          int? start,
          Value<int?> end = const Value.absent(),
          FastingPlanType? planType,
          int? goalHours,
          bool? completed,
          int? lastUpdatedAt,
          bool? isDeleted,
          bool? isDirty}) =>
      FastingSessionRow(
        id: id ?? this.id,
        uid: uid ?? this.uid,
        start: start ?? this.start,
        end: end.present ? end.value : this.end,
        planType: planType ?? this.planType,
        goalHours: goalHours ?? this.goalHours,
        completed: completed ?? this.completed,
        lastUpdatedAt: lastUpdatedAt ?? this.lastUpdatedAt,
        isDeleted: isDeleted ?? this.isDeleted,
        isDirty: isDirty ?? this.isDirty,
      );
  FastingSessionRow copyWithCompanion(FastingSessionsCompanion data) {
    return FastingSessionRow(
      id: data.id.present ? data.id.value : this.id,
      uid: data.uid.present ? data.uid.value : this.uid,
      start: data.start.present ? data.start.value : this.start,
      end: data.end.present ? data.end.value : this.end,
      planType: data.planType.present ? data.planType.value : this.planType,
      goalHours: data.goalHours.present ? data.goalHours.value : this.goalHours,
      completed: data.completed.present ? data.completed.value : this.completed,
      lastUpdatedAt: data.lastUpdatedAt.present
          ? data.lastUpdatedAt.value
          : this.lastUpdatedAt,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      isDirty: data.isDirty.present ? data.isDirty.value : this.isDirty,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FastingSessionRow(')
          ..write('id: $id, ')
          ..write('uid: $uid, ')
          ..write('start: $start, ')
          ..write('end: $end, ')
          ..write('planType: $planType, ')
          ..write('goalHours: $goalHours, ')
          ..write('completed: $completed, ')
          ..write('lastUpdatedAt: $lastUpdatedAt, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('isDirty: $isDirty')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, uid, start, end, planType, goalHours,
      completed, lastUpdatedAt, isDeleted, isDirty);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FastingSessionRow &&
          other.id == this.id &&
          other.uid == this.uid &&
          other.start == this.start &&
          other.end == this.end &&
          other.planType == this.planType &&
          other.goalHours == this.goalHours &&
          other.completed == this.completed &&
          other.lastUpdatedAt == this.lastUpdatedAt &&
          other.isDeleted == this.isDeleted &&
          other.isDirty == this.isDirty);
}

class FastingSessionsCompanion extends UpdateCompanion<FastingSessionRow> {
  final Value<String> id;
  final Value<String> uid;
  final Value<int> start;
  final Value<int?> end;
  final Value<FastingPlanType> planType;
  final Value<int> goalHours;
  final Value<bool> completed;
  final Value<int> lastUpdatedAt;
  final Value<bool> isDeleted;
  final Value<bool> isDirty;
  final Value<int> rowid;
  const FastingSessionsCompanion({
    this.id = const Value.absent(),
    this.uid = const Value.absent(),
    this.start = const Value.absent(),
    this.end = const Value.absent(),
    this.planType = const Value.absent(),
    this.goalHours = const Value.absent(),
    this.completed = const Value.absent(),
    this.lastUpdatedAt = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.isDirty = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FastingSessionsCompanion.insert({
    required String id,
    required String uid,
    required int start,
    this.end = const Value.absent(),
    required FastingPlanType planType,
    required int goalHours,
    this.completed = const Value.absent(),
    required int lastUpdatedAt,
    this.isDeleted = const Value.absent(),
    this.isDirty = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        uid = Value(uid),
        start = Value(start),
        planType = Value(planType),
        goalHours = Value(goalHours),
        lastUpdatedAt = Value(lastUpdatedAt);
  static Insertable<FastingSessionRow> custom({
    Expression<String>? id,
    Expression<String>? uid,
    Expression<int>? start,
    Expression<int>? end,
    Expression<String>? planType,
    Expression<int>? goalHours,
    Expression<bool>? completed,
    Expression<int>? lastUpdatedAt,
    Expression<bool>? isDeleted,
    Expression<bool>? isDirty,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uid != null) 'uid': uid,
      if (start != null) 'start': start,
      if (end != null) 'end': end,
      if (planType != null) 'plan_type': planType,
      if (goalHours != null) 'goal_hours': goalHours,
      if (completed != null) 'completed': completed,
      if (lastUpdatedAt != null) 'last_updated_at': lastUpdatedAt,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (isDirty != null) 'is_dirty': isDirty,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FastingSessionsCompanion copyWith(
      {Value<String>? id,
      Value<String>? uid,
      Value<int>? start,
      Value<int?>? end,
      Value<FastingPlanType>? planType,
      Value<int>? goalHours,
      Value<bool>? completed,
      Value<int>? lastUpdatedAt,
      Value<bool>? isDeleted,
      Value<bool>? isDirty,
      Value<int>? rowid}) {
    return FastingSessionsCompanion(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      start: start ?? this.start,
      end: end ?? this.end,
      planType: planType ?? this.planType,
      goalHours: goalHours ?? this.goalHours,
      completed: completed ?? this.completed,
      lastUpdatedAt: lastUpdatedAt ?? this.lastUpdatedAt,
      isDeleted: isDeleted ?? this.isDeleted,
      isDirty: isDirty ?? this.isDirty,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (uid.present) {
      map['uid'] = Variable<String>(uid.value);
    }
    if (start.present) {
      map['start'] = Variable<int>(start.value);
    }
    if (end.present) {
      map['end'] = Variable<int>(end.value);
    }
    if (planType.present) {
      map['plan_type'] = Variable<String>(
          $FastingSessionsTable.$converterplanType.toSql(planType.value));
    }
    if (goalHours.present) {
      map['goal_hours'] = Variable<int>(goalHours.value);
    }
    if (completed.present) {
      map['completed'] = Variable<bool>(completed.value);
    }
    if (lastUpdatedAt.present) {
      map['last_updated_at'] = Variable<int>(lastUpdatedAt.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (isDirty.present) {
      map['is_dirty'] = Variable<bool>(isDirty.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FastingSessionsCompanion(')
          ..write('id: $id, ')
          ..write('uid: $uid, ')
          ..write('start: $start, ')
          ..write('end: $end, ')
          ..write('planType: $planType, ')
          ..write('goalHours: $goalHours, ')
          ..write('completed: $completed, ')
          ..write('lastUpdatedAt: $lastUpdatedAt, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('isDirty: $isDirty, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ActivityEntriesTable extends ActivityEntries
    with TableInfo<$ActivityEntriesTable, ActivityEntryRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ActivityEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _uidMeta = const VerificationMeta('uid');
  @override
  late final GeneratedColumn<String> uid = GeneratedColumn<String>(
      'uid', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _recordedAtMeta =
      const VerificationMeta('recordedAt');
  @override
  late final GeneratedColumn<int> recordedAt = GeneratedColumn<int>(
      'date_time', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _durationMinMeta =
      const VerificationMeta('durationMin');
  @override
  late final GeneratedColumn<int> durationMin = GeneratedColumn<int>(
      'duration_min', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _caloriesMeta =
      const VerificationMeta('calories');
  @override
  late final GeneratedColumn<double> calories = GeneratedColumn<double>(
      'calories', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _stepsMeta = const VerificationMeta('steps');
  @override
  late final GeneratedColumn<int> steps = GeneratedColumn<int>(
      'steps', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumnWithTypeConverter<ActivitySource, String> source =
      GeneratedColumn<String>('source', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<ActivitySource>(
              $ActivityEntriesTable.$convertersource);
  static const VerificationMeta _lastUpdatedAtMeta =
      const VerificationMeta('lastUpdatedAt');
  @override
  late final GeneratedColumn<int> lastUpdatedAt = GeneratedColumn<int>(
      'last_updated_at', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _isDeletedMeta =
      const VerificationMeta('isDeleted');
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
      'is_deleted', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_deleted" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _isDirtyMeta =
      const VerificationMeta('isDirty');
  @override
  late final GeneratedColumn<bool> isDirty = GeneratedColumn<bool>(
      'is_dirty', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_dirty" IN (0, 1))'),
      defaultValue: const Constant(true));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        uid,
        recordedAt,
        type,
        durationMin,
        calories,
        steps,
        source,
        lastUpdatedAt,
        isDeleted,
        isDirty
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'activity_entries';
  @override
  VerificationContext validateIntegrity(Insertable<ActivityEntryRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('uid')) {
      context.handle(
          _uidMeta, uid.isAcceptableOrUnknown(data['uid']!, _uidMeta));
    } else if (isInserting) {
      context.missing(_uidMeta);
    }
    if (data.containsKey('date_time')) {
      context.handle(
          _recordedAtMeta,
          recordedAt.isAcceptableOrUnknown(
              data['date_time']!, _recordedAtMeta));
    } else if (isInserting) {
      context.missing(_recordedAtMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('duration_min')) {
      context.handle(
          _durationMinMeta,
          durationMin.isAcceptableOrUnknown(
              data['duration_min']!, _durationMinMeta));
    } else if (isInserting) {
      context.missing(_durationMinMeta);
    }
    if (data.containsKey('calories')) {
      context.handle(_caloriesMeta,
          calories.isAcceptableOrUnknown(data['calories']!, _caloriesMeta));
    } else if (isInserting) {
      context.missing(_caloriesMeta);
    }
    if (data.containsKey('steps')) {
      context.handle(
          _stepsMeta, steps.isAcceptableOrUnknown(data['steps']!, _stepsMeta));
    }
    context.handle(_sourceMeta, const VerificationResult.success());
    if (data.containsKey('last_updated_at')) {
      context.handle(
          _lastUpdatedAtMeta,
          lastUpdatedAt.isAcceptableOrUnknown(
              data['last_updated_at']!, _lastUpdatedAtMeta));
    } else if (isInserting) {
      context.missing(_lastUpdatedAtMeta);
    }
    if (data.containsKey('is_deleted')) {
      context.handle(_isDeletedMeta,
          isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta));
    }
    if (data.containsKey('is_dirty')) {
      context.handle(_isDirtyMeta,
          isDirty.isAcceptableOrUnknown(data['is_dirty']!, _isDirtyMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ActivityEntryRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ActivityEntryRow(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      uid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}uid'])!,
      recordedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}date_time'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      durationMin: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}duration_min'])!,
      calories: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}calories'])!,
      steps: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}steps']),
      source: $ActivityEntriesTable.$convertersource.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}source'])!),
      lastUpdatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}last_updated_at'])!,
      isDeleted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_deleted'])!,
      isDirty: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_dirty'])!,
    );
  }

  @override
  $ActivityEntriesTable createAlias(String alias) {
    return $ActivityEntriesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<ActivitySource, String, String> $convertersource =
      const EnumNameConverter<ActivitySource>(ActivitySource.values);
}

class ActivityEntryRow extends DataClass
    implements Insertable<ActivityEntryRow> {
  final String id;
  final String uid;
  final int recordedAt;
  final String type;
  final int durationMin;
  final double calories;
  final int? steps;
  final ActivitySource source;
  final int lastUpdatedAt;
  final bool isDeleted;
  final bool isDirty;
  const ActivityEntryRow(
      {required this.id,
      required this.uid,
      required this.recordedAt,
      required this.type,
      required this.durationMin,
      required this.calories,
      this.steps,
      required this.source,
      required this.lastUpdatedAt,
      required this.isDeleted,
      required this.isDirty});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['uid'] = Variable<String>(uid);
    map['date_time'] = Variable<int>(recordedAt);
    map['type'] = Variable<String>(type);
    map['duration_min'] = Variable<int>(durationMin);
    map['calories'] = Variable<double>(calories);
    if (!nullToAbsent || steps != null) {
      map['steps'] = Variable<int>(steps);
    }
    {
      map['source'] = Variable<String>(
          $ActivityEntriesTable.$convertersource.toSql(source));
    }
    map['last_updated_at'] = Variable<int>(lastUpdatedAt);
    map['is_deleted'] = Variable<bool>(isDeleted);
    map['is_dirty'] = Variable<bool>(isDirty);
    return map;
  }

  ActivityEntriesCompanion toCompanion(bool nullToAbsent) {
    return ActivityEntriesCompanion(
      id: Value(id),
      uid: Value(uid),
      recordedAt: Value(recordedAt),
      type: Value(type),
      durationMin: Value(durationMin),
      calories: Value(calories),
      steps:
          steps == null && nullToAbsent ? const Value.absent() : Value(steps),
      source: Value(source),
      lastUpdatedAt: Value(lastUpdatedAt),
      isDeleted: Value(isDeleted),
      isDirty: Value(isDirty),
    );
  }

  factory ActivityEntryRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ActivityEntryRow(
      id: serializer.fromJson<String>(json['id']),
      uid: serializer.fromJson<String>(json['uid']),
      recordedAt: serializer.fromJson<int>(json['recordedAt']),
      type: serializer.fromJson<String>(json['type']),
      durationMin: serializer.fromJson<int>(json['durationMin']),
      calories: serializer.fromJson<double>(json['calories']),
      steps: serializer.fromJson<int?>(json['steps']),
      source: $ActivityEntriesTable.$convertersource
          .fromJson(serializer.fromJson<String>(json['source'])),
      lastUpdatedAt: serializer.fromJson<int>(json['lastUpdatedAt']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      isDirty: serializer.fromJson<bool>(json['isDirty']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'uid': serializer.toJson<String>(uid),
      'recordedAt': serializer.toJson<int>(recordedAt),
      'type': serializer.toJson<String>(type),
      'durationMin': serializer.toJson<int>(durationMin),
      'calories': serializer.toJson<double>(calories),
      'steps': serializer.toJson<int?>(steps),
      'source': serializer.toJson<String>(
          $ActivityEntriesTable.$convertersource.toJson(source)),
      'lastUpdatedAt': serializer.toJson<int>(lastUpdatedAt),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'isDirty': serializer.toJson<bool>(isDirty),
    };
  }

  ActivityEntryRow copyWith(
          {String? id,
          String? uid,
          int? recordedAt,
          String? type,
          int? durationMin,
          double? calories,
          Value<int?> steps = const Value.absent(),
          ActivitySource? source,
          int? lastUpdatedAt,
          bool? isDeleted,
          bool? isDirty}) =>
      ActivityEntryRow(
        id: id ?? this.id,
        uid: uid ?? this.uid,
        recordedAt: recordedAt ?? this.recordedAt,
        type: type ?? this.type,
        durationMin: durationMin ?? this.durationMin,
        calories: calories ?? this.calories,
        steps: steps.present ? steps.value : this.steps,
        source: source ?? this.source,
        lastUpdatedAt: lastUpdatedAt ?? this.lastUpdatedAt,
        isDeleted: isDeleted ?? this.isDeleted,
        isDirty: isDirty ?? this.isDirty,
      );
  ActivityEntryRow copyWithCompanion(ActivityEntriesCompanion data) {
    return ActivityEntryRow(
      id: data.id.present ? data.id.value : this.id,
      uid: data.uid.present ? data.uid.value : this.uid,
      recordedAt:
          data.recordedAt.present ? data.recordedAt.value : this.recordedAt,
      type: data.type.present ? data.type.value : this.type,
      durationMin:
          data.durationMin.present ? data.durationMin.value : this.durationMin,
      calories: data.calories.present ? data.calories.value : this.calories,
      steps: data.steps.present ? data.steps.value : this.steps,
      source: data.source.present ? data.source.value : this.source,
      lastUpdatedAt: data.lastUpdatedAt.present
          ? data.lastUpdatedAt.value
          : this.lastUpdatedAt,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      isDirty: data.isDirty.present ? data.isDirty.value : this.isDirty,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ActivityEntryRow(')
          ..write('id: $id, ')
          ..write('uid: $uid, ')
          ..write('recordedAt: $recordedAt, ')
          ..write('type: $type, ')
          ..write('durationMin: $durationMin, ')
          ..write('calories: $calories, ')
          ..write('steps: $steps, ')
          ..write('source: $source, ')
          ..write('lastUpdatedAt: $lastUpdatedAt, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('isDirty: $isDirty')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, uid, recordedAt, type, durationMin,
      calories, steps, source, lastUpdatedAt, isDeleted, isDirty);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ActivityEntryRow &&
          other.id == this.id &&
          other.uid == this.uid &&
          other.recordedAt == this.recordedAt &&
          other.type == this.type &&
          other.durationMin == this.durationMin &&
          other.calories == this.calories &&
          other.steps == this.steps &&
          other.source == this.source &&
          other.lastUpdatedAt == this.lastUpdatedAt &&
          other.isDeleted == this.isDeleted &&
          other.isDirty == this.isDirty);
}

class ActivityEntriesCompanion extends UpdateCompanion<ActivityEntryRow> {
  final Value<String> id;
  final Value<String> uid;
  final Value<int> recordedAt;
  final Value<String> type;
  final Value<int> durationMin;
  final Value<double> calories;
  final Value<int?> steps;
  final Value<ActivitySource> source;
  final Value<int> lastUpdatedAt;
  final Value<bool> isDeleted;
  final Value<bool> isDirty;
  final Value<int> rowid;
  const ActivityEntriesCompanion({
    this.id = const Value.absent(),
    this.uid = const Value.absent(),
    this.recordedAt = const Value.absent(),
    this.type = const Value.absent(),
    this.durationMin = const Value.absent(),
    this.calories = const Value.absent(),
    this.steps = const Value.absent(),
    this.source = const Value.absent(),
    this.lastUpdatedAt = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.isDirty = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ActivityEntriesCompanion.insert({
    required String id,
    required String uid,
    required int recordedAt,
    required String type,
    required int durationMin,
    required double calories,
    this.steps = const Value.absent(),
    required ActivitySource source,
    required int lastUpdatedAt,
    this.isDeleted = const Value.absent(),
    this.isDirty = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        uid = Value(uid),
        recordedAt = Value(recordedAt),
        type = Value(type),
        durationMin = Value(durationMin),
        calories = Value(calories),
        source = Value(source),
        lastUpdatedAt = Value(lastUpdatedAt);
  static Insertable<ActivityEntryRow> custom({
    Expression<String>? id,
    Expression<String>? uid,
    Expression<int>? recordedAt,
    Expression<String>? type,
    Expression<int>? durationMin,
    Expression<double>? calories,
    Expression<int>? steps,
    Expression<String>? source,
    Expression<int>? lastUpdatedAt,
    Expression<bool>? isDeleted,
    Expression<bool>? isDirty,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uid != null) 'uid': uid,
      if (recordedAt != null) 'date_time': recordedAt,
      if (type != null) 'type': type,
      if (durationMin != null) 'duration_min': durationMin,
      if (calories != null) 'calories': calories,
      if (steps != null) 'steps': steps,
      if (source != null) 'source': source,
      if (lastUpdatedAt != null) 'last_updated_at': lastUpdatedAt,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (isDirty != null) 'is_dirty': isDirty,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ActivityEntriesCompanion copyWith(
      {Value<String>? id,
      Value<String>? uid,
      Value<int>? recordedAt,
      Value<String>? type,
      Value<int>? durationMin,
      Value<double>? calories,
      Value<int?>? steps,
      Value<ActivitySource>? source,
      Value<int>? lastUpdatedAt,
      Value<bool>? isDeleted,
      Value<bool>? isDirty,
      Value<int>? rowid}) {
    return ActivityEntriesCompanion(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      recordedAt: recordedAt ?? this.recordedAt,
      type: type ?? this.type,
      durationMin: durationMin ?? this.durationMin,
      calories: calories ?? this.calories,
      steps: steps ?? this.steps,
      source: source ?? this.source,
      lastUpdatedAt: lastUpdatedAt ?? this.lastUpdatedAt,
      isDeleted: isDeleted ?? this.isDeleted,
      isDirty: isDirty ?? this.isDirty,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (uid.present) {
      map['uid'] = Variable<String>(uid.value);
    }
    if (recordedAt.present) {
      map['date_time'] = Variable<int>(recordedAt.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (durationMin.present) {
      map['duration_min'] = Variable<int>(durationMin.value);
    }
    if (calories.present) {
      map['calories'] = Variable<double>(calories.value);
    }
    if (steps.present) {
      map['steps'] = Variable<int>(steps.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(
          $ActivityEntriesTable.$convertersource.toSql(source.value));
    }
    if (lastUpdatedAt.present) {
      map['last_updated_at'] = Variable<int>(lastUpdatedAt.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (isDirty.present) {
      map['is_dirty'] = Variable<bool>(isDirty.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ActivityEntriesCompanion(')
          ..write('id: $id, ')
          ..write('uid: $uid, ')
          ..write('recordedAt: $recordedAt, ')
          ..write('type: $type, ')
          ..write('durationMin: $durationMin, ')
          ..write('calories: $calories, ')
          ..write('steps: $steps, ')
          ..write('source: $source, ')
          ..write('lastUpdatedAt: $lastUpdatedAt, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('isDirty: $isDirty, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PhotoEntriesTable extends PhotoEntries
    with TableInfo<$PhotoEntriesTable, PhotoEntryRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PhotoEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _uidMeta = const VerificationMeta('uid');
  @override
  late final GeneratedColumn<String> uid = GeneratedColumn<String>(
      'uid', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<int> date = GeneratedColumn<int>(
      'date', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumnWithTypeConverter<PhotoType, String> type =
      GeneratedColumn<String>('type', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<PhotoType>($PhotoEntriesTable.$convertertype);
  static const VerificationMeta _storageUrlMeta =
      const VerificationMeta('storageUrl');
  @override
  late final GeneratedColumn<String> storageUrl = GeneratedColumn<String>(
      'storage_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _localPathMeta =
      const VerificationMeta('localPath');
  @override
  late final GeneratedColumn<String> localPath = GeneratedColumn<String>(
      'local_path', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _lastUpdatedAtMeta =
      const VerificationMeta('lastUpdatedAt');
  @override
  late final GeneratedColumn<int> lastUpdatedAt = GeneratedColumn<int>(
      'last_updated_at', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _isDeletedMeta =
      const VerificationMeta('isDeleted');
  @override
  late final GeneratedColumn<bool> isDeleted = GeneratedColumn<bool>(
      'is_deleted', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_deleted" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _isDirtyMeta =
      const VerificationMeta('isDirty');
  @override
  late final GeneratedColumn<bool> isDirty = GeneratedColumn<bool>(
      'is_dirty', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_dirty" IN (0, 1))'),
      defaultValue: const Constant(true));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        uid,
        date,
        type,
        storageUrl,
        localPath,
        notes,
        lastUpdatedAt,
        isDeleted,
        isDirty
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'photo_entries';
  @override
  VerificationContext validateIntegrity(Insertable<PhotoEntryRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('uid')) {
      context.handle(
          _uidMeta, uid.isAcceptableOrUnknown(data['uid']!, _uidMeta));
    } else if (isInserting) {
      context.missing(_uidMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    context.handle(_typeMeta, const VerificationResult.success());
    if (data.containsKey('storage_url')) {
      context.handle(
          _storageUrlMeta,
          storageUrl.isAcceptableOrUnknown(
              data['storage_url']!, _storageUrlMeta));
    }
    if (data.containsKey('local_path')) {
      context.handle(_localPathMeta,
          localPath.isAcceptableOrUnknown(data['local_path']!, _localPathMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('last_updated_at')) {
      context.handle(
          _lastUpdatedAtMeta,
          lastUpdatedAt.isAcceptableOrUnknown(
              data['last_updated_at']!, _lastUpdatedAtMeta));
    } else if (isInserting) {
      context.missing(_lastUpdatedAtMeta);
    }
    if (data.containsKey('is_deleted')) {
      context.handle(_isDeletedMeta,
          isDeleted.isAcceptableOrUnknown(data['is_deleted']!, _isDeletedMeta));
    }
    if (data.containsKey('is_dirty')) {
      context.handle(_isDirtyMeta,
          isDirty.isAcceptableOrUnknown(data['is_dirty']!, _isDirtyMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PhotoEntryRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PhotoEntryRow(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      uid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}uid'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}date'])!,
      type: $PhotoEntriesTable.$convertertype.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!),
      storageUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}storage_url']),
      localPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}local_path']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      lastUpdatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}last_updated_at'])!,
      isDeleted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_deleted'])!,
      isDirty: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_dirty'])!,
    );
  }

  @override
  $PhotoEntriesTable createAlias(String alias) {
    return $PhotoEntriesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<PhotoType, String, String> $convertertype =
      const EnumNameConverter<PhotoType>(PhotoType.values);
}

class PhotoEntryRow extends DataClass implements Insertable<PhotoEntryRow> {
  final String id;
  final String uid;
  final int date;
  final PhotoType type;
  final String? storageUrl;
  final String? localPath;
  final String? notes;
  final int lastUpdatedAt;
  final bool isDeleted;
  final bool isDirty;
  const PhotoEntryRow(
      {required this.id,
      required this.uid,
      required this.date,
      required this.type,
      this.storageUrl,
      this.localPath,
      this.notes,
      required this.lastUpdatedAt,
      required this.isDeleted,
      required this.isDirty});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['uid'] = Variable<String>(uid);
    map['date'] = Variable<int>(date);
    {
      map['type'] =
          Variable<String>($PhotoEntriesTable.$convertertype.toSql(type));
    }
    if (!nullToAbsent || storageUrl != null) {
      map['storage_url'] = Variable<String>(storageUrl);
    }
    if (!nullToAbsent || localPath != null) {
      map['local_path'] = Variable<String>(localPath);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['last_updated_at'] = Variable<int>(lastUpdatedAt);
    map['is_deleted'] = Variable<bool>(isDeleted);
    map['is_dirty'] = Variable<bool>(isDirty);
    return map;
  }

  PhotoEntriesCompanion toCompanion(bool nullToAbsent) {
    return PhotoEntriesCompanion(
      id: Value(id),
      uid: Value(uid),
      date: Value(date),
      type: Value(type),
      storageUrl: storageUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(storageUrl),
      localPath: localPath == null && nullToAbsent
          ? const Value.absent()
          : Value(localPath),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      lastUpdatedAt: Value(lastUpdatedAt),
      isDeleted: Value(isDeleted),
      isDirty: Value(isDirty),
    );
  }

  factory PhotoEntryRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PhotoEntryRow(
      id: serializer.fromJson<String>(json['id']),
      uid: serializer.fromJson<String>(json['uid']),
      date: serializer.fromJson<int>(json['date']),
      type: $PhotoEntriesTable.$convertertype
          .fromJson(serializer.fromJson<String>(json['type'])),
      storageUrl: serializer.fromJson<String?>(json['storageUrl']),
      localPath: serializer.fromJson<String?>(json['localPath']),
      notes: serializer.fromJson<String?>(json['notes']),
      lastUpdatedAt: serializer.fromJson<int>(json['lastUpdatedAt']),
      isDeleted: serializer.fromJson<bool>(json['isDeleted']),
      isDirty: serializer.fromJson<bool>(json['isDirty']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'uid': serializer.toJson<String>(uid),
      'date': serializer.toJson<int>(date),
      'type': serializer
          .toJson<String>($PhotoEntriesTable.$convertertype.toJson(type)),
      'storageUrl': serializer.toJson<String?>(storageUrl),
      'localPath': serializer.toJson<String?>(localPath),
      'notes': serializer.toJson<String?>(notes),
      'lastUpdatedAt': serializer.toJson<int>(lastUpdatedAt),
      'isDeleted': serializer.toJson<bool>(isDeleted),
      'isDirty': serializer.toJson<bool>(isDirty),
    };
  }

  PhotoEntryRow copyWith(
          {String? id,
          String? uid,
          int? date,
          PhotoType? type,
          Value<String?> storageUrl = const Value.absent(),
          Value<String?> localPath = const Value.absent(),
          Value<String?> notes = const Value.absent(),
          int? lastUpdatedAt,
          bool? isDeleted,
          bool? isDirty}) =>
      PhotoEntryRow(
        id: id ?? this.id,
        uid: uid ?? this.uid,
        date: date ?? this.date,
        type: type ?? this.type,
        storageUrl: storageUrl.present ? storageUrl.value : this.storageUrl,
        localPath: localPath.present ? localPath.value : this.localPath,
        notes: notes.present ? notes.value : this.notes,
        lastUpdatedAt: lastUpdatedAt ?? this.lastUpdatedAt,
        isDeleted: isDeleted ?? this.isDeleted,
        isDirty: isDirty ?? this.isDirty,
      );
  PhotoEntryRow copyWithCompanion(PhotoEntriesCompanion data) {
    return PhotoEntryRow(
      id: data.id.present ? data.id.value : this.id,
      uid: data.uid.present ? data.uid.value : this.uid,
      date: data.date.present ? data.date.value : this.date,
      type: data.type.present ? data.type.value : this.type,
      storageUrl:
          data.storageUrl.present ? data.storageUrl.value : this.storageUrl,
      localPath: data.localPath.present ? data.localPath.value : this.localPath,
      notes: data.notes.present ? data.notes.value : this.notes,
      lastUpdatedAt: data.lastUpdatedAt.present
          ? data.lastUpdatedAt.value
          : this.lastUpdatedAt,
      isDeleted: data.isDeleted.present ? data.isDeleted.value : this.isDeleted,
      isDirty: data.isDirty.present ? data.isDirty.value : this.isDirty,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PhotoEntryRow(')
          ..write('id: $id, ')
          ..write('uid: $uid, ')
          ..write('date: $date, ')
          ..write('type: $type, ')
          ..write('storageUrl: $storageUrl, ')
          ..write('localPath: $localPath, ')
          ..write('notes: $notes, ')
          ..write('lastUpdatedAt: $lastUpdatedAt, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('isDirty: $isDirty')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, uid, date, type, storageUrl, localPath,
      notes, lastUpdatedAt, isDeleted, isDirty);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PhotoEntryRow &&
          other.id == this.id &&
          other.uid == this.uid &&
          other.date == this.date &&
          other.type == this.type &&
          other.storageUrl == this.storageUrl &&
          other.localPath == this.localPath &&
          other.notes == this.notes &&
          other.lastUpdatedAt == this.lastUpdatedAt &&
          other.isDeleted == this.isDeleted &&
          other.isDirty == this.isDirty);
}

class PhotoEntriesCompanion extends UpdateCompanion<PhotoEntryRow> {
  final Value<String> id;
  final Value<String> uid;
  final Value<int> date;
  final Value<PhotoType> type;
  final Value<String?> storageUrl;
  final Value<String?> localPath;
  final Value<String?> notes;
  final Value<int> lastUpdatedAt;
  final Value<bool> isDeleted;
  final Value<bool> isDirty;
  final Value<int> rowid;
  const PhotoEntriesCompanion({
    this.id = const Value.absent(),
    this.uid = const Value.absent(),
    this.date = const Value.absent(),
    this.type = const Value.absent(),
    this.storageUrl = const Value.absent(),
    this.localPath = const Value.absent(),
    this.notes = const Value.absent(),
    this.lastUpdatedAt = const Value.absent(),
    this.isDeleted = const Value.absent(),
    this.isDirty = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PhotoEntriesCompanion.insert({
    required String id,
    required String uid,
    required int date,
    required PhotoType type,
    this.storageUrl = const Value.absent(),
    this.localPath = const Value.absent(),
    this.notes = const Value.absent(),
    required int lastUpdatedAt,
    this.isDeleted = const Value.absent(),
    this.isDirty = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        uid = Value(uid),
        date = Value(date),
        type = Value(type),
        lastUpdatedAt = Value(lastUpdatedAt);
  static Insertable<PhotoEntryRow> custom({
    Expression<String>? id,
    Expression<String>? uid,
    Expression<int>? date,
    Expression<String>? type,
    Expression<String>? storageUrl,
    Expression<String>? localPath,
    Expression<String>? notes,
    Expression<int>? lastUpdatedAt,
    Expression<bool>? isDeleted,
    Expression<bool>? isDirty,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uid != null) 'uid': uid,
      if (date != null) 'date': date,
      if (type != null) 'type': type,
      if (storageUrl != null) 'storage_url': storageUrl,
      if (localPath != null) 'local_path': localPath,
      if (notes != null) 'notes': notes,
      if (lastUpdatedAt != null) 'last_updated_at': lastUpdatedAt,
      if (isDeleted != null) 'is_deleted': isDeleted,
      if (isDirty != null) 'is_dirty': isDirty,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PhotoEntriesCompanion copyWith(
      {Value<String>? id,
      Value<String>? uid,
      Value<int>? date,
      Value<PhotoType>? type,
      Value<String?>? storageUrl,
      Value<String?>? localPath,
      Value<String?>? notes,
      Value<int>? lastUpdatedAt,
      Value<bool>? isDeleted,
      Value<bool>? isDirty,
      Value<int>? rowid}) {
    return PhotoEntriesCompanion(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      date: date ?? this.date,
      type: type ?? this.type,
      storageUrl: storageUrl ?? this.storageUrl,
      localPath: localPath ?? this.localPath,
      notes: notes ?? this.notes,
      lastUpdatedAt: lastUpdatedAt ?? this.lastUpdatedAt,
      isDeleted: isDeleted ?? this.isDeleted,
      isDirty: isDirty ?? this.isDirty,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (uid.present) {
      map['uid'] = Variable<String>(uid.value);
    }
    if (date.present) {
      map['date'] = Variable<int>(date.value);
    }
    if (type.present) {
      map['type'] =
          Variable<String>($PhotoEntriesTable.$convertertype.toSql(type.value));
    }
    if (storageUrl.present) {
      map['storage_url'] = Variable<String>(storageUrl.value);
    }
    if (localPath.present) {
      map['local_path'] = Variable<String>(localPath.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (lastUpdatedAt.present) {
      map['last_updated_at'] = Variable<int>(lastUpdatedAt.value);
    }
    if (isDeleted.present) {
      map['is_deleted'] = Variable<bool>(isDeleted.value);
    }
    if (isDirty.present) {
      map['is_dirty'] = Variable<bool>(isDirty.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PhotoEntriesCompanion(')
          ..write('id: $id, ')
          ..write('uid: $uid, ')
          ..write('date: $date, ')
          ..write('type: $type, ')
          ..write('storageUrl: $storageUrl, ')
          ..write('localPath: $localPath, ')
          ..write('notes: $notes, ')
          ..write('lastUpdatedAt: $lastUpdatedAt, ')
          ..write('isDeleted: $isDeleted, ')
          ..write('isDirty: $isDirty, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SyncLogsTable extends SyncLogs
    with TableInfo<$SyncLogsTable, SyncLogRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _uidMeta = const VerificationMeta('uid');
  @override
  late final GeneratedColumn<String> uid = GeneratedColumn<String>(
      'uid', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _entityTypeMeta =
      const VerificationMeta('entityType');
  @override
  late final GeneratedColumn<String> entityType = GeneratedColumn<String>(
      'entity_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _entityIdMeta =
      const VerificationMeta('entityId');
  @override
  late final GeneratedColumn<String> entityId = GeneratedColumn<String>(
      'entity_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _conflictInfoMeta =
      const VerificationMeta('conflictInfo');
  @override
  late final GeneratedColumn<String> conflictInfo = GeneratedColumn<String>(
      'conflict_info', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<int> createdAt = GeneratedColumn<int>(
      'created_at', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, uid, entityType, entityId, conflictInfo, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_logs';
  @override
  VerificationContext validateIntegrity(Insertable<SyncLogRow> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('uid')) {
      context.handle(
          _uidMeta, uid.isAcceptableOrUnknown(data['uid']!, _uidMeta));
    } else if (isInserting) {
      context.missing(_uidMeta);
    }
    if (data.containsKey('entity_type')) {
      context.handle(
          _entityTypeMeta,
          entityType.isAcceptableOrUnknown(
              data['entity_type']!, _entityTypeMeta));
    } else if (isInserting) {
      context.missing(_entityTypeMeta);
    }
    if (data.containsKey('entity_id')) {
      context.handle(_entityIdMeta,
          entityId.isAcceptableOrUnknown(data['entity_id']!, _entityIdMeta));
    } else if (isInserting) {
      context.missing(_entityIdMeta);
    }
    if (data.containsKey('conflict_info')) {
      context.handle(
          _conflictInfoMeta,
          conflictInfo.isAcceptableOrUnknown(
              data['conflict_info']!, _conflictInfoMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SyncLogRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncLogRow(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      uid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}uid'])!,
      entityType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}entity_type'])!,
      entityId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}entity_id'])!,
      conflictInfo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}conflict_info']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $SyncLogsTable createAlias(String alias) {
    return $SyncLogsTable(attachedDatabase, alias);
  }
}

class SyncLogRow extends DataClass implements Insertable<SyncLogRow> {
  final String id;
  final String uid;
  final String entityType;
  final String entityId;
  final String? conflictInfo;
  final int createdAt;
  const SyncLogRow(
      {required this.id,
      required this.uid,
      required this.entityType,
      required this.entityId,
      this.conflictInfo,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['uid'] = Variable<String>(uid);
    map['entity_type'] = Variable<String>(entityType);
    map['entity_id'] = Variable<String>(entityId);
    if (!nullToAbsent || conflictInfo != null) {
      map['conflict_info'] = Variable<String>(conflictInfo);
    }
    map['created_at'] = Variable<int>(createdAt);
    return map;
  }

  SyncLogsCompanion toCompanion(bool nullToAbsent) {
    return SyncLogsCompanion(
      id: Value(id),
      uid: Value(uid),
      entityType: Value(entityType),
      entityId: Value(entityId),
      conflictInfo: conflictInfo == null && nullToAbsent
          ? const Value.absent()
          : Value(conflictInfo),
      createdAt: Value(createdAt),
    );
  }

  factory SyncLogRow.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncLogRow(
      id: serializer.fromJson<String>(json['id']),
      uid: serializer.fromJson<String>(json['uid']),
      entityType: serializer.fromJson<String>(json['entityType']),
      entityId: serializer.fromJson<String>(json['entityId']),
      conflictInfo: serializer.fromJson<String?>(json['conflictInfo']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'uid': serializer.toJson<String>(uid),
      'entityType': serializer.toJson<String>(entityType),
      'entityId': serializer.toJson<String>(entityId),
      'conflictInfo': serializer.toJson<String?>(conflictInfo),
      'createdAt': serializer.toJson<int>(createdAt),
    };
  }

  SyncLogRow copyWith(
          {String? id,
          String? uid,
          String? entityType,
          String? entityId,
          Value<String?> conflictInfo = const Value.absent(),
          int? createdAt}) =>
      SyncLogRow(
        id: id ?? this.id,
        uid: uid ?? this.uid,
        entityType: entityType ?? this.entityType,
        entityId: entityId ?? this.entityId,
        conflictInfo:
            conflictInfo.present ? conflictInfo.value : this.conflictInfo,
        createdAt: createdAt ?? this.createdAt,
      );
  SyncLogRow copyWithCompanion(SyncLogsCompanion data) {
    return SyncLogRow(
      id: data.id.present ? data.id.value : this.id,
      uid: data.uid.present ? data.uid.value : this.uid,
      entityType:
          data.entityType.present ? data.entityType.value : this.entityType,
      entityId: data.entityId.present ? data.entityId.value : this.entityId,
      conflictInfo: data.conflictInfo.present
          ? data.conflictInfo.value
          : this.conflictInfo,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncLogRow(')
          ..write('id: $id, ')
          ..write('uid: $uid, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('conflictInfo: $conflictInfo, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, uid, entityType, entityId, conflictInfo, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncLogRow &&
          other.id == this.id &&
          other.uid == this.uid &&
          other.entityType == this.entityType &&
          other.entityId == this.entityId &&
          other.conflictInfo == this.conflictInfo &&
          other.createdAt == this.createdAt);
}

class SyncLogsCompanion extends UpdateCompanion<SyncLogRow> {
  final Value<String> id;
  final Value<String> uid;
  final Value<String> entityType;
  final Value<String> entityId;
  final Value<String?> conflictInfo;
  final Value<int> createdAt;
  final Value<int> rowid;
  const SyncLogsCompanion({
    this.id = const Value.absent(),
    this.uid = const Value.absent(),
    this.entityType = const Value.absent(),
    this.entityId = const Value.absent(),
    this.conflictInfo = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyncLogsCompanion.insert({
    required String id,
    required String uid,
    required String entityType,
    required String entityId,
    this.conflictInfo = const Value.absent(),
    required int createdAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        uid = Value(uid),
        entityType = Value(entityType),
        entityId = Value(entityId),
        createdAt = Value(createdAt);
  static Insertable<SyncLogRow> custom({
    Expression<String>? id,
    Expression<String>? uid,
    Expression<String>? entityType,
    Expression<String>? entityId,
    Expression<String>? conflictInfo,
    Expression<int>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (uid != null) 'uid': uid,
      if (entityType != null) 'entity_type': entityType,
      if (entityId != null) 'entity_id': entityId,
      if (conflictInfo != null) 'conflict_info': conflictInfo,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyncLogsCompanion copyWith(
      {Value<String>? id,
      Value<String>? uid,
      Value<String>? entityType,
      Value<String>? entityId,
      Value<String?>? conflictInfo,
      Value<int>? createdAt,
      Value<int>? rowid}) {
    return SyncLogsCompanion(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      entityType: entityType ?? this.entityType,
      entityId: entityId ?? this.entityId,
      conflictInfo: conflictInfo ?? this.conflictInfo,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (uid.present) {
      map['uid'] = Variable<String>(uid.value);
    }
    if (entityType.present) {
      map['entity_type'] = Variable<String>(entityType.value);
    }
    if (entityId.present) {
      map['entity_id'] = Variable<String>(entityId.value);
    }
    if (conflictInfo.present) {
      map['conflict_info'] = Variable<String>(conflictInfo.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<int>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncLogsCompanion(')
          ..write('id: $id, ')
          ..write('uid: $uid, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('conflictInfo: $conflictInfo, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UserProfilesTable userProfiles = $UserProfilesTable(this);
  late final $WeightEntriesTable weightEntries = $WeightEntriesTable(this);
  late final $MeasurementEntriesTable measurementEntries =
      $MeasurementEntriesTable(this);
  late final $WaterEntriesTable waterEntries = $WaterEntriesTable(this);
  late final $FoodEntriesTable foodEntries = $FoodEntriesTable(this);
  late final $CustomFoodsTable customFoods = $CustomFoodsTable(this);
  late final $FastingSessionsTable fastingSessions =
      $FastingSessionsTable(this);
  late final $ActivityEntriesTable activityEntries =
      $ActivityEntriesTable(this);
  late final $PhotoEntriesTable photoEntries = $PhotoEntriesTable(this);
  late final $SyncLogsTable syncLogs = $SyncLogsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        userProfiles,
        weightEntries,
        measurementEntries,
        waterEntries,
        foodEntries,
        customFoods,
        fastingSessions,
        activityEntries,
        photoEntries,
        syncLogs
      ];
}

typedef $$UserProfilesTableCreateCompanionBuilder = UserProfilesCompanion
    Function({
  required String uid,
  required String name,
  required double heightCm,
  Value<int?> birthYear,
  Value<String?> gender,
  required UnitsSystem units,
  required GoalType goalType,
  required double goalWeight,
  required int goalDate,
  Value<double?> tdeeTarget,
  Value<bool> adaptiveGoalsEnabled,
  required int lastUpdatedAt,
  required int createdAt,
  Value<bool> isDirty,
  Value<int> rowid,
});
typedef $$UserProfilesTableUpdateCompanionBuilder = UserProfilesCompanion
    Function({
  Value<String> uid,
  Value<String> name,
  Value<double> heightCm,
  Value<int?> birthYear,
  Value<String?> gender,
  Value<UnitsSystem> units,
  Value<GoalType> goalType,
  Value<double> goalWeight,
  Value<int> goalDate,
  Value<double?> tdeeTarget,
  Value<bool> adaptiveGoalsEnabled,
  Value<int> lastUpdatedAt,
  Value<int> createdAt,
  Value<bool> isDirty,
  Value<int> rowid,
});

class $$UserProfilesTableFilterComposer
    extends Composer<_$AppDatabase, $UserProfilesTable> {
  $$UserProfilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get uid => $composableBuilder(
      column: $table.uid, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get heightCm => $composableBuilder(
      column: $table.heightCm, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get birthYear => $composableBuilder(
      column: $table.birthYear, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get gender => $composableBuilder(
      column: $table.gender, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<UnitsSystem, UnitsSystem, String> get units =>
      $composableBuilder(
          column: $table.units,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnWithTypeConverterFilters<GoalType, GoalType, String> get goalType =>
      $composableBuilder(
          column: $table.goalType,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<double> get goalWeight => $composableBuilder(
      column: $table.goalWeight, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get goalDate => $composableBuilder(
      column: $table.goalDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get tdeeTarget => $composableBuilder(
      column: $table.tdeeTarget, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get adaptiveGoalsEnabled => $composableBuilder(
      column: $table.adaptiveGoalsEnabled,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get lastUpdatedAt => $composableBuilder(
      column: $table.lastUpdatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isDirty => $composableBuilder(
      column: $table.isDirty, builder: (column) => ColumnFilters(column));
}

class $$UserProfilesTableOrderingComposer
    extends Composer<_$AppDatabase, $UserProfilesTable> {
  $$UserProfilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get uid => $composableBuilder(
      column: $table.uid, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get heightCm => $composableBuilder(
      column: $table.heightCm, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get birthYear => $composableBuilder(
      column: $table.birthYear, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get gender => $composableBuilder(
      column: $table.gender, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get units => $composableBuilder(
      column: $table.units, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get goalType => $composableBuilder(
      column: $table.goalType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get goalWeight => $composableBuilder(
      column: $table.goalWeight, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get goalDate => $composableBuilder(
      column: $table.goalDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get tdeeTarget => $composableBuilder(
      column: $table.tdeeTarget, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get adaptiveGoalsEnabled => $composableBuilder(
      column: $table.adaptiveGoalsEnabled,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get lastUpdatedAt => $composableBuilder(
      column: $table.lastUpdatedAt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isDirty => $composableBuilder(
      column: $table.isDirty, builder: (column) => ColumnOrderings(column));
}

class $$UserProfilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserProfilesTable> {
  $$UserProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get uid =>
      $composableBuilder(column: $table.uid, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<double> get heightCm =>
      $composableBuilder(column: $table.heightCm, builder: (column) => column);

  GeneratedColumn<int> get birthYear =>
      $composableBuilder(column: $table.birthYear, builder: (column) => column);

  GeneratedColumn<String> get gender =>
      $composableBuilder(column: $table.gender, builder: (column) => column);

  GeneratedColumnWithTypeConverter<UnitsSystem, String> get units =>
      $composableBuilder(column: $table.units, builder: (column) => column);

  GeneratedColumnWithTypeConverter<GoalType, String> get goalType =>
      $composableBuilder(column: $table.goalType, builder: (column) => column);

  GeneratedColumn<double> get goalWeight => $composableBuilder(
      column: $table.goalWeight, builder: (column) => column);

  GeneratedColumn<int> get goalDate =>
      $composableBuilder(column: $table.goalDate, builder: (column) => column);

  GeneratedColumn<double> get tdeeTarget => $composableBuilder(
      column: $table.tdeeTarget, builder: (column) => column);

  GeneratedColumn<bool> get adaptiveGoalsEnabled => $composableBuilder(
      column: $table.adaptiveGoalsEnabled, builder: (column) => column);

  GeneratedColumn<int> get lastUpdatedAt => $composableBuilder(
      column: $table.lastUpdatedAt, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<bool> get isDirty =>
      $composableBuilder(column: $table.isDirty, builder: (column) => column);
}

class $$UserProfilesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UserProfilesTable,
    UserProfileRow,
    $$UserProfilesTableFilterComposer,
    $$UserProfilesTableOrderingComposer,
    $$UserProfilesTableAnnotationComposer,
    $$UserProfilesTableCreateCompanionBuilder,
    $$UserProfilesTableUpdateCompanionBuilder,
    (
      UserProfileRow,
      BaseReferences<_$AppDatabase, $UserProfilesTable, UserProfileRow>
    ),
    UserProfileRow,
    PrefetchHooks Function()> {
  $$UserProfilesTableTableManager(_$AppDatabase db, $UserProfilesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserProfilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> uid = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<double> heightCm = const Value.absent(),
            Value<int?> birthYear = const Value.absent(),
            Value<String?> gender = const Value.absent(),
            Value<UnitsSystem> units = const Value.absent(),
            Value<GoalType> goalType = const Value.absent(),
            Value<double> goalWeight = const Value.absent(),
            Value<int> goalDate = const Value.absent(),
            Value<double?> tdeeTarget = const Value.absent(),
            Value<bool> adaptiveGoalsEnabled = const Value.absent(),
            Value<int> lastUpdatedAt = const Value.absent(),
            Value<int> createdAt = const Value.absent(),
            Value<bool> isDirty = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              UserProfilesCompanion(
            uid: uid,
            name: name,
            heightCm: heightCm,
            birthYear: birthYear,
            gender: gender,
            units: units,
            goalType: goalType,
            goalWeight: goalWeight,
            goalDate: goalDate,
            tdeeTarget: tdeeTarget,
            adaptiveGoalsEnabled: adaptiveGoalsEnabled,
            lastUpdatedAt: lastUpdatedAt,
            createdAt: createdAt,
            isDirty: isDirty,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String uid,
            required String name,
            required double heightCm,
            Value<int?> birthYear = const Value.absent(),
            Value<String?> gender = const Value.absent(),
            required UnitsSystem units,
            required GoalType goalType,
            required double goalWeight,
            required int goalDate,
            Value<double?> tdeeTarget = const Value.absent(),
            Value<bool> adaptiveGoalsEnabled = const Value.absent(),
            required int lastUpdatedAt,
            required int createdAt,
            Value<bool> isDirty = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              UserProfilesCompanion.insert(
            uid: uid,
            name: name,
            heightCm: heightCm,
            birthYear: birthYear,
            gender: gender,
            units: units,
            goalType: goalType,
            goalWeight: goalWeight,
            goalDate: goalDate,
            tdeeTarget: tdeeTarget,
            adaptiveGoalsEnabled: adaptiveGoalsEnabled,
            lastUpdatedAt: lastUpdatedAt,
            createdAt: createdAt,
            isDirty: isDirty,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$UserProfilesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $UserProfilesTable,
    UserProfileRow,
    $$UserProfilesTableFilterComposer,
    $$UserProfilesTableOrderingComposer,
    $$UserProfilesTableAnnotationComposer,
    $$UserProfilesTableCreateCompanionBuilder,
    $$UserProfilesTableUpdateCompanionBuilder,
    (
      UserProfileRow,
      BaseReferences<_$AppDatabase, $UserProfilesTable, UserProfileRow>
    ),
    UserProfileRow,
    PrefetchHooks Function()>;
typedef $$WeightEntriesTableCreateCompanionBuilder = WeightEntriesCompanion
    Function({
  required String id,
  required String uid,
  required int recordedAt,
  required double weightKg,
  Value<String?> note,
  Value<ConditionTag?> conditionTag,
  Value<MoodTag?> moodTag,
  required int lastUpdatedAt,
  Value<bool> isDeleted,
  Value<bool> isDirty,
  Value<int> rowid,
});
typedef $$WeightEntriesTableUpdateCompanionBuilder = WeightEntriesCompanion
    Function({
  Value<String> id,
  Value<String> uid,
  Value<int> recordedAt,
  Value<double> weightKg,
  Value<String?> note,
  Value<ConditionTag?> conditionTag,
  Value<MoodTag?> moodTag,
  Value<int> lastUpdatedAt,
  Value<bool> isDeleted,
  Value<bool> isDirty,
  Value<int> rowid,
});

class $$WeightEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $WeightEntriesTable> {
  $$WeightEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get uid => $composableBuilder(
      column: $table.uid, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get recordedAt => $composableBuilder(
      column: $table.recordedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get weightKg => $composableBuilder(
      column: $table.weightKg, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<ConditionTag?, ConditionTag, String>
      get conditionTag => $composableBuilder(
          column: $table.conditionTag,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnWithTypeConverterFilters<MoodTag?, MoodTag, String> get moodTag =>
      $composableBuilder(
          column: $table.moodTag,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<int> get lastUpdatedAt => $composableBuilder(
      column: $table.lastUpdatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isDirty => $composableBuilder(
      column: $table.isDirty, builder: (column) => ColumnFilters(column));
}

class $$WeightEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $WeightEntriesTable> {
  $$WeightEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get uid => $composableBuilder(
      column: $table.uid, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get recordedAt => $composableBuilder(
      column: $table.recordedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get weightKg => $composableBuilder(
      column: $table.weightKg, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get note => $composableBuilder(
      column: $table.note, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get conditionTag => $composableBuilder(
      column: $table.conditionTag,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get moodTag => $composableBuilder(
      column: $table.moodTag, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get lastUpdatedAt => $composableBuilder(
      column: $table.lastUpdatedAt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isDirty => $composableBuilder(
      column: $table.isDirty, builder: (column) => ColumnOrderings(column));
}

class $$WeightEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $WeightEntriesTable> {
  $$WeightEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get uid =>
      $composableBuilder(column: $table.uid, builder: (column) => column);

  GeneratedColumn<int> get recordedAt => $composableBuilder(
      column: $table.recordedAt, builder: (column) => column);

  GeneratedColumn<double> get weightKg =>
      $composableBuilder(column: $table.weightKg, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumnWithTypeConverter<ConditionTag?, String> get conditionTag =>
      $composableBuilder(
          column: $table.conditionTag, builder: (column) => column);

  GeneratedColumnWithTypeConverter<MoodTag?, String> get moodTag =>
      $composableBuilder(column: $table.moodTag, builder: (column) => column);

  GeneratedColumn<int> get lastUpdatedAt => $composableBuilder(
      column: $table.lastUpdatedAt, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<bool> get isDirty =>
      $composableBuilder(column: $table.isDirty, builder: (column) => column);
}

class $$WeightEntriesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $WeightEntriesTable,
    WeightEntryRow,
    $$WeightEntriesTableFilterComposer,
    $$WeightEntriesTableOrderingComposer,
    $$WeightEntriesTableAnnotationComposer,
    $$WeightEntriesTableCreateCompanionBuilder,
    $$WeightEntriesTableUpdateCompanionBuilder,
    (
      WeightEntryRow,
      BaseReferences<_$AppDatabase, $WeightEntriesTable, WeightEntryRow>
    ),
    WeightEntryRow,
    PrefetchHooks Function()> {
  $$WeightEntriesTableTableManager(_$AppDatabase db, $WeightEntriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WeightEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WeightEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WeightEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> uid = const Value.absent(),
            Value<int> recordedAt = const Value.absent(),
            Value<double> weightKg = const Value.absent(),
            Value<String?> note = const Value.absent(),
            Value<ConditionTag?> conditionTag = const Value.absent(),
            Value<MoodTag?> moodTag = const Value.absent(),
            Value<int> lastUpdatedAt = const Value.absent(),
            Value<bool> isDeleted = const Value.absent(),
            Value<bool> isDirty = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              WeightEntriesCompanion(
            id: id,
            uid: uid,
            recordedAt: recordedAt,
            weightKg: weightKg,
            note: note,
            conditionTag: conditionTag,
            moodTag: moodTag,
            lastUpdatedAt: lastUpdatedAt,
            isDeleted: isDeleted,
            isDirty: isDirty,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String uid,
            required int recordedAt,
            required double weightKg,
            Value<String?> note = const Value.absent(),
            Value<ConditionTag?> conditionTag = const Value.absent(),
            Value<MoodTag?> moodTag = const Value.absent(),
            required int lastUpdatedAt,
            Value<bool> isDeleted = const Value.absent(),
            Value<bool> isDirty = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              WeightEntriesCompanion.insert(
            id: id,
            uid: uid,
            recordedAt: recordedAt,
            weightKg: weightKg,
            note: note,
            conditionTag: conditionTag,
            moodTag: moodTag,
            lastUpdatedAt: lastUpdatedAt,
            isDeleted: isDeleted,
            isDirty: isDirty,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$WeightEntriesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $WeightEntriesTable,
    WeightEntryRow,
    $$WeightEntriesTableFilterComposer,
    $$WeightEntriesTableOrderingComposer,
    $$WeightEntriesTableAnnotationComposer,
    $$WeightEntriesTableCreateCompanionBuilder,
    $$WeightEntriesTableUpdateCompanionBuilder,
    (
      WeightEntryRow,
      BaseReferences<_$AppDatabase, $WeightEntriesTable, WeightEntryRow>
    ),
    WeightEntryRow,
    PrefetchHooks Function()>;
typedef $$MeasurementEntriesTableCreateCompanionBuilder
    = MeasurementEntriesCompanion Function({
  required String id,
  required String uid,
  required int recordedAt,
  required double waistCm,
  required double hipCm,
  required double chestCm,
  required double neckCm,
  required double armCm,
  required double thighCm,
  Value<double?> bodyFatPct,
  Value<double?> musclePct,
  Value<double?> waterPct,
  required int lastUpdatedAt,
  Value<bool> isDeleted,
  Value<bool> isDirty,
  Value<int> rowid,
});
typedef $$MeasurementEntriesTableUpdateCompanionBuilder
    = MeasurementEntriesCompanion Function({
  Value<String> id,
  Value<String> uid,
  Value<int> recordedAt,
  Value<double> waistCm,
  Value<double> hipCm,
  Value<double> chestCm,
  Value<double> neckCm,
  Value<double> armCm,
  Value<double> thighCm,
  Value<double?> bodyFatPct,
  Value<double?> musclePct,
  Value<double?> waterPct,
  Value<int> lastUpdatedAt,
  Value<bool> isDeleted,
  Value<bool> isDirty,
  Value<int> rowid,
});

class $$MeasurementEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $MeasurementEntriesTable> {
  $$MeasurementEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get uid => $composableBuilder(
      column: $table.uid, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get recordedAt => $composableBuilder(
      column: $table.recordedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get waistCm => $composableBuilder(
      column: $table.waistCm, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get hipCm => $composableBuilder(
      column: $table.hipCm, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get chestCm => $composableBuilder(
      column: $table.chestCm, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get neckCm => $composableBuilder(
      column: $table.neckCm, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get armCm => $composableBuilder(
      column: $table.armCm, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get thighCm => $composableBuilder(
      column: $table.thighCm, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get bodyFatPct => $composableBuilder(
      column: $table.bodyFatPct, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get musclePct => $composableBuilder(
      column: $table.musclePct, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get waterPct => $composableBuilder(
      column: $table.waterPct, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get lastUpdatedAt => $composableBuilder(
      column: $table.lastUpdatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isDirty => $composableBuilder(
      column: $table.isDirty, builder: (column) => ColumnFilters(column));
}

class $$MeasurementEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $MeasurementEntriesTable> {
  $$MeasurementEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get uid => $composableBuilder(
      column: $table.uid, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get recordedAt => $composableBuilder(
      column: $table.recordedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get waistCm => $composableBuilder(
      column: $table.waistCm, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get hipCm => $composableBuilder(
      column: $table.hipCm, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get chestCm => $composableBuilder(
      column: $table.chestCm, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get neckCm => $composableBuilder(
      column: $table.neckCm, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get armCm => $composableBuilder(
      column: $table.armCm, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get thighCm => $composableBuilder(
      column: $table.thighCm, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get bodyFatPct => $composableBuilder(
      column: $table.bodyFatPct, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get musclePct => $composableBuilder(
      column: $table.musclePct, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get waterPct => $composableBuilder(
      column: $table.waterPct, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get lastUpdatedAt => $composableBuilder(
      column: $table.lastUpdatedAt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isDirty => $composableBuilder(
      column: $table.isDirty, builder: (column) => ColumnOrderings(column));
}

class $$MeasurementEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $MeasurementEntriesTable> {
  $$MeasurementEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get uid =>
      $composableBuilder(column: $table.uid, builder: (column) => column);

  GeneratedColumn<int> get recordedAt => $composableBuilder(
      column: $table.recordedAt, builder: (column) => column);

  GeneratedColumn<double> get waistCm =>
      $composableBuilder(column: $table.waistCm, builder: (column) => column);

  GeneratedColumn<double> get hipCm =>
      $composableBuilder(column: $table.hipCm, builder: (column) => column);

  GeneratedColumn<double> get chestCm =>
      $composableBuilder(column: $table.chestCm, builder: (column) => column);

  GeneratedColumn<double> get neckCm =>
      $composableBuilder(column: $table.neckCm, builder: (column) => column);

  GeneratedColumn<double> get armCm =>
      $composableBuilder(column: $table.armCm, builder: (column) => column);

  GeneratedColumn<double> get thighCm =>
      $composableBuilder(column: $table.thighCm, builder: (column) => column);

  GeneratedColumn<double> get bodyFatPct => $composableBuilder(
      column: $table.bodyFatPct, builder: (column) => column);

  GeneratedColumn<double> get musclePct =>
      $composableBuilder(column: $table.musclePct, builder: (column) => column);

  GeneratedColumn<double> get waterPct =>
      $composableBuilder(column: $table.waterPct, builder: (column) => column);

  GeneratedColumn<int> get lastUpdatedAt => $composableBuilder(
      column: $table.lastUpdatedAt, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<bool> get isDirty =>
      $composableBuilder(column: $table.isDirty, builder: (column) => column);
}

class $$MeasurementEntriesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $MeasurementEntriesTable,
    MeasurementEntryRow,
    $$MeasurementEntriesTableFilterComposer,
    $$MeasurementEntriesTableOrderingComposer,
    $$MeasurementEntriesTableAnnotationComposer,
    $$MeasurementEntriesTableCreateCompanionBuilder,
    $$MeasurementEntriesTableUpdateCompanionBuilder,
    (
      MeasurementEntryRow,
      BaseReferences<_$AppDatabase, $MeasurementEntriesTable,
          MeasurementEntryRow>
    ),
    MeasurementEntryRow,
    PrefetchHooks Function()> {
  $$MeasurementEntriesTableTableManager(
      _$AppDatabase db, $MeasurementEntriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MeasurementEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MeasurementEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MeasurementEntriesTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> uid = const Value.absent(),
            Value<int> recordedAt = const Value.absent(),
            Value<double> waistCm = const Value.absent(),
            Value<double> hipCm = const Value.absent(),
            Value<double> chestCm = const Value.absent(),
            Value<double> neckCm = const Value.absent(),
            Value<double> armCm = const Value.absent(),
            Value<double> thighCm = const Value.absent(),
            Value<double?> bodyFatPct = const Value.absent(),
            Value<double?> musclePct = const Value.absent(),
            Value<double?> waterPct = const Value.absent(),
            Value<int> lastUpdatedAt = const Value.absent(),
            Value<bool> isDeleted = const Value.absent(),
            Value<bool> isDirty = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              MeasurementEntriesCompanion(
            id: id,
            uid: uid,
            recordedAt: recordedAt,
            waistCm: waistCm,
            hipCm: hipCm,
            chestCm: chestCm,
            neckCm: neckCm,
            armCm: armCm,
            thighCm: thighCm,
            bodyFatPct: bodyFatPct,
            musclePct: musclePct,
            waterPct: waterPct,
            lastUpdatedAt: lastUpdatedAt,
            isDeleted: isDeleted,
            isDirty: isDirty,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String uid,
            required int recordedAt,
            required double waistCm,
            required double hipCm,
            required double chestCm,
            required double neckCm,
            required double armCm,
            required double thighCm,
            Value<double?> bodyFatPct = const Value.absent(),
            Value<double?> musclePct = const Value.absent(),
            Value<double?> waterPct = const Value.absent(),
            required int lastUpdatedAt,
            Value<bool> isDeleted = const Value.absent(),
            Value<bool> isDirty = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              MeasurementEntriesCompanion.insert(
            id: id,
            uid: uid,
            recordedAt: recordedAt,
            waistCm: waistCm,
            hipCm: hipCm,
            chestCm: chestCm,
            neckCm: neckCm,
            armCm: armCm,
            thighCm: thighCm,
            bodyFatPct: bodyFatPct,
            musclePct: musclePct,
            waterPct: waterPct,
            lastUpdatedAt: lastUpdatedAt,
            isDeleted: isDeleted,
            isDirty: isDirty,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$MeasurementEntriesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $MeasurementEntriesTable,
    MeasurementEntryRow,
    $$MeasurementEntriesTableFilterComposer,
    $$MeasurementEntriesTableOrderingComposer,
    $$MeasurementEntriesTableAnnotationComposer,
    $$MeasurementEntriesTableCreateCompanionBuilder,
    $$MeasurementEntriesTableUpdateCompanionBuilder,
    (
      MeasurementEntryRow,
      BaseReferences<_$AppDatabase, $MeasurementEntriesTable,
          MeasurementEntryRow>
    ),
    MeasurementEntryRow,
    PrefetchHooks Function()>;
typedef $$WaterEntriesTableCreateCompanionBuilder = WaterEntriesCompanion
    Function({
  required String id,
  required String uid,
  required int date,
  required int ml,
  required int lastUpdatedAt,
  Value<bool> isDeleted,
  Value<bool> isDirty,
  Value<int> rowid,
});
typedef $$WaterEntriesTableUpdateCompanionBuilder = WaterEntriesCompanion
    Function({
  Value<String> id,
  Value<String> uid,
  Value<int> date,
  Value<int> ml,
  Value<int> lastUpdatedAt,
  Value<bool> isDeleted,
  Value<bool> isDirty,
  Value<int> rowid,
});

class $$WaterEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $WaterEntriesTable> {
  $$WaterEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get uid => $composableBuilder(
      column: $table.uid, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get ml => $composableBuilder(
      column: $table.ml, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get lastUpdatedAt => $composableBuilder(
      column: $table.lastUpdatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isDirty => $composableBuilder(
      column: $table.isDirty, builder: (column) => ColumnFilters(column));
}

class $$WaterEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $WaterEntriesTable> {
  $$WaterEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get uid => $composableBuilder(
      column: $table.uid, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get ml => $composableBuilder(
      column: $table.ml, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get lastUpdatedAt => $composableBuilder(
      column: $table.lastUpdatedAt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isDirty => $composableBuilder(
      column: $table.isDirty, builder: (column) => ColumnOrderings(column));
}

class $$WaterEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $WaterEntriesTable> {
  $$WaterEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get uid =>
      $composableBuilder(column: $table.uid, builder: (column) => column);

  GeneratedColumn<int> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<int> get ml =>
      $composableBuilder(column: $table.ml, builder: (column) => column);

  GeneratedColumn<int> get lastUpdatedAt => $composableBuilder(
      column: $table.lastUpdatedAt, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<bool> get isDirty =>
      $composableBuilder(column: $table.isDirty, builder: (column) => column);
}

class $$WaterEntriesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $WaterEntriesTable,
    WaterEntryRow,
    $$WaterEntriesTableFilterComposer,
    $$WaterEntriesTableOrderingComposer,
    $$WaterEntriesTableAnnotationComposer,
    $$WaterEntriesTableCreateCompanionBuilder,
    $$WaterEntriesTableUpdateCompanionBuilder,
    (
      WaterEntryRow,
      BaseReferences<_$AppDatabase, $WaterEntriesTable, WaterEntryRow>
    ),
    WaterEntryRow,
    PrefetchHooks Function()> {
  $$WaterEntriesTableTableManager(_$AppDatabase db, $WaterEntriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WaterEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WaterEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WaterEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> uid = const Value.absent(),
            Value<int> date = const Value.absent(),
            Value<int> ml = const Value.absent(),
            Value<int> lastUpdatedAt = const Value.absent(),
            Value<bool> isDeleted = const Value.absent(),
            Value<bool> isDirty = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              WaterEntriesCompanion(
            id: id,
            uid: uid,
            date: date,
            ml: ml,
            lastUpdatedAt: lastUpdatedAt,
            isDeleted: isDeleted,
            isDirty: isDirty,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String uid,
            required int date,
            required int ml,
            required int lastUpdatedAt,
            Value<bool> isDeleted = const Value.absent(),
            Value<bool> isDirty = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              WaterEntriesCompanion.insert(
            id: id,
            uid: uid,
            date: date,
            ml: ml,
            lastUpdatedAt: lastUpdatedAt,
            isDeleted: isDeleted,
            isDirty: isDirty,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$WaterEntriesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $WaterEntriesTable,
    WaterEntryRow,
    $$WaterEntriesTableFilterComposer,
    $$WaterEntriesTableOrderingComposer,
    $$WaterEntriesTableAnnotationComposer,
    $$WaterEntriesTableCreateCompanionBuilder,
    $$WaterEntriesTableUpdateCompanionBuilder,
    (
      WaterEntryRow,
      BaseReferences<_$AppDatabase, $WaterEntriesTable, WaterEntryRow>
    ),
    WaterEntryRow,
    PrefetchHooks Function()>;
typedef $$FoodEntriesTableCreateCompanionBuilder = FoodEntriesCompanion
    Function({
  required String id,
  required String uid,
  required int recordedAt,
  required MealType mealType,
  required List<FoodItem> items,
  required FoodTotals totals,
  required int lastUpdatedAt,
  Value<bool> isDeleted,
  Value<bool> isDirty,
  Value<int> rowid,
});
typedef $$FoodEntriesTableUpdateCompanionBuilder = FoodEntriesCompanion
    Function({
  Value<String> id,
  Value<String> uid,
  Value<int> recordedAt,
  Value<MealType> mealType,
  Value<List<FoodItem>> items,
  Value<FoodTotals> totals,
  Value<int> lastUpdatedAt,
  Value<bool> isDeleted,
  Value<bool> isDirty,
  Value<int> rowid,
});

class $$FoodEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $FoodEntriesTable> {
  $$FoodEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get uid => $composableBuilder(
      column: $table.uid, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get recordedAt => $composableBuilder(
      column: $table.recordedAt, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<MealType, MealType, String> get mealType =>
      $composableBuilder(
          column: $table.mealType,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnWithTypeConverterFilters<List<FoodItem>, List<FoodItem>, String>
      get items => $composableBuilder(
          column: $table.items,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnWithTypeConverterFilters<FoodTotals, FoodTotals, String> get totals =>
      $composableBuilder(
          column: $table.totals,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<int> get lastUpdatedAt => $composableBuilder(
      column: $table.lastUpdatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isDirty => $composableBuilder(
      column: $table.isDirty, builder: (column) => ColumnFilters(column));
}

class $$FoodEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $FoodEntriesTable> {
  $$FoodEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get uid => $composableBuilder(
      column: $table.uid, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get recordedAt => $composableBuilder(
      column: $table.recordedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get mealType => $composableBuilder(
      column: $table.mealType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get items => $composableBuilder(
      column: $table.items, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get totals => $composableBuilder(
      column: $table.totals, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get lastUpdatedAt => $composableBuilder(
      column: $table.lastUpdatedAt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isDirty => $composableBuilder(
      column: $table.isDirty, builder: (column) => ColumnOrderings(column));
}

class $$FoodEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $FoodEntriesTable> {
  $$FoodEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get uid =>
      $composableBuilder(column: $table.uid, builder: (column) => column);

  GeneratedColumn<int> get recordedAt => $composableBuilder(
      column: $table.recordedAt, builder: (column) => column);

  GeneratedColumnWithTypeConverter<MealType, String> get mealType =>
      $composableBuilder(column: $table.mealType, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<FoodItem>, String> get items =>
      $composableBuilder(column: $table.items, builder: (column) => column);

  GeneratedColumnWithTypeConverter<FoodTotals, String> get totals =>
      $composableBuilder(column: $table.totals, builder: (column) => column);

  GeneratedColumn<int> get lastUpdatedAt => $composableBuilder(
      column: $table.lastUpdatedAt, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<bool> get isDirty =>
      $composableBuilder(column: $table.isDirty, builder: (column) => column);
}

class $$FoodEntriesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $FoodEntriesTable,
    FoodEntryRow,
    $$FoodEntriesTableFilterComposer,
    $$FoodEntriesTableOrderingComposer,
    $$FoodEntriesTableAnnotationComposer,
    $$FoodEntriesTableCreateCompanionBuilder,
    $$FoodEntriesTableUpdateCompanionBuilder,
    (
      FoodEntryRow,
      BaseReferences<_$AppDatabase, $FoodEntriesTable, FoodEntryRow>
    ),
    FoodEntryRow,
    PrefetchHooks Function()> {
  $$FoodEntriesTableTableManager(_$AppDatabase db, $FoodEntriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FoodEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FoodEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FoodEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> uid = const Value.absent(),
            Value<int> recordedAt = const Value.absent(),
            Value<MealType> mealType = const Value.absent(),
            Value<List<FoodItem>> items = const Value.absent(),
            Value<FoodTotals> totals = const Value.absent(),
            Value<int> lastUpdatedAt = const Value.absent(),
            Value<bool> isDeleted = const Value.absent(),
            Value<bool> isDirty = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              FoodEntriesCompanion(
            id: id,
            uid: uid,
            recordedAt: recordedAt,
            mealType: mealType,
            items: items,
            totals: totals,
            lastUpdatedAt: lastUpdatedAt,
            isDeleted: isDeleted,
            isDirty: isDirty,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String uid,
            required int recordedAt,
            required MealType mealType,
            required List<FoodItem> items,
            required FoodTotals totals,
            required int lastUpdatedAt,
            Value<bool> isDeleted = const Value.absent(),
            Value<bool> isDirty = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              FoodEntriesCompanion.insert(
            id: id,
            uid: uid,
            recordedAt: recordedAt,
            mealType: mealType,
            items: items,
            totals: totals,
            lastUpdatedAt: lastUpdatedAt,
            isDeleted: isDeleted,
            isDirty: isDirty,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$FoodEntriesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $FoodEntriesTable,
    FoodEntryRow,
    $$FoodEntriesTableFilterComposer,
    $$FoodEntriesTableOrderingComposer,
    $$FoodEntriesTableAnnotationComposer,
    $$FoodEntriesTableCreateCompanionBuilder,
    $$FoodEntriesTableUpdateCompanionBuilder,
    (
      FoodEntryRow,
      BaseReferences<_$AppDatabase, $FoodEntriesTable, FoodEntryRow>
    ),
    FoodEntryRow,
    PrefetchHooks Function()>;
typedef $$CustomFoodsTableCreateCompanionBuilder = CustomFoodsCompanion
    Function({
  required String id,
  required String uid,
  required String nameTr,
  required String nameEn,
  Value<String?> barcode,
  required double cal,
  required double protein,
  required double carb,
  required double fat,
  Value<double?> fiber,
  Value<double?> sodium,
  Value<double?> sugar,
  required int lastUpdatedAt,
  Value<bool> isDeleted,
  Value<bool> isDirty,
  Value<int> rowid,
});
typedef $$CustomFoodsTableUpdateCompanionBuilder = CustomFoodsCompanion
    Function({
  Value<String> id,
  Value<String> uid,
  Value<String> nameTr,
  Value<String> nameEn,
  Value<String?> barcode,
  Value<double> cal,
  Value<double> protein,
  Value<double> carb,
  Value<double> fat,
  Value<double?> fiber,
  Value<double?> sodium,
  Value<double?> sugar,
  Value<int> lastUpdatedAt,
  Value<bool> isDeleted,
  Value<bool> isDirty,
  Value<int> rowid,
});

class $$CustomFoodsTableFilterComposer
    extends Composer<_$AppDatabase, $CustomFoodsTable> {
  $$CustomFoodsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get uid => $composableBuilder(
      column: $table.uid, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nameTr => $composableBuilder(
      column: $table.nameTr, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nameEn => $composableBuilder(
      column: $table.nameEn, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get barcode => $composableBuilder(
      column: $table.barcode, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get cal => $composableBuilder(
      column: $table.cal, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get protein => $composableBuilder(
      column: $table.protein, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get carb => $composableBuilder(
      column: $table.carb, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get fat => $composableBuilder(
      column: $table.fat, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get fiber => $composableBuilder(
      column: $table.fiber, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get sodium => $composableBuilder(
      column: $table.sodium, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get sugar => $composableBuilder(
      column: $table.sugar, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get lastUpdatedAt => $composableBuilder(
      column: $table.lastUpdatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isDirty => $composableBuilder(
      column: $table.isDirty, builder: (column) => ColumnFilters(column));
}

class $$CustomFoodsTableOrderingComposer
    extends Composer<_$AppDatabase, $CustomFoodsTable> {
  $$CustomFoodsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get uid => $composableBuilder(
      column: $table.uid, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nameTr => $composableBuilder(
      column: $table.nameTr, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nameEn => $composableBuilder(
      column: $table.nameEn, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get barcode => $composableBuilder(
      column: $table.barcode, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get cal => $composableBuilder(
      column: $table.cal, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get protein => $composableBuilder(
      column: $table.protein, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get carb => $composableBuilder(
      column: $table.carb, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get fat => $composableBuilder(
      column: $table.fat, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get fiber => $composableBuilder(
      column: $table.fiber, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get sodium => $composableBuilder(
      column: $table.sodium, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get sugar => $composableBuilder(
      column: $table.sugar, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get lastUpdatedAt => $composableBuilder(
      column: $table.lastUpdatedAt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isDirty => $composableBuilder(
      column: $table.isDirty, builder: (column) => ColumnOrderings(column));
}

class $$CustomFoodsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CustomFoodsTable> {
  $$CustomFoodsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get uid =>
      $composableBuilder(column: $table.uid, builder: (column) => column);

  GeneratedColumn<String> get nameTr =>
      $composableBuilder(column: $table.nameTr, builder: (column) => column);

  GeneratedColumn<String> get nameEn =>
      $composableBuilder(column: $table.nameEn, builder: (column) => column);

  GeneratedColumn<String> get barcode =>
      $composableBuilder(column: $table.barcode, builder: (column) => column);

  GeneratedColumn<double> get cal =>
      $composableBuilder(column: $table.cal, builder: (column) => column);

  GeneratedColumn<double> get protein =>
      $composableBuilder(column: $table.protein, builder: (column) => column);

  GeneratedColumn<double> get carb =>
      $composableBuilder(column: $table.carb, builder: (column) => column);

  GeneratedColumn<double> get fat =>
      $composableBuilder(column: $table.fat, builder: (column) => column);

  GeneratedColumn<double> get fiber =>
      $composableBuilder(column: $table.fiber, builder: (column) => column);

  GeneratedColumn<double> get sodium =>
      $composableBuilder(column: $table.sodium, builder: (column) => column);

  GeneratedColumn<double> get sugar =>
      $composableBuilder(column: $table.sugar, builder: (column) => column);

  GeneratedColumn<int> get lastUpdatedAt => $composableBuilder(
      column: $table.lastUpdatedAt, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<bool> get isDirty =>
      $composableBuilder(column: $table.isDirty, builder: (column) => column);
}

class $$CustomFoodsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $CustomFoodsTable,
    CustomFoodRow,
    $$CustomFoodsTableFilterComposer,
    $$CustomFoodsTableOrderingComposer,
    $$CustomFoodsTableAnnotationComposer,
    $$CustomFoodsTableCreateCompanionBuilder,
    $$CustomFoodsTableUpdateCompanionBuilder,
    (
      CustomFoodRow,
      BaseReferences<_$AppDatabase, $CustomFoodsTable, CustomFoodRow>
    ),
    CustomFoodRow,
    PrefetchHooks Function()> {
  $$CustomFoodsTableTableManager(_$AppDatabase db, $CustomFoodsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CustomFoodsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CustomFoodsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CustomFoodsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> uid = const Value.absent(),
            Value<String> nameTr = const Value.absent(),
            Value<String> nameEn = const Value.absent(),
            Value<String?> barcode = const Value.absent(),
            Value<double> cal = const Value.absent(),
            Value<double> protein = const Value.absent(),
            Value<double> carb = const Value.absent(),
            Value<double> fat = const Value.absent(),
            Value<double?> fiber = const Value.absent(),
            Value<double?> sodium = const Value.absent(),
            Value<double?> sugar = const Value.absent(),
            Value<int> lastUpdatedAt = const Value.absent(),
            Value<bool> isDeleted = const Value.absent(),
            Value<bool> isDirty = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CustomFoodsCompanion(
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
            lastUpdatedAt: lastUpdatedAt,
            isDeleted: isDeleted,
            isDirty: isDirty,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String uid,
            required String nameTr,
            required String nameEn,
            Value<String?> barcode = const Value.absent(),
            required double cal,
            required double protein,
            required double carb,
            required double fat,
            Value<double?> fiber = const Value.absent(),
            Value<double?> sodium = const Value.absent(),
            Value<double?> sugar = const Value.absent(),
            required int lastUpdatedAt,
            Value<bool> isDeleted = const Value.absent(),
            Value<bool> isDirty = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              CustomFoodsCompanion.insert(
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
            lastUpdatedAt: lastUpdatedAt,
            isDeleted: isDeleted,
            isDirty: isDirty,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$CustomFoodsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $CustomFoodsTable,
    CustomFoodRow,
    $$CustomFoodsTableFilterComposer,
    $$CustomFoodsTableOrderingComposer,
    $$CustomFoodsTableAnnotationComposer,
    $$CustomFoodsTableCreateCompanionBuilder,
    $$CustomFoodsTableUpdateCompanionBuilder,
    (
      CustomFoodRow,
      BaseReferences<_$AppDatabase, $CustomFoodsTable, CustomFoodRow>
    ),
    CustomFoodRow,
    PrefetchHooks Function()>;
typedef $$FastingSessionsTableCreateCompanionBuilder = FastingSessionsCompanion
    Function({
  required String id,
  required String uid,
  required int start,
  Value<int?> end,
  required FastingPlanType planType,
  required int goalHours,
  Value<bool> completed,
  required int lastUpdatedAt,
  Value<bool> isDeleted,
  Value<bool> isDirty,
  Value<int> rowid,
});
typedef $$FastingSessionsTableUpdateCompanionBuilder = FastingSessionsCompanion
    Function({
  Value<String> id,
  Value<String> uid,
  Value<int> start,
  Value<int?> end,
  Value<FastingPlanType> planType,
  Value<int> goalHours,
  Value<bool> completed,
  Value<int> lastUpdatedAt,
  Value<bool> isDeleted,
  Value<bool> isDirty,
  Value<int> rowid,
});

class $$FastingSessionsTableFilterComposer
    extends Composer<_$AppDatabase, $FastingSessionsTable> {
  $$FastingSessionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get uid => $composableBuilder(
      column: $table.uid, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get start => $composableBuilder(
      column: $table.start, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get end => $composableBuilder(
      column: $table.end, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<FastingPlanType, FastingPlanType, String>
      get planType => $composableBuilder(
          column: $table.planType,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<int> get goalHours => $composableBuilder(
      column: $table.goalHours, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get completed => $composableBuilder(
      column: $table.completed, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get lastUpdatedAt => $composableBuilder(
      column: $table.lastUpdatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isDirty => $composableBuilder(
      column: $table.isDirty, builder: (column) => ColumnFilters(column));
}

class $$FastingSessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $FastingSessionsTable> {
  $$FastingSessionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get uid => $composableBuilder(
      column: $table.uid, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get start => $composableBuilder(
      column: $table.start, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get end => $composableBuilder(
      column: $table.end, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get planType => $composableBuilder(
      column: $table.planType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get goalHours => $composableBuilder(
      column: $table.goalHours, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get completed => $composableBuilder(
      column: $table.completed, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get lastUpdatedAt => $composableBuilder(
      column: $table.lastUpdatedAt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isDirty => $composableBuilder(
      column: $table.isDirty, builder: (column) => ColumnOrderings(column));
}

class $$FastingSessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FastingSessionsTable> {
  $$FastingSessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get uid =>
      $composableBuilder(column: $table.uid, builder: (column) => column);

  GeneratedColumn<int> get start =>
      $composableBuilder(column: $table.start, builder: (column) => column);

  GeneratedColumn<int> get end =>
      $composableBuilder(column: $table.end, builder: (column) => column);

  GeneratedColumnWithTypeConverter<FastingPlanType, String> get planType =>
      $composableBuilder(column: $table.planType, builder: (column) => column);

  GeneratedColumn<int> get goalHours =>
      $composableBuilder(column: $table.goalHours, builder: (column) => column);

  GeneratedColumn<bool> get completed =>
      $composableBuilder(column: $table.completed, builder: (column) => column);

  GeneratedColumn<int> get lastUpdatedAt => $composableBuilder(
      column: $table.lastUpdatedAt, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<bool> get isDirty =>
      $composableBuilder(column: $table.isDirty, builder: (column) => column);
}

class $$FastingSessionsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $FastingSessionsTable,
    FastingSessionRow,
    $$FastingSessionsTableFilterComposer,
    $$FastingSessionsTableOrderingComposer,
    $$FastingSessionsTableAnnotationComposer,
    $$FastingSessionsTableCreateCompanionBuilder,
    $$FastingSessionsTableUpdateCompanionBuilder,
    (
      FastingSessionRow,
      BaseReferences<_$AppDatabase, $FastingSessionsTable, FastingSessionRow>
    ),
    FastingSessionRow,
    PrefetchHooks Function()> {
  $$FastingSessionsTableTableManager(
      _$AppDatabase db, $FastingSessionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FastingSessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FastingSessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FastingSessionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> uid = const Value.absent(),
            Value<int> start = const Value.absent(),
            Value<int?> end = const Value.absent(),
            Value<FastingPlanType> planType = const Value.absent(),
            Value<int> goalHours = const Value.absent(),
            Value<bool> completed = const Value.absent(),
            Value<int> lastUpdatedAt = const Value.absent(),
            Value<bool> isDeleted = const Value.absent(),
            Value<bool> isDirty = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              FastingSessionsCompanion(
            id: id,
            uid: uid,
            start: start,
            end: end,
            planType: planType,
            goalHours: goalHours,
            completed: completed,
            lastUpdatedAt: lastUpdatedAt,
            isDeleted: isDeleted,
            isDirty: isDirty,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String uid,
            required int start,
            Value<int?> end = const Value.absent(),
            required FastingPlanType planType,
            required int goalHours,
            Value<bool> completed = const Value.absent(),
            required int lastUpdatedAt,
            Value<bool> isDeleted = const Value.absent(),
            Value<bool> isDirty = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              FastingSessionsCompanion.insert(
            id: id,
            uid: uid,
            start: start,
            end: end,
            planType: planType,
            goalHours: goalHours,
            completed: completed,
            lastUpdatedAt: lastUpdatedAt,
            isDeleted: isDeleted,
            isDirty: isDirty,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$FastingSessionsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $FastingSessionsTable,
    FastingSessionRow,
    $$FastingSessionsTableFilterComposer,
    $$FastingSessionsTableOrderingComposer,
    $$FastingSessionsTableAnnotationComposer,
    $$FastingSessionsTableCreateCompanionBuilder,
    $$FastingSessionsTableUpdateCompanionBuilder,
    (
      FastingSessionRow,
      BaseReferences<_$AppDatabase, $FastingSessionsTable, FastingSessionRow>
    ),
    FastingSessionRow,
    PrefetchHooks Function()>;
typedef $$ActivityEntriesTableCreateCompanionBuilder = ActivityEntriesCompanion
    Function({
  required String id,
  required String uid,
  required int recordedAt,
  required String type,
  required int durationMin,
  required double calories,
  Value<int?> steps,
  required ActivitySource source,
  required int lastUpdatedAt,
  Value<bool> isDeleted,
  Value<bool> isDirty,
  Value<int> rowid,
});
typedef $$ActivityEntriesTableUpdateCompanionBuilder = ActivityEntriesCompanion
    Function({
  Value<String> id,
  Value<String> uid,
  Value<int> recordedAt,
  Value<String> type,
  Value<int> durationMin,
  Value<double> calories,
  Value<int?> steps,
  Value<ActivitySource> source,
  Value<int> lastUpdatedAt,
  Value<bool> isDeleted,
  Value<bool> isDirty,
  Value<int> rowid,
});

class $$ActivityEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $ActivityEntriesTable> {
  $$ActivityEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get uid => $composableBuilder(
      column: $table.uid, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get recordedAt => $composableBuilder(
      column: $table.recordedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get durationMin => $composableBuilder(
      column: $table.durationMin, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get calories => $composableBuilder(
      column: $table.calories, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get steps => $composableBuilder(
      column: $table.steps, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<ActivitySource, ActivitySource, String>
      get source => $composableBuilder(
          column: $table.source,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<int> get lastUpdatedAt => $composableBuilder(
      column: $table.lastUpdatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isDirty => $composableBuilder(
      column: $table.isDirty, builder: (column) => ColumnFilters(column));
}

class $$ActivityEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $ActivityEntriesTable> {
  $$ActivityEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get uid => $composableBuilder(
      column: $table.uid, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get recordedAt => $composableBuilder(
      column: $table.recordedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get durationMin => $composableBuilder(
      column: $table.durationMin, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get calories => $composableBuilder(
      column: $table.calories, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get steps => $composableBuilder(
      column: $table.steps, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get source => $composableBuilder(
      column: $table.source, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get lastUpdatedAt => $composableBuilder(
      column: $table.lastUpdatedAt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isDirty => $composableBuilder(
      column: $table.isDirty, builder: (column) => ColumnOrderings(column));
}

class $$ActivityEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ActivityEntriesTable> {
  $$ActivityEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get uid =>
      $composableBuilder(column: $table.uid, builder: (column) => column);

  GeneratedColumn<int> get recordedAt => $composableBuilder(
      column: $table.recordedAt, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<int> get durationMin => $composableBuilder(
      column: $table.durationMin, builder: (column) => column);

  GeneratedColumn<double> get calories =>
      $composableBuilder(column: $table.calories, builder: (column) => column);

  GeneratedColumn<int> get steps =>
      $composableBuilder(column: $table.steps, builder: (column) => column);

  GeneratedColumnWithTypeConverter<ActivitySource, String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<int> get lastUpdatedAt => $composableBuilder(
      column: $table.lastUpdatedAt, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<bool> get isDirty =>
      $composableBuilder(column: $table.isDirty, builder: (column) => column);
}

class $$ActivityEntriesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ActivityEntriesTable,
    ActivityEntryRow,
    $$ActivityEntriesTableFilterComposer,
    $$ActivityEntriesTableOrderingComposer,
    $$ActivityEntriesTableAnnotationComposer,
    $$ActivityEntriesTableCreateCompanionBuilder,
    $$ActivityEntriesTableUpdateCompanionBuilder,
    (
      ActivityEntryRow,
      BaseReferences<_$AppDatabase, $ActivityEntriesTable, ActivityEntryRow>
    ),
    ActivityEntryRow,
    PrefetchHooks Function()> {
  $$ActivityEntriesTableTableManager(
      _$AppDatabase db, $ActivityEntriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ActivityEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ActivityEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ActivityEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> uid = const Value.absent(),
            Value<int> recordedAt = const Value.absent(),
            Value<String> type = const Value.absent(),
            Value<int> durationMin = const Value.absent(),
            Value<double> calories = const Value.absent(),
            Value<int?> steps = const Value.absent(),
            Value<ActivitySource> source = const Value.absent(),
            Value<int> lastUpdatedAt = const Value.absent(),
            Value<bool> isDeleted = const Value.absent(),
            Value<bool> isDirty = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ActivityEntriesCompanion(
            id: id,
            uid: uid,
            recordedAt: recordedAt,
            type: type,
            durationMin: durationMin,
            calories: calories,
            steps: steps,
            source: source,
            lastUpdatedAt: lastUpdatedAt,
            isDeleted: isDeleted,
            isDirty: isDirty,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String uid,
            required int recordedAt,
            required String type,
            required int durationMin,
            required double calories,
            Value<int?> steps = const Value.absent(),
            required ActivitySource source,
            required int lastUpdatedAt,
            Value<bool> isDeleted = const Value.absent(),
            Value<bool> isDirty = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ActivityEntriesCompanion.insert(
            id: id,
            uid: uid,
            recordedAt: recordedAt,
            type: type,
            durationMin: durationMin,
            calories: calories,
            steps: steps,
            source: source,
            lastUpdatedAt: lastUpdatedAt,
            isDeleted: isDeleted,
            isDirty: isDirty,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ActivityEntriesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ActivityEntriesTable,
    ActivityEntryRow,
    $$ActivityEntriesTableFilterComposer,
    $$ActivityEntriesTableOrderingComposer,
    $$ActivityEntriesTableAnnotationComposer,
    $$ActivityEntriesTableCreateCompanionBuilder,
    $$ActivityEntriesTableUpdateCompanionBuilder,
    (
      ActivityEntryRow,
      BaseReferences<_$AppDatabase, $ActivityEntriesTable, ActivityEntryRow>
    ),
    ActivityEntryRow,
    PrefetchHooks Function()>;
typedef $$PhotoEntriesTableCreateCompanionBuilder = PhotoEntriesCompanion
    Function({
  required String id,
  required String uid,
  required int date,
  required PhotoType type,
  Value<String?> storageUrl,
  Value<String?> localPath,
  Value<String?> notes,
  required int lastUpdatedAt,
  Value<bool> isDeleted,
  Value<bool> isDirty,
  Value<int> rowid,
});
typedef $$PhotoEntriesTableUpdateCompanionBuilder = PhotoEntriesCompanion
    Function({
  Value<String> id,
  Value<String> uid,
  Value<int> date,
  Value<PhotoType> type,
  Value<String?> storageUrl,
  Value<String?> localPath,
  Value<String?> notes,
  Value<int> lastUpdatedAt,
  Value<bool> isDeleted,
  Value<bool> isDirty,
  Value<int> rowid,
});

class $$PhotoEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $PhotoEntriesTable> {
  $$PhotoEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get uid => $composableBuilder(
      column: $table.uid, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<PhotoType, PhotoType, String> get type =>
      $composableBuilder(
          column: $table.type,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<String> get storageUrl => $composableBuilder(
      column: $table.storageUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get localPath => $composableBuilder(
      column: $table.localPath, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get lastUpdatedAt => $composableBuilder(
      column: $table.lastUpdatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isDirty => $composableBuilder(
      column: $table.isDirty, builder: (column) => ColumnFilters(column));
}

class $$PhotoEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $PhotoEntriesTable> {
  $$PhotoEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get uid => $composableBuilder(
      column: $table.uid, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get storageUrl => $composableBuilder(
      column: $table.storageUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get localPath => $composableBuilder(
      column: $table.localPath, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get lastUpdatedAt => $composableBuilder(
      column: $table.lastUpdatedAt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isDeleted => $composableBuilder(
      column: $table.isDeleted, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isDirty => $composableBuilder(
      column: $table.isDirty, builder: (column) => ColumnOrderings(column));
}

class $$PhotoEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $PhotoEntriesTable> {
  $$PhotoEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get uid =>
      $composableBuilder(column: $table.uid, builder: (column) => column);

  GeneratedColumn<int> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumnWithTypeConverter<PhotoType, String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get storageUrl => $composableBuilder(
      column: $table.storageUrl, builder: (column) => column);

  GeneratedColumn<String> get localPath =>
      $composableBuilder(column: $table.localPath, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<int> get lastUpdatedAt => $composableBuilder(
      column: $table.lastUpdatedAt, builder: (column) => column);

  GeneratedColumn<bool> get isDeleted =>
      $composableBuilder(column: $table.isDeleted, builder: (column) => column);

  GeneratedColumn<bool> get isDirty =>
      $composableBuilder(column: $table.isDirty, builder: (column) => column);
}

class $$PhotoEntriesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PhotoEntriesTable,
    PhotoEntryRow,
    $$PhotoEntriesTableFilterComposer,
    $$PhotoEntriesTableOrderingComposer,
    $$PhotoEntriesTableAnnotationComposer,
    $$PhotoEntriesTableCreateCompanionBuilder,
    $$PhotoEntriesTableUpdateCompanionBuilder,
    (
      PhotoEntryRow,
      BaseReferences<_$AppDatabase, $PhotoEntriesTable, PhotoEntryRow>
    ),
    PhotoEntryRow,
    PrefetchHooks Function()> {
  $$PhotoEntriesTableTableManager(_$AppDatabase db, $PhotoEntriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PhotoEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PhotoEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PhotoEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> uid = const Value.absent(),
            Value<int> date = const Value.absent(),
            Value<PhotoType> type = const Value.absent(),
            Value<String?> storageUrl = const Value.absent(),
            Value<String?> localPath = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<int> lastUpdatedAt = const Value.absent(),
            Value<bool> isDeleted = const Value.absent(),
            Value<bool> isDirty = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PhotoEntriesCompanion(
            id: id,
            uid: uid,
            date: date,
            type: type,
            storageUrl: storageUrl,
            localPath: localPath,
            notes: notes,
            lastUpdatedAt: lastUpdatedAt,
            isDeleted: isDeleted,
            isDirty: isDirty,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String uid,
            required int date,
            required PhotoType type,
            Value<String?> storageUrl = const Value.absent(),
            Value<String?> localPath = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            required int lastUpdatedAt,
            Value<bool> isDeleted = const Value.absent(),
            Value<bool> isDirty = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              PhotoEntriesCompanion.insert(
            id: id,
            uid: uid,
            date: date,
            type: type,
            storageUrl: storageUrl,
            localPath: localPath,
            notes: notes,
            lastUpdatedAt: lastUpdatedAt,
            isDeleted: isDeleted,
            isDirty: isDirty,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$PhotoEntriesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $PhotoEntriesTable,
    PhotoEntryRow,
    $$PhotoEntriesTableFilterComposer,
    $$PhotoEntriesTableOrderingComposer,
    $$PhotoEntriesTableAnnotationComposer,
    $$PhotoEntriesTableCreateCompanionBuilder,
    $$PhotoEntriesTableUpdateCompanionBuilder,
    (
      PhotoEntryRow,
      BaseReferences<_$AppDatabase, $PhotoEntriesTable, PhotoEntryRow>
    ),
    PhotoEntryRow,
    PrefetchHooks Function()>;
typedef $$SyncLogsTableCreateCompanionBuilder = SyncLogsCompanion Function({
  required String id,
  required String uid,
  required String entityType,
  required String entityId,
  Value<String?> conflictInfo,
  required int createdAt,
  Value<int> rowid,
});
typedef $$SyncLogsTableUpdateCompanionBuilder = SyncLogsCompanion Function({
  Value<String> id,
  Value<String> uid,
  Value<String> entityType,
  Value<String> entityId,
  Value<String?> conflictInfo,
  Value<int> createdAt,
  Value<int> rowid,
});

class $$SyncLogsTableFilterComposer
    extends Composer<_$AppDatabase, $SyncLogsTable> {
  $$SyncLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get uid => $composableBuilder(
      column: $table.uid, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get entityType => $composableBuilder(
      column: $table.entityType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get entityId => $composableBuilder(
      column: $table.entityId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get conflictInfo => $composableBuilder(
      column: $table.conflictInfo, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));
}

class $$SyncLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncLogsTable> {
  $$SyncLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get uid => $composableBuilder(
      column: $table.uid, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get entityType => $composableBuilder(
      column: $table.entityType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get entityId => $composableBuilder(
      column: $table.entityId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get conflictInfo => $composableBuilder(
      column: $table.conflictInfo,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));
}

class $$SyncLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncLogsTable> {
  $$SyncLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get uid =>
      $composableBuilder(column: $table.uid, builder: (column) => column);

  GeneratedColumn<String> get entityType => $composableBuilder(
      column: $table.entityType, builder: (column) => column);

  GeneratedColumn<String> get entityId =>
      $composableBuilder(column: $table.entityId, builder: (column) => column);

  GeneratedColumn<String> get conflictInfo => $composableBuilder(
      column: $table.conflictInfo, builder: (column) => column);

  GeneratedColumn<int> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$SyncLogsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SyncLogsTable,
    SyncLogRow,
    $$SyncLogsTableFilterComposer,
    $$SyncLogsTableOrderingComposer,
    $$SyncLogsTableAnnotationComposer,
    $$SyncLogsTableCreateCompanionBuilder,
    $$SyncLogsTableUpdateCompanionBuilder,
    (SyncLogRow, BaseReferences<_$AppDatabase, $SyncLogsTable, SyncLogRow>),
    SyncLogRow,
    PrefetchHooks Function()> {
  $$SyncLogsTableTableManager(_$AppDatabase db, $SyncLogsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> uid = const Value.absent(),
            Value<String> entityType = const Value.absent(),
            Value<String> entityId = const Value.absent(),
            Value<String?> conflictInfo = const Value.absent(),
            Value<int> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SyncLogsCompanion(
            id: id,
            uid: uid,
            entityType: entityType,
            entityId: entityId,
            conflictInfo: conflictInfo,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String uid,
            required String entityType,
            required String entityId,
            Value<String?> conflictInfo = const Value.absent(),
            required int createdAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              SyncLogsCompanion.insert(
            id: id,
            uid: uid,
            entityType: entityType,
            entityId: entityId,
            conflictInfo: conflictInfo,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SyncLogsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SyncLogsTable,
    SyncLogRow,
    $$SyncLogsTableFilterComposer,
    $$SyncLogsTableOrderingComposer,
    $$SyncLogsTableAnnotationComposer,
    $$SyncLogsTableCreateCompanionBuilder,
    $$SyncLogsTableUpdateCompanionBuilder,
    (SyncLogRow, BaseReferences<_$AppDatabase, $SyncLogsTable, SyncLogRow>),
    SyncLogRow,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UserProfilesTableTableManager get userProfiles =>
      $$UserProfilesTableTableManager(_db, _db.userProfiles);
  $$WeightEntriesTableTableManager get weightEntries =>
      $$WeightEntriesTableTableManager(_db, _db.weightEntries);
  $$MeasurementEntriesTableTableManager get measurementEntries =>
      $$MeasurementEntriesTableTableManager(_db, _db.measurementEntries);
  $$WaterEntriesTableTableManager get waterEntries =>
      $$WaterEntriesTableTableManager(_db, _db.waterEntries);
  $$FoodEntriesTableTableManager get foodEntries =>
      $$FoodEntriesTableTableManager(_db, _db.foodEntries);
  $$CustomFoodsTableTableManager get customFoods =>
      $$CustomFoodsTableTableManager(_db, _db.customFoods);
  $$FastingSessionsTableTableManager get fastingSessions =>
      $$FastingSessionsTableTableManager(_db, _db.fastingSessions);
  $$ActivityEntriesTableTableManager get activityEntries =>
      $$ActivityEntriesTableTableManager(_db, _db.activityEntries);
  $$PhotoEntriesTableTableManager get photoEntries =>
      $$PhotoEntriesTableTableManager(_db, _db.photoEntries);
  $$SyncLogsTableTableManager get syncLogs =>
      $$SyncLogsTableTableManager(_db, _db.syncLogs);
}
