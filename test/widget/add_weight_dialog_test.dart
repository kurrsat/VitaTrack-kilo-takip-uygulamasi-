import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:weightvault/features/weight/add_weight_dialog.dart';
import 'package:weightvault/l10n/app_localizations.dart';

void main() {
  testWidgets('AddWeightDialog renders fields', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          locale: Locale('en'),
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(body: AddWeightDialog()),
        ),
      ),
    );
    await tester.pumpAndSettle();
    final context = tester.element(find.byType(AddWeightDialog));
    final strings = AppLocalizations.of(context)!;
    expect(find.text(strings.addWeight), findsOneWidget);
    expect(find.byType(TextField), findsWidgets);
  });
}
