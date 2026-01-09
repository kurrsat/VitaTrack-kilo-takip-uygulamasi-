import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weightvault/core/providers/providers.dart';
import 'package:weightvault/data/db/app_database.dart';
import 'package:weightvault/data/db/database_service.dart';
import 'package:weightvault/data/repositories/activity_repository_impl.dart';
import 'package:weightvault/data/repositories/custom_food_repository_impl.dart';
import 'package:weightvault/data/repositories/fasting_repository_impl.dart';
import 'package:weightvault/data/repositories/food_repository_impl.dart';
import 'package:weightvault/data/repositories/measurement_repository_impl.dart';
import 'package:weightvault/data/repositories/photo_repository_impl.dart';
import 'package:weightvault/data/repositories/sync_log_repository_impl.dart';
import 'package:weightvault/data/repositories/user_profile_repository_impl.dart';
import 'package:weightvault/data/repositories/water_repository_impl.dart';
import 'package:weightvault/data/repositories/weight_repository_impl.dart';
import 'package:weightvault/domain/repositories/repositories.dart';
AppDatabase _db(DatabaseService service) => service.db;

final userProfileRepositoryProvider = Provider<UserProfileRepository>((ref) {
  return DriftUserProfileRepository(_db(ref.watch(databaseServiceProvider)));
});

final weightRepositoryProvider = Provider<WeightRepository>((ref) {
  return DriftWeightRepository(_db(ref.watch(databaseServiceProvider)));
});

final measurementRepositoryProvider = Provider<MeasurementRepository>((ref) {
  return DriftMeasurementRepository(_db(ref.watch(databaseServiceProvider)));
});

final waterRepositoryProvider = Provider<WaterRepository>((ref) {
  return DriftWaterRepository(_db(ref.watch(databaseServiceProvider)));
});

final foodRepositoryProvider = Provider<FoodRepository>((ref) {
  return DriftFoodRepository(_db(ref.watch(databaseServiceProvider)));
});

final customFoodRepositoryProvider = Provider<CustomFoodRepository>((ref) {
  return DriftCustomFoodRepository(_db(ref.watch(databaseServiceProvider)));
});

final fastingRepositoryProvider = Provider<FastingRepository>((ref) {
  return DriftFastingRepository(_db(ref.watch(databaseServiceProvider)));
});

final activityRepositoryProvider = Provider<ActivityRepository>((ref) {
  return DriftActivityRepository(_db(ref.watch(databaseServiceProvider)));
});

final photoRepositoryProvider = Provider<PhotoRepository>((ref) {
  return DriftPhotoRepository(_db(ref.watch(databaseServiceProvider)));
});

final syncLogRepositoryProvider = Provider<SyncLogRepository>((ref) {
  return DriftSyncLogRepository(_db(ref.watch(databaseServiceProvider)));
});
