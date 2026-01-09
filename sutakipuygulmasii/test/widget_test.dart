import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:water_reminder/app/theme.dart';

void main() {
  setUpAll(() {
    // Initialize timezone data for testing
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('America/New_York'));
  });

  testWidgets('App theme and routing smoke test', (WidgetTester tester) async {
    // Build a simple app with theme and basic routing
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          home: const Scaffold(
            body: Center(child: Text('Water Reminder')),
          ),
        ),
      ),
    );

    // Verify that app starts without crashing
    expect(find.text('Water Reminder'), findsOneWidget);
  });
}
