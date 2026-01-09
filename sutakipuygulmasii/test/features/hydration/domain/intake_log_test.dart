import 'package:flutter_test/flutter_test.dart';
import 'package:water_reminder/features/hydration/domain/beverage_type.dart';
import 'package:water_reminder/features/hydration/domain/intake_log.dart';

void main() {
  group('IntakeLog', () {
    test('creates instance with required fields', () {
      final timestampUtc = DateTime.utc(2024, 1, 15, 12, 0, 0);
      final log = IntakeLog(
        id: 'test-id',
        amountMl: 250,
        timestampUtc: timestampUtc,
      );

      expect(log.id, 'test-id');
      expect(log.amountMl, 250);
      expect(log.timestampUtc, timestampUtc);
      expect(log.beverageType, BeverageType.water);
      expect(log.effectiveHydrationMl, 250);
    });

    test('creates instance with specified beverage type', () {
      final timestampUtc = DateTime.utc(2024, 1, 15, 12, 0, 0);
      final log = IntakeLog(
        id: 'test-id',
        amountMl: 250,
        timestampUtc: timestampUtc,
        beverageType: BeverageType.coffee,
      );

      expect(log.beverageType, BeverageType.coffee);
      expect(log.effectiveHydrationMl, 200);
    });

    test('stores timestamp in UTC', () {
      final timestampUtc = DateTime.utc(2024, 1, 15, 12, 0, 0);
      final log = IntakeLog(
        id: 'test-id',
        amountMl: 250,
        timestampUtc: timestampUtc,
      );

      expect(log.timestampUtc.isUtc, true);
    });

    test('toJson serializes correctly', () {
      final timestampUtc = DateTime.utc(2024, 1, 15, 12, 0, 0);
      final log = IntakeLog(
        id: 'test-id',
        amountMl: 250,
        timestampUtc: timestampUtc,
        beverageType: BeverageType.herbalTea,
      );

      final json = log.toJson();

      expect(json['id'], 'test-id');
      expect(json['amountMl'], 250);
      expect(json['timestampUtc'], '2024-01-15T12:00:00.000Z');
      expect(json['beverageType'], 'herbalTea');
    });

    test('fromJson deserializes correctly', () {
      final json = {
        'id': 'test-id',
        'amountMl': 250,
        'timestampUtc': '2024-01-15T12:00:00.000Z',
        'beverageType': 'greenTea',
      };

      final log = IntakeLog.fromJson(json);

      expect(log.id, 'test-id');
      expect(log.amountMl, 250);
      expect(log.timestampUtc, DateTime.utc(2024, 1, 15, 12, 0, 0));
      expect(log.beverageType, BeverageType.greenTea);
    });

    test('fromJson defaults beverage type when missing', () {
      final json = {
        'id': 'test-id',
        'amountMl': 250,
        'timestampUtc': '2024-01-15T12:00:00.000Z',
      };

      final log = IntakeLog.fromJson(json);

      expect(log.beverageType, BeverageType.water);
    });

    test('copyWith creates new instance with updated fields', () {
      final timestampUtc = DateTime.utc(2024, 1, 15, 12, 0, 0);
      final log = IntakeLog(
        id: 'test-id',
        amountMl: 250,
        timestampUtc: timestampUtc,
      );

      final updated = log.copyWith(
        amountMl: 500,
        beverageType: BeverageType.juice,
      );

      expect(updated.id, 'test-id');
      expect(updated.amountMl, 500);
      expect(updated.timestampUtc, timestampUtc);
      expect(updated.beverageType, BeverageType.juice);
    });

    test('equality works correctly', () {
      final timestampUtc = DateTime.utc(2024, 1, 15, 12, 0, 0);
      final log1 = IntakeLog(
        id: 'test-id',
        amountMl: 250,
        timestampUtc: timestampUtc,
      );
      final log2 = IntakeLog(
        id: 'test-id',
        amountMl: 250,
        timestampUtc: timestampUtc,
      );

      expect(log1, log2);
    });

    test('round-trip serialization preserves data', () {
      final timestampUtc = DateTime.utc(2024, 1, 15, 12, 0, 0);
      final original = IntakeLog(
        id: 'test-id',
        amountMl: 250,
        timestampUtc: timestampUtc,
        beverageType: BeverageType.sportsDrink,
      );

      final json = original.toJson();
      final restored = IntakeLog.fromJson(json);

      expect(restored, original);
    });
  });
}
