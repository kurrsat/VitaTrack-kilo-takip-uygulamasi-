import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:water_reminder/core/logger/logger.dart';
import 'package:water_reminder/features/onboarding/domain/user_profile.dart';

final _logger = LoggerFactory.getLogger('OnboardingProviders');

/// Provider for checking if this is first run
final isFirstRunProvider = FutureProvider<bool>((ref) async {
  final box = await Hive.openBox('app_state');
  final isCompleted =
      box.get('onboarding_completed', defaultValue: false) as bool;
  return !isCompleted;
});

/// Provider for current onboarding step
final onboardingStepProvider = StateProvider<int>((ref) => 0);

/// Provider for user profile during onboarding
final onboardingProfileProvider =
    StateNotifierProvider<OnboardingProfileNotifier, UserProfile?>((ref) {
  return OnboardingProfileNotifier();
});

class OnboardingProfileNotifier extends StateNotifier<UserProfile?> {
  OnboardingProfileNotifier() : super(null);

  void updateWeight(double weightKg) {
    state = (state ?? _defaultProfile()).copyWith(weightKg: weightKg);
  }

  void updateActivityLevel(ActivityLevel level) {
    state = (state ?? _defaultProfile()).copyWith(activityLevel: level);
  }

  void updateWakeTime(int hour, int minute) {
    state = (state ?? _defaultProfile()).copyWith(
      wakeHour: hour,
      wakeMinute: minute,
    );
  }

  void updateSleepTime(int hour, int minute) {
    state = (state ?? _defaultProfile()).copyWith(
      sleepHour: hour,
      sleepMinute: minute,
    );
  }

  void updateUnitSystem(UnitSystem system) {
    state = (state ?? _defaultProfile()).copyWith(unitSystem: system);
  }

  void updateDailyGoal(int? goalMl) {
    state = (state ?? _defaultProfile()).copyWith(dailyGoalMl: goalMl);
  }

  void updateDayStartHour(int hour) {
    state = (state ?? _defaultProfile()).copyWith(dayStartHour: hour);
  }

  void updateCupPresets(List<CupPreset> presets) {
    state = (state ?? _defaultProfile()).copyWith(cupPresets: presets);
  }

  UserProfile _defaultProfile() {
    return const UserProfile(
      weightKg: 70.0,
      activityLevel: ActivityLevel.moderate,
      wakeHour: 7,
      wakeMinute: 0,
      sleepHour: 22,
      sleepMinute: 0,
      cupPresets: [],
    );
  }

  Future<void> completeOnboarding() async {
    if (state == null) {
      _logger.error('Cannot complete onboarding: profile is null');
      return;
    }

    try {
      // Save profile
      final profileBox = await Hive.openBox('user_profile');
      await profileBox.put('profile', state!.toJson());

      // Mark onboarding as completed
      final appStateBox = await Hive.openBox('app_state');
      await appStateBox.put('onboarding_completed', true);

      _logger.info('Onboarding completed successfully');
    } catch (e, stackTrace) {
      _logger.error('Failed to complete onboarding', e, stackTrace);
      rethrow;
    }
  }
}

/// Provider for saved user profile
final userProfileProvider = FutureProvider<UserProfile?>((ref) async {
  try {
    final box = await Hive.openBox('user_profile');
    final data = box.get('profile');

    if (data == null) return null;

    return UserProfile.fromJson(Map<String, dynamic>.from(data as Map));
  } catch (e, stackTrace) {
    _logger.error('Failed to load user profile', e, stackTrace);
    return null;
  }
});
