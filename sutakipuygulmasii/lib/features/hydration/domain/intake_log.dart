import 'package:equatable/equatable.dart';
import 'package:water_reminder/features/hydration/domain/beverage_type.dart';

/// A single water intake log entry
///
/// Timestamps are stored in UTC for timezone consistency
/// Beverage type determines hydration contribution
class IntakeLog extends Equatable {
  const IntakeLog({
    required this.id,
    required this.amountMl,
    required this.timestampUtc,
    this.beverageType = BeverageType.water, // Default to water for backward compatibility
  });

  /// Unique identifier (typically timestamp-based)
  final String id;

  /// Amount consumed in milliliters
  final int amountMl;

  /// When the intake occurred (UTC)
  final DateTime timestampUtc;

  /// Type of beverage consumed
  final BeverageType beverageType;

  /// Calculate effective hydration contribution based on beverage type
  /// Example: 250ml coffee (0.80) = 200ml effective hydration
  int get effectiveHydrationMl => beverageType.calculateEffectiveHydration(amountMl);

  /// Create a copy with modified fields
  IntakeLog copyWith({
    String? id,
    int? amountMl,
    DateTime? timestampUtc,
    BeverageType? beverageType,
  }) {
    return IntakeLog(
      id: id ?? this.id,
      amountMl: amountMl ?? this.amountMl,
      timestampUtc: timestampUtc ?? this.timestampUtc,
      beverageType: beverageType ?? this.beverageType,
    );
  }

  /// Convert to JSON for Hive storage
  Map<String, dynamic> toJson() => {
        'id': id,
        'amountMl': amountMl,
        'timestampUtc': timestampUtc.toIso8601String(),
        'beverageType': beverageType.name, // Store enum name
      };

  /// Create from JSON stored in Hive
  factory IntakeLog.fromJson(Map<String, dynamic> json) {
    return IntakeLog(
      id: json['id'] as String,
      amountMl: json['amountMl'] as int,
      timestampUtc: DateTime.parse(json['timestampUtc'] as String),
      // Handle migration: if beverageType is missing, default to water
      beverageType: json['beverageType'] != null
          ? BeverageType.values.byName(json['beverageType'] as String)
          : BeverageType.water,
    );
  }

  @override
  List<Object?> get props => [id, amountMl, timestampUtc, beverageType];

  @override
  String toString() {
    return 'IntakeLog(id: $id, amountMl: $amountMl, beverageType: ${beverageType.label}, '
        'effectiveHydration: ${effectiveHydrationMl}ml, timestampUtc: $timestampUtc)';
  }
}
