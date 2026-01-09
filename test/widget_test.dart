import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weightvault/app/app.dart';

void main() {
  testWidgets('WeightVaultApp builds', (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: WeightVaultApp()));
    expect(find.byType(WeightVaultApp), findsOneWidget);
  });
}
