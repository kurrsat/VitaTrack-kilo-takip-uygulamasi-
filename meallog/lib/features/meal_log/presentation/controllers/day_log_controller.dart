import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meallog/core/errors/result.dart';
import 'package:meallog/core/utils/date_utils.dart';
import 'package:meallog/features/meal_log/domain/entities/day_summary.dart';
import 'package:meallog/features/meal_log/domain/entities/food_entry.dart';
import 'package:meallog/features/meal_log/domain/usecases/add_food_entry.dart';
import 'package:meallog/features/meal_log/domain/usecases/delete_food_entry.dart';
import 'package:meallog/features/meal_log/domain/usecases/get_day_log.dart';
import 'package:meallog/features/meal_log/domain/usecases/update_food_entry.dart';

class DayLogState {
  DayLogState({
    required this.date,
    required this.log,
    required this.isLoading,
    required this.errorMessage,
  });

  final DateTime date;
  final DayLog log;
  final bool isLoading;
  final String? errorMessage;

  DayLogState copyWith({
    DateTime? date,
    DayLog? log,
    bool? isLoading,
    String? errorMessage,
  }) {
    return DayLogState(
      date: date ?? this.date,
      log: log ?? this.log,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }

  static DayLogState initial() {
    final today = normalizeDate(DateTime.now());
    return DayLogState(
      date: today,
      log: DayLog(date: today, entries: const [], summary: DaySummary.empty()),
      isLoading: false,
      errorMessage: null,
    );
  }
}

class DayLogController extends StateNotifier<DayLogState> {
  DayLogController({
    required GetDayLogUseCase getDayLog,
    required AddFoodEntryUseCase addEntry,
    required UpdateFoodEntryUseCase updateEntry,
    required DeleteFoodEntryUseCase deleteEntry,
  })  : _getDayLog = getDayLog,
        _addEntry = addEntry,
        _updateEntry = updateEntry,
        _deleteEntry = deleteEntry,
        super(DayLogState.initial());

  final GetDayLogUseCase _getDayLog;
  final AddFoodEntryUseCase _addEntry;
  final UpdateFoodEntryUseCase _updateEntry;
  final DeleteFoodEntryUseCase _deleteEntry;

  Future<void> load({DateTime? date}) async {
    final targetDate = date ?? state.date;
    state = state.copyWith(date: targetDate, isLoading: true, errorMessage: null);
    final result = await _getDayLog.call(targetDate);
    result.when(
      success: (log) {
        state = state.copyWith(log: log, isLoading: false, errorMessage: null);
      },
      failure: (error) {
        state = state.copyWith(isLoading: false, errorMessage: error.message);
      },
    );
  }

  Future<void> addEntry(FoodEntry entry) async {
    final result = await _addEntry.call(entry);
    if (result is Failure) {
      state = state.copyWith(errorMessage: result.error.message);
      return;
    }
    await load(date: entry.date);
  }

  Future<void> updateEntry(FoodEntry entry) async {
    final result = await _updateEntry.call(entry);
    if (result is Failure) {
      state = state.copyWith(errorMessage: result.error.message);
      return;
    }
    await load(date: entry.date);
  }

  Future<void> deleteEntry(String id) async {
    final result = await _deleteEntry.call(id);
    if (result is Failure) {
      state = state.copyWith(errorMessage: result.error.message);
      return;
    }
    await load();
  }
}
