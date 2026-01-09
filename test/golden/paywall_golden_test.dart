import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:weightvault/features/premium/premium_paywall_page.dart';
import 'package:weightvault/l10n/app_localizations.dart';

void main() {
  const runGoldens = bool.fromEnvironment('RUN_GOLDENS');

  testGoldens('Paywall golden', (tester) async {
    if (!runGoldens) {
      return;
    }
    await loadAppFonts();
    final builder = DeviceBuilder()
      ..addScenario(
        widget: const ProviderScope(
          child: MaterialApp(
            locale: Locale('en'),
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            home: PremiumPaywallPage(
              previewPlans: [
                PaywallPlan(title: 'Monthly', description: 'Full access', price: r'$4.99'),
                PaywallPlan(title: 'Yearly', description: 'Best value', price: r'$39.99'),
              ],
            ),
          ),
        ),
        name: 'paywall-preview',
      );
    await tester.pumpDeviceBuilder(builder);
    await screenMatchesGolden(tester, 'paywall_preview');
  });
}
