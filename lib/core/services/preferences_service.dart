import 'package:shared_preferences/shared_preferences.dart';
import 'package:weightvault/core/constants/prefs_keys.dart';

class PreferencesService {
  PreferencesService(this._prefs);

  final SharedPreferences _prefs;

  bool get onboardingComplete => _prefs.getBool(PrefKeys.onboardingComplete) ?? false;
  bool get modeSelected => _prefs.getBool(PrefKeys.modeSelected) ?? false;
  bool get demoMode => _prefs.getBool(PrefKeys.demoMode) ?? false;
  bool get biometricLockEnabled =>
      _prefs.getBool(PrefKeys.biometricLockEnabled) ?? false;
  bool get privacyScreenEnabled =>
      _prefs.getBool(PrefKeys.privacyScreenEnabled) ?? false;
  bool get dbEncryptionEnabled =>
      _prefs.getBool(PrefKeys.dbEncryptionEnabled) ?? false;

  Future<void> setOnboardingComplete({required bool value}) =>
      _prefs.setBool(PrefKeys.onboardingComplete, value);

  Future<void> setModeSelected({required bool value}) =>
      _prefs.setBool(PrefKeys.modeSelected, value);

  Future<void> setDemoMode({required bool value}) =>
      _prefs.setBool(PrefKeys.demoMode, value);

  Future<void> setBiometricLockEnabled({required bool value}) =>
      _prefs.setBool(PrefKeys.biometricLockEnabled, value);

  Future<void> setPrivacyScreenEnabled({required bool value}) =>
      _prefs.setBool(PrefKeys.privacyScreenEnabled, value);

  Future<void> setDbEncryptionEnabled({required bool value}) =>
      _prefs.setBool(PrefKeys.dbEncryptionEnabled, value);

  int? get quietHoursStartMinutes => _prefs.getInt(PrefKeys.quietHoursStart);
  int? get quietHoursEndMinutes => _prefs.getInt(PrefKeys.quietHoursEnd);

  Future<void> setQuietHours({required int startMinutes, required int endMinutes}) async {
    await _prefs.setInt(PrefKeys.quietHoursStart, startMinutes);
    await _prefs.setInt(PrefKeys.quietHoursEnd, endMinutes);
  }

  int? get weightReminderMinutes => _prefs.getInt(PrefKeys.weightReminderMinutes);
  int? get waterReminderMinutes => _prefs.getInt(PrefKeys.waterReminderMinutes);
  int? get mealReminderMinutes => _prefs.getInt(PrefKeys.mealReminderMinutes);

  Future<void> setWeightReminderMinutes(int? minutes) async {
    if (minutes == null) {
      await _prefs.remove(PrefKeys.weightReminderMinutes);
      return;
    }
    await _prefs.setInt(PrefKeys.weightReminderMinutes, minutes);
  }

  Future<void> setWaterReminderMinutes(int? minutes) async {
    if (minutes == null) {
      await _prefs.remove(PrefKeys.waterReminderMinutes);
      return;
    }
    await _prefs.setInt(PrefKeys.waterReminderMinutes, minutes);
  }

  Future<void> setMealReminderMinutes(int? minutes) async {
    if (minutes == null) {
      await _prefs.remove(PrefKeys.mealReminderMinutes);
      return;
    }
    await _prefs.setInt(PrefKeys.mealReminderMinutes, minutes);
  }

  bool get mealReminderEnabled => _prefs.getBool(PrefKeys.mealReminderEnabled) ?? false;
  Future<void> setMealReminderEnabled(bool value) => _prefs.setBool(PrefKeys.mealReminderEnabled, value);

  bool get waterReminderEnabled => _prefs.getBool(PrefKeys.waterReminderEnabled) ?? false;
  Future<void> setWaterReminderEnabled(bool value) => _prefs.setBool(PrefKeys.waterReminderEnabled, value);

  bool get activityReminderEnabled => _prefs.getBool(PrefKeys.activityReminderEnabled) ?? false;
  Future<void> setActivityReminderEnabled(bool value) => _prefs.setBool(PrefKeys.activityReminderEnabled, value);


  String? get trendMethod => _prefs.getString(PrefKeys.trendMethod);
  double? get trendAlpha => _prefs.getDouble(PrefKeys.trendAlpha);
  double? get trendBeta => _prefs.getDouble(PrefKeys.trendBeta);

  Future<void> setTrendMethod(String value) =>
      _prefs.setString(PrefKeys.trendMethod, value);

  Future<void> setTrendAlpha(double value) =>
      _prefs.setDouble(PrefKeys.trendAlpha, value);

  Future<void> setTrendBeta(double value) =>
      _prefs.setDouble(PrefKeys.trendBeta, value);

  Future<void> setOnboardingGoal({
    required String goalType,
    required double goalWeight,
    required DateTime goalDate,
    required String units,
    required String name,
    required double heightCm,
    int? birthYear,
    String? gender,
    double? currentWeightKg,
  }) async {
    await _prefs.setString(PrefKeys.onboardingGoalType, goalType);
    await _prefs.setDouble(PrefKeys.onboardingGoalWeight, goalWeight);
    await _prefs.setInt(
      PrefKeys.onboardingGoalDate,
      goalDate.toUtc().millisecondsSinceEpoch,
    );
    await _prefs.setString(PrefKeys.onboardingUnits, units);
    await _prefs.setString(PrefKeys.onboardingName, name);
    await _prefs.setDouble(PrefKeys.onboardingHeightCm, heightCm);
    if (birthYear != null) {
      await _prefs.setInt(PrefKeys.onboardingBirthYear, birthYear);
    }
    if (gender != null) {
      await _prefs.setString(PrefKeys.onboardingGender, gender);
    }
    if (currentWeightKg != null) {
      await _prefs.setDouble(PrefKeys.onboardingCurrentWeight, currentWeightKg);
    }
  }

  Map<String, dynamic> get onboardingGoalDraft => {
        'goalType': _prefs.getString(PrefKeys.onboardingGoalType),
        'goalWeight': _prefs.getDouble(PrefKeys.onboardingGoalWeight),
        'goalDate': _prefs.getInt(PrefKeys.onboardingGoalDate),
        'units': _prefs.getString(PrefKeys.onboardingUnits),
        'name': _prefs.getString(PrefKeys.onboardingName),
        'heightCm': _prefs.getDouble(PrefKeys.onboardingHeightCm),
        'birthYear': _prefs.getInt(PrefKeys.onboardingBirthYear),
        'gender': _prefs.getString(PrefKeys.onboardingGender),
        'currentWeight': _prefs.getDouble(PrefKeys.onboardingCurrentWeight),
      };

  bool get demoSeeded => _prefs.getBool(PrefKeys.demoSeeded) ?? false;
  Future<void> setDemoSeeded({required bool value}) =>
      _prefs.setBool(PrefKeys.demoSeeded, value);

  Future<void> setLastSyncAt(DateTime dateTime) =>
      _prefs.setInt(PrefKeys.lastSyncAt, dateTime.millisecondsSinceEpoch);

  DateTime? get lastSyncAt {
    final value = _prefs.getInt(PrefKeys.lastSyncAt);
    if (value == null) {
      return null;
    }
    return DateTime.fromMillisecondsSinceEpoch(value, isUtc: true);
  }
}
