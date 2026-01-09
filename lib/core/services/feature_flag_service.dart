import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:weightvault/core/constants/feature_flags.dart';

class FeatureFlagService {
  FeatureFlagService(this._remoteConfig);

  final FirebaseRemoteConfig? _remoteConfig;

  Future<void> init() async {
    final remoteConfig = _remoteConfig;
    if (remoteConfig == null) {
      return;
    }
    await remoteConfig.setDefaults(FeatureFlagDefaults.values);
    await remoteConfig.fetchAndActivate();
  }

  bool getBool(String key) {
    final remoteConfig = _remoteConfig;
    if (remoteConfig == null) {
      final value = FeatureFlagDefaults.values[key];
      return value is bool && value;
    }
    return remoteConfig.getBool(key);
  }

  double getDouble(String key) {
    final remoteConfig = _remoteConfig;
    if (remoteConfig == null) {
      final value = FeatureFlagDefaults.values[key];
      return value is num ? value.toDouble() : 0.0;
    }
    return remoteConfig.getDouble(key);
  }

  String getString(String key) {
    final remoteConfig = _remoteConfig;
    if (remoteConfig == null) {
      final value = FeatureFlagDefaults.values[key];
      return value is String ? value : '';
    }
    return remoteConfig.getString(key);
  }

  bool get demoModeEnabled => getBool(FeatureFlagKeys.demoModeEnabled);
  bool get adaptiveGoalsEnabled => getBool(FeatureFlagKeys.adaptiveGoalsEnabled);
  String get paywallVariant => getString(FeatureFlagKeys.premiumPaywallVariant);
  String get defaultSmoothingMethod => getString(FeatureFlagKeys.defaultSmoothingMethod);
  double get defaultAlpha => getDouble(FeatureFlagKeys.defaultAlpha);
  double get defaultBeta => getDouble(FeatureFlagKeys.defaultBeta);
}
