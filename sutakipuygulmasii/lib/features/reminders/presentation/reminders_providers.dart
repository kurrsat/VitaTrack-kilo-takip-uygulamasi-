import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:water_reminder/app/providers.dart';
import 'package:water_reminder/features/reminders/domain/reminder_config.dart';

const _reminderConfigBox = 'reminder_config';
const _reminderConfigKey = 'default';

final reminderConfigProvider =
    StateNotifierProvider<ReminderConfigNotifier, ReminderConfig>((ref) {
  return ReminderConfigNotifier(ref);
});

class ReminderConfigNotifier extends StateNotifier<ReminderConfig> {
  ReminderConfigNotifier(this._ref)
      : super(
          const ReminderConfig(
            id: _reminderConfigKey,
            mode: ReminderMode.interval,
            isEnabled: true,
          ),
        ) {
    _load();
  }

  final Ref _ref;

  Future<void> _load() async {
    final box = await Hive.openBox(_reminderConfigBox);
    final data = box.get(_reminderConfigKey);
    if (data is Map) {
      state = ReminderConfig.fromJson(Map<String, dynamic>.from(data));
    }
    await _reschedule(state);
  }

  Future<void> _persist(ReminderConfig config) async {
    final box = await Hive.openBox(_reminderConfigBox);
    await box.put(_reminderConfigKey, config.toJson());
  }

  Future<void> _reschedule(ReminderConfig config) async {
    final service = _ref.read(notificationServiceProvider);
    if (!config.isEnabled) {
      await service.cancelAllReminders();
      return;
    }
    await service.scheduleReminders(config);
  }

  Future<void> _apply(ReminderConfig config) async {
    state = config;
    await _persist(config);
    await _reschedule(config);
  }

  Future<void> setEnabled(bool isEnabled) async {
    await _apply(state.copyWith(isEnabled: isEnabled));
  }

  Future<void> setMode(ReminderMode mode) async {
    await _apply(state.copyWith(mode: mode));
  }

  Future<void> setIntervalMinutes(int minutes) async {
    await _apply(state.copyWith(intervalMinutes: minutes));
  }

  Future<void> setFixedTimes(List<TimeRange> times) async {
    await _apply(state.copyWith(fixedTimes: times));
  }

  Future<void> setActiveDays(Set<DayOfWeek> days) async {
    await _apply(state.copyWith(activeDays: days));
  }

  Future<void> setAwakeWindow(TimeRange range) async {
    await _apply(state.copyWith(awakeWindow: range));
  }

  Future<void> setQuietHours(TimeRange? range) async {
    await _apply(state.copyWith(quietHours: range));
  }

  Future<void> setDefaultCupAmount(int amountMl) async {
    await _apply(state.copyWith(defaultCupAmountMl: amountMl));
  }
}
