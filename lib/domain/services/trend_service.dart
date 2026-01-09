import 'dart:math';

import 'package:weightvault/domain/models/models.dart';

class TrendService {
  List<double> calculateTrend(
    List<WeightEntry> entries, {
    required TrendMethod method,
    double alpha = 0.3,
    double beta = 0.1,
    int movingAverageDays = 7,
  }) {
    if (entries.isEmpty) {
      return [];
    }
    final sorted = [...entries]..sort((a, b) => a.dateTime.compareTo(b.dateTime));
    final values = sorted.map((entry) => entry.weightKg).toList();

    switch (method) {
      case TrendMethod.movingAverage:
        return _movingAverage(sorted, movingAverageDays);
      case TrendMethod.exponential:
        return _exponential(values, alpha);
      case TrendMethod.doubleExponential:
        return _doubleExponential(values, alpha, beta);
      case TrendMethod.custom:
        return _exponential(values, alpha.clamp(0.05, 0.95));
    }
  }

  bool isPlateau(
    List<WeightEntry> entries,
    List<double> trend, {
    int days = 14,
    double slopeThreshold = 0.02,
  }) {
    if (entries.length < 2 || trend.length != entries.length) {
      return false;
    }
    final sorted = [...entries]..sort((a, b) => a.dateTime.compareTo(b.dateTime));
    final cutoff = sorted.last.dateTime.subtract(Duration(days: days));
    final indices = <int>[];
    for (var i = 0; i < sorted.length; i++) {
      if (sorted[i].dateTime.isAfter(cutoff)) {
        indices.add(i);
      }
    }
    if (indices.length < 2) {
      return false;
    }
    final firstIndex = indices.first;
    final lastIndex = indices.last;
    final daysDelta =
        sorted[lastIndex].dateTime.difference(sorted[firstIndex].dateTime).inHours /
            24.0;
    if (daysDelta <= 0) {
      return false;
    }
    final slope = (trend[lastIndex] - trend[firstIndex]) / daysDelta;
    return slope.abs() < slopeThreshold;
  }

  List<double> _movingAverage(List<WeightEntry> sorted, int windowDays) {
    final trend = <double>[];
    var start = 0;
    for (var i = 0; i < sorted.length; i++) {
      final currentDate = sorted[i].dateTime;
      while (start < i && currentDate.difference(sorted[start].dateTime).inDays > windowDays) {
        start++;
      }
      final slice = sorted.sublist(start, i + 1).map((e) => e.weightKg).toList();
      final avg = slice.reduce((a, b) => a + b) / slice.length;
      trend.add(avg);
    }
    return trend;
  }

  List<double> _exponential(List<double> values, double alpha) {
    final trend = <double>[];
    var last = values.first;
    trend.add(last);
    for (var i = 1; i < values.length; i++) {
      last = alpha * values[i] + (1 - alpha) * last;
      trend.add(last);
    }
    return trend;
  }

  List<double> _doubleExponential(List<double> values, double alpha, double beta) {
    final trend = <double>[];
    var level = values.first;
    var trendTerm = values.length > 1 ? values[1] - values.first : 0.0;
    trend.add(level);
    for (var i = 1; i < values.length; i++) {
      final value = values[i];
      final prevLevel = level;
      level = alpha * value + (1 - alpha) * (level + trendTerm);
      trendTerm = beta * (level - prevLevel) + (1 - beta) * trendTerm;
      trend.add(level + trendTerm);
    }
    return trend.map((v) => double.parse(v.toStringAsFixed(3))).toList();
  }

  double estimateEtaDays(List<WeightEntry> entries, List<double> trend, double goalWeight) {
    if (entries.length < 2 || trend.length != entries.length) {
      return double.infinity;
    }
    final sorted = [...entries]..sort((a, b) => a.dateTime.compareTo(b.dateTime));
    final lastIndex = sorted.length - 1;
    final recentIndex = max(0, sorted.length - 7);
    final daysDelta =
        sorted[lastIndex].dateTime.difference(sorted[recentIndex].dateTime).inHours /
            24.0;
    if (daysDelta <= 0) {
      return double.infinity;
    }
    final slope = (trend[lastIndex] - trend[recentIndex]) / daysDelta;
    if (slope.abs() < 0.001) {
      return double.infinity;
    }
    final remaining = goalWeight - trend[lastIndex];
    return remaining / slope;
  }
}
