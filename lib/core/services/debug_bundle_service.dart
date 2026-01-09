import 'dart:convert';

import 'package:cross_file/cross_file.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:weightvault/core/logger/logger_service.dart';
import 'package:weightvault/core/services/feature_flag_service.dart';
class DebugBundleService {
  DebugBundleService(this._logger, this._featureFlags);

  final LoggerService _logger;
  final FeatureFlagService _featureFlags;

  Future<XFile> buildBundle() async {
    final info = await PackageInfo.fromPlatform();
    final payload = {
      'generated_at': DateTime.now().toIso8601String(),
      'app_version': '${info.version}+${info.buildNumber}',
      'feature_flags': {
        'demo_mode_enabled': _featureFlags.demoModeEnabled,
        'adaptive_goals_enabled': _featureFlags.adaptiveGoalsEnabled,
        'premium_paywall_variant': _featureFlags.paywallVariant,
        'default_smoothing_method': _featureFlags.defaultSmoothingMethod,
        'default_alpha': _featureFlags.defaultAlpha,
        'default_beta': _featureFlags.defaultBeta,
      },
      'logs': _logger.entries,
    };
    final json = const JsonEncoder.withIndent('  ').convert(payload);
    return XFile.fromData(
      utf8.encode(json),
      mimeType: 'application/json',
      name: 'weightvault_debug_bundle.json',
    );
  }
}
