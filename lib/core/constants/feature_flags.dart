class FeatureFlagKeys {
  static const demoModeEnabled = 'demo_mode_enabled';
  static const adaptiveGoalsEnabled = 'adaptive_goals_enabled';
  static const premiumPaywallVariant = 'premium_paywall_variant';
  static const defaultSmoothingMethod = 'default_smoothing_method';
  static const defaultAlpha = 'default_alpha';
  static const defaultBeta = 'default_beta';
}

class FeatureFlagDefaults {
  static const values = <String, dynamic>{
    FeatureFlagKeys.demoModeEnabled: true,
    FeatureFlagKeys.adaptiveGoalsEnabled: true,
    FeatureFlagKeys.premiumPaywallVariant: 'A',
    FeatureFlagKeys.defaultSmoothingMethod: 'EXPONENTIAL',
    FeatureFlagKeys.defaultAlpha: 0.3,
    FeatureFlagKeys.defaultBeta: 0.1,
  };
}
