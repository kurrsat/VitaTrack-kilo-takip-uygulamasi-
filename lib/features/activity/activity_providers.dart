import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weightvault/core/providers/app_init_provider.dart';
import 'package:weightvault/core/providers/providers.dart';
import 'package:weightvault/data/repositories/repository_providers.dart';
import 'package:weightvault/domain/models/models.dart';
final activityEntriesProvider = StreamProvider<List<ActivityEntry>>((ref) {
  final uid = ref.watch(currentUserIdProvider);
  if (uid == null) {
    return const Stream.empty();
  }
  return ref.watch(activityRepositoryProvider).watchAll(uid);
});

final todayStepsProvider = FutureProvider<int>((ref) async {
  return ref.watch(healthServiceProvider).fetchTodaySteps();
});
