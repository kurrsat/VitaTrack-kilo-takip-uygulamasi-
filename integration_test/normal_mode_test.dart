import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:weightvault/app/app.dart';
import 'package:weightvault/core/providers/app_init_provider.dart';
import 'package:weightvault/data/repositories/repository_providers.dart';
import 'package:weightvault/l10n/app_localizations.dart';
import 'package:weightvault/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  const runIntegration = bool.fromEnvironment('RUN_INTEGRATION');
  const runNormal = bool.fromEnvironment('RUN_INTEGRATION_NORMAL');

  testWidgets('normal flow: register -> add weight -> sync dirty', (tester) async {
    if (!runIntegration || !runNormal) {
      return;
    }
    SharedPreferences.setMockInitialValues({
      'onboarding_complete': true,
      'mode_selected': true,
      'demo_mode': false,
    });
    await app.main();
    await tester.pumpAndSettle(const Duration(seconds: 8));

    final context = tester.element(find.byType(MaterialApp));
    final strings = AppLocalizations.of(context)!;

    await tester.tap(find.text(strings.createAccount));
    await tester.pumpAndSettle();

    final email = 'test_${DateTime.now().millisecondsSinceEpoch}@example.com';
    await tester.enterText(find.byType(TextField).at(0), email);
    await tester.enterText(find.byType(TextField).at(1), 'Password123!');
    await tester.tap(find.text(strings.register));
    await tester.pumpAndSettle(const Duration(seconds: 8));

    expect(find.text(strings.dashboard), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add).first);
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).first, '79.5');
    await tester.tap(find.text(strings.save));
    await tester.pumpAndSettle(const Duration(seconds: 4));

    final container = ProviderScope.containerOf(tester.element(find.byType(WeightVaultApp)));
    final uid = container.read(currentUserIdProvider);
    expect(uid, isNotNull);
    final dirty = await container.read(weightRepositoryProvider).getDirtyEntries(uid!);
    expect(dirty.isNotEmpty, true);
  });
}
