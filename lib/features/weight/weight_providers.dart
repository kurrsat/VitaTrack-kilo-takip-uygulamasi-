import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weightvault/core/constants/app_constants.dart';
import 'package:weightvault/core/providers/app_init_provider.dart';
import 'package:weightvault/core/providers/providers.dart';
import 'package:weightvault/core/services/feature_flag_service.dart';
import 'package:weightvault/core/services/preferences_service.dart';
import 'package:weightvault/data/repositories/repository_providers.dart';
import 'package:weightvault/domain/models/models.dart';
final weightEntriesProvider = StreamProvider<List<WeightEntry>>((ref) {
  final uid = ref.watch(currentUserIdProvider);
  if (uid == null) {
    return const Stream.empty();
  }
  return ref.watch(weightRepositoryProvider).watchEntries(uid);
});

class TrendSettings {
  const TrendSettings({
    required this.method,
    required this.alpha,
    required this.beta,
  });

  final TrendMethod method;
  final double alpha;
  final double beta;

  TrendSettings copyWith({TrendMethod? method, double? alpha, double? beta}) {
    return TrendSettings(
      method: method ?? this.method,
      alpha: alpha ?? this.alpha,
      beta: beta ?? this.beta,
    );
  }
}

class TrendSettingsNotifier extends StateNotifier<TrendSettings> {
  TrendSettingsNotifier(this._prefs, FeatureFlagService? flags)
      : super(
          TrendSettings(
            method: _parseMethod(flags?.defaultSmoothingMethod),
            alpha: _prefs?.trendAlpha ?? flags?.defaultAlpha ?? AppConstants.defaultAlpha,
            beta: _prefs?.trendBeta ?? flags?.defaultBeta ?? AppConstants.defaultBeta,
          ),
        );

  final PreferencesService? _prefs;

  static TrendMethod _parseMethod(String? value) {
    switch ((value ?? 'EXPONENTIAL').toUpperCase()) {
      case 'MOVING_AVERAGE':
        return TrendMethod.movingAverage;
      case 'DOUBLE_EXPONENTIAL':
        return TrendMethod.doubleExponential;
      case 'CUSTOM':
        return TrendMethod.custom;
      case 'EXPONENTIAL':
      default:
        return TrendMethod.exponential;
    }
  }

  Future<void> setMethod(TrendMethod method) async {
    state = state.copyWith(method: method);
    await _prefs?.setTrendMethod(method.name);
  }

  Future<void> setAlpha(double alpha) async {
    state = state.copyWith(alpha: alpha);
    await _prefs?.setTrendAlpha(alpha);
  }

  Future<void> setBeta(double beta) async {
    state = state.copyWith(beta: beta);
    await _prefs?.setTrendBeta(beta);
  }
}

final trendSettingsProvider = StateNotifierProvider<TrendSettingsNotifier, TrendSettings>((ref) {
  final prefs = ref.watch(preferencesProvider).maybeWhen(
        data: (value) => value,
        orElse: () => null,
      );
  final flags = ref.watch(featureFlagServiceProvider);
  return TrendSettingsNotifier(prefs, flags);
});

final weightSummaryProvider = Provider<double>((ref) {
  final entries = ref.watch(weightEntriesProvider).value ?? [];
  if (entries.isEmpty) {
    return 0;
  }
  return entries.last.weightKg;
});

final plateauProvider = Provider<bool>((ref) {
  final entries = ref.watch(weightEntriesProvider).value ?? [];
  final settings = ref.watch(trendSettingsProvider);
  if (entries.isEmpty) {
    return false;
  }
  final trend = ref.read(trendServiceProvider).calculateTrend(
        entries,
        method: settings.method,
        alpha: settings.alpha,
        beta: settings.beta,
      );
  return ref.read(trendServiceProvider).isPlateau(entries, trend);
});
