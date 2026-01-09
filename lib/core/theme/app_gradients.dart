import 'package:flutter/material.dart';

/// App gradient color definitions for modern UI
class AppGradients {
  // Feature Gradients
  static const waterGradient = LinearGradient(
    colors: [Color(0xFF00D4FF), Color(0xFF00BFAE)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const foodGradient = LinearGradient(
    colors: [Color(0xFFFF6B35), Color(0xFFFFB347)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const activityGradient = LinearGradient(
    colors: [Color(0xFF00FF7F), Color(0xFF7FFF00)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const photoGradient = LinearGradient(
    colors: [Color(0xFFFF006E), Color(0xFF8338EC)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const weightGradient = LinearGradient(
    colors: [Color(0xFF3B82F6), Color(0xFF60A5FA)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Background Gradients
  static const homeBackground = LinearGradient(
    colors: [
      Color(0xFFFFF4E0),
      Color(0xFFFFD4B8),
      Color(0xFFFFB4A2),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const settingsBackground = LinearGradient(
    colors: [
      Color(0xFFE0F7FF),
      Color(0xFFFFFFFF),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const reportsBackground = LinearGradient(
    colors: [
      Color(0xFFFFFBF0),
      Color(0xFFFFFFFF),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // Additional feature gradients
  static const settingsProfileGradient = LinearGradient(
    colors: [Color(0xFF4FC3F7), Color(0xFF29B6F6)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const settingsNotificationsGradient = LinearGradient(
    colors: [Color(0xFFFFB74D), Color(0xFFFF9800)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const settingsSupportGradient = LinearGradient(
    colors: [Color(0xFF9575CD), Color(0xFF7E57C2)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
