import 'package:flutter/material.dart';

/// Types of beverages with different hydration coefficients
/// 
/// Each beverage has a hydration multiplier that determines how much
/// it contributes to daily hydration goal. Water = 1.0 (100%)
enum BeverageType {
  water(
    'Su',
    '💧',
    1.0,
    Color(0xFF2196F3), // Blue
  ),
  herbalTea(
    'Bitki Cay',
    '🌿',
    0.95,
    Color(0xFF4CAF50), // Green
  ),
  greenTea(
    'Yesil Cay',
    '🍵',
    0.90,
    Color(0xFF8BC34A), // Light green
  ),
  blackTea(
    'Siyah Cay',
    '🫖',
    0.85,
    Color(0xFF795548), // Brown
  ),
  coffee(
    'Kahve',
    '☕',
    0.80,
    Color(0xFF6D4C41), // Dark brown
  ),
  juice(
    'Meyve Suyu',
    '🧃',
    0.85,
    Color(0xFFFF9800), // Orange
  ),
  milk(
    'Sut',
    '🥛',
    0.85,
    Color(0xFFFFF9C4), // Light yellow
  ),
  soda(
    'Gazoz',
    '🥤',
    0.75,
    Color(0xFFE91E63), // Pink
  ),
  sportsDrink(
    'Spor Icecegi',
    '⚡',
    0.90,
    Color(0xFF00BCD4), // Cyan
  );

  const BeverageType(
    this.label,
    this.icon,
    this.hydrationMultiplier,
    this.color,
  );

  /// Display name for the beverage
  final String label;

  /// Emoji icon for visual representation
  final String icon;

  /// Hydration coefficient (0.0 to 1.0)
  /// Determines how much this beverage contributes to daily goal
  /// Examples:
  /// - Water: 1.0 (100%) - baseline
  /// - Coffee: 0.80 (80%) - caffeine has diuretic effect
  /// - Sports drink: 0.90 (90%) - electrolytes help retention
  final double hydrationMultiplier;

  /// Color for UI representation
  final Color color;

  /// Get percentage representation (e.g., "85%")
  String get hydrationPercentage =>
      '${(hydrationMultiplier * 100).toInt()}%';

  /// Calculate effective hydration from actual amount
  int calculateEffectiveHydration(int amountMl) {
    return (amountMl * hydrationMultiplier).round();
  }
}
