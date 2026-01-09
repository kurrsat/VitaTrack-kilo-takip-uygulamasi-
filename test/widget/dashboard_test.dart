import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:weightvault/features/dashboard/dashboard_page.dart';
import 'package:weightvault/features/settings/profile_providers.dart';
import 'package:weightvault/features/weight/weight_providers.dart';
import 'package:weightvault/l10n/app_localizations.dart';

void main() {
  testWidgets('Dashboard shows hero and goal placeholders when no entries', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
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
    );
    await tester.pumpAndSettle();
    final context = tester.element(find.byType(DashboardPage));
    final strings = AppLocalizations.of(context)!;
    expect(find.text(strings.dashboard), findsOneWidget);
    // 'Günlük İlerleme' is currently hardcoded in DashboardPage
    expect(find.text('Günlük İlerleme'), findsOneWidget);
  });
}
