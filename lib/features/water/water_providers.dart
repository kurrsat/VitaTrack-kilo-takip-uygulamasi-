import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weightvault/core/providers/app_init_provider.dart';
import 'package:weightvault/data/repositories/repository_providers.dart';
import 'package:weightvault/domain/models/models.dart';
final todayWaterProvider = StreamProvider<List<WaterEntry>>((ref) {
  final uid = ref.watch(currentUserIdProvider);
  if (uid == null) {
    return const Stream.empty();
  }
  return ref.watch(waterRepositoryProvider).watchByDate(uid, DateTime.now().toUtc());
});

final waterHistoryProvider = StreamProvider<List<WaterEntry>>((ref) {
  final uid = ref.watch(currentUserIdProvider);
  if (uid == null) {
    return const Stream.empty();
  }
  return ref.watch(waterRepositoryProvider).watchAll(uid);
});
