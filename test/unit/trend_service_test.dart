import 'package:flutter_test/flutter_test.dart';

import 'package:weightvault/domain/models/models.dart';
import 'package:weightvault/domain/services/trend_service.dart';

void main() {
  test('exponential smoothing follows last value', () {
    final entries = [
      WeightEntry(
        id: '1',
        uid: 'u1',
        dateTime: DateTime.utc(2024),
        weightKg: 80,
        lastUpdatedAt: DateTime.utc(2024),
      ),
      WeightEntry(
        id: '2',
        uid: 'u1',
        dateTime: DateTime.utc(2024, 1, 2),
        weightKg: 79,
        lastUpdatedAt: DateTime.utc(2024, 1, 2),
      ),
    ];
    final trend = TrendService().calculateTrend(entries, method: TrendMethod.exponential, alpha: 0.5);
    expect(trend.length, entries.length);
    expect(trend.last, closeTo(79.5, 0.01));
  });
}
