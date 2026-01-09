import 'package:flutter_test/flutter_test.dart';

import 'package:weightvault/domain/services/sync_resolver.dart';

void main() {
  test('uses remote when newer', () {
    const resolver = SyncResolver();
    final local = DateTime.utc(2024);
    final remote = DateTime.utc(2024, 1, 2);
    expect(resolver.shouldUseRemote(local, remote), isTrue);
  });

  test('keeps local when newer', () {
    const resolver = SyncResolver();
    final local = DateTime.utc(2024, 1, 2);
    final remote = DateTime.utc(2024);
    expect(resolver.shouldUseRemote(local, remote), isFalse);
  });
}
