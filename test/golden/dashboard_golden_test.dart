import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:weightvault/features/dashboard/dashboard_page.dart';
import 'package:weightvault/features/settings/profile_providers.dart';
import 'package:weightvault/features/weight/weight_providers.dart';
import 'package:weightvault/l10n/app_localizations.dart';

void main() {
  const runGoldens = bool.fromEnvironment('RUN_GOLDENS');

  testGoldens('Dashboard golden', (tester) async {
    if (!runGoldens) {
      return;
    }
    await loadAppFonts();
    final builder = DeviceBuilder()
      ..addScenario(
        widget: ProviderScope(
          overrides: [
            weightEntriesProvider.overrideWith((ref) => Stream.value([])),
            userProfileProvider.overrideWith((ref) => Stream.value(null)),
            trendSettingsProvider.overrideWith((ref) => TrendSettingsNotifier(null, null)),
          ],
          child: const MaterialApp(
            locale: Locale('en'),
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            home: DashboardPage(),
          ),
        ),
        name: 'dashboard-empty',
      );
    await tester.pumpDeviceBuilder(builder);
    await screenMatchesGolden(tester, 'dashboard_empty');
  });
}
