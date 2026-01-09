import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weightvault/core/providers/app_init_provider.dart';
import 'package:weightvault/data/repositories/repository_providers.dart';
import 'package:weightvault/domain/models/models.dart';
final todayFoodEntriesProvider = StreamProvider<List<FoodEntry>>((ref) {
  final uid = ref.watch(currentUserIdProvider);
  if (uid == null) {
    return const Stream.empty();
  }
  return ref.watch(foodRepositoryProvider).watchByDate(uid, DateTime.now().toUtc());
});

final customFoodsProvider = StreamProvider<List<CustomFood>>((ref) {
  final uid = ref.watch(currentUserIdProvider);
  if (uid == null) {
    return const Stream.empty();
  }
  return ref.watch(customFoodRepositoryProvider).watchAll(uid);
});
