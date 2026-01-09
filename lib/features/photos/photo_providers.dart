import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weightvault/core/providers/app_init_provider.dart';
import 'package:weightvault/data/repositories/repository_providers.dart';
import 'package:weightvault/domain/models/models.dart';
final photoEntriesProvider = StreamProvider<List<PhotoEntry>>((ref) {
  final uid = ref.watch(currentUserIdProvider);
  if (uid == null) {
    return const Stream.empty();
  }
  return ref.watch(photoRepositoryProvider).watchAll(uid);
});
