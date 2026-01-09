import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:weightvault/l10n/app_localizations.dart';
import 'package:weightvault/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  const runIntegration = bool.fromEnvironment('RUN_INTEGRATION');

  testWidgets('demo flow: add weight -> analytics', (tester) async {
    if (!runIntegration) {
      return;
    }
    SharedPreferences.setMockInitialValues({
      'onboarding_complete': true,
      'mode_selected': true,
      'demo_mode': true,
      'demo_seeded': true,
    });
    await app.main();
    await tester.pumpAndSettle(const Duration(seconds: 5));
    final context = tester.element(find.byType(MaterialApp));
    final strings = AppLocalizations.of(context)!;
    expect(find.text(strings.dashboard), findsOneWidget);
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).first, '80');
    await tester.tap(find.text(strings.save));
    await tester.pumpAndSettle();
    await tester.tap(find.text(strings.analytics));
    await tester.pumpAndSettle();
    expect(find.text(strings.analytics), findsOneWidget);
  });
}
