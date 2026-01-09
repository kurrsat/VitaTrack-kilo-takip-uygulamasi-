import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meallog/core/storage/hive_boxes.dart';
import 'package:meallog/features/meal_log/data/datasources/food_local_data_source.dart';
import 'package:meallog/features/meal_log/data/datasources/food_remote_data_source.dart';
import 'package:meallog/features/meal_log/data/repositories/food_repository_impl.dart';
import 'package:meallog/features/meal_log/domain/repositories/food_repository.dart';
import 'package:meallog/features/meal_log/domain/usecases/add_food_entry.dart';
import 'package:meallog/features/meal_log/domain/usecases/delete_food_entry.dart';
import 'package:meallog/features/meal_log/domain/usecases/get_day_log.dart';
import 'package:meallog/features/meal_log/domain/usecases/get_favorites.dart';
import 'package:meallog/features/meal_log/domain/usecases/get_recent_items.dart';
import 'package:meallog/features/meal_log/domain/usecases/save_recent.dart';
import 'package:meallog/features/meal_log/domain/usecases/search_foods.dart';
import 'package:meallog/features/meal_log/domain/usecases/toggle_favorite.dart';
import 'package:meallog/features/meal_log/domain/usecases/update_food_entry.dart';
import 'package:meallog/features/meal_log/domain/entities/food_search_item.dart';
import 'package:meallog/features/meal_log/presentation/controllers/day_log_controller.dart';
import 'package:meallog/features/meal_log/presentation/controllers/search_controller.dart';

final dioProvider = Provider<Dio>((ref) {
  return Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 8),
      receiveTimeout: const Duration(seconds: 8),
    ),
  );
});

final foodRemoteDataSourceProvider = Provider<FoodRemoteDataSource>((ref) {
  return FoodRemoteDataSource(ref.watch(dioProvider));
});

final foodLocalDataSourceProvider = Provider<FoodLocalDataSource>((ref) {
  final searchBox = ref.watch(searchCacheBoxProvider);
  final entriesBox = ref.watch(foodEntriesBoxProvider);
  final recentBox = ref.watch(recentItemsBoxProvider);
  final favoritesBox = ref.watch(favoriteItemsBoxProvider);
  return FoodLocalDataSource(
    searchCacheBox: searchBox,
    entriesBox: entriesBox,
    recentBox: recentBox,
    favoritesBox: favoritesBox,
  );
});

final foodRepositoryProvider = Provider<FoodRepository>((ref) {
  return FoodRepositoryImpl(
    remoteDataSource: ref.watch(foodRemoteDataSourceProvider),
    localDataSource: ref.watch(foodLocalDataSourceProvider),
  );
});

final searchFoodsUseCaseProvider = Provider<SearchFoodsUseCase>((ref) {
  return SearchFoodsUseCase(ref.watch(foodRepositoryProvider));
});

final addFoodEntryUseCaseProvider = Provider<AddFoodEntryUseCase>((ref) {
  return AddFoodEntryUseCase(ref.watch(foodRepositoryProvider));
});

final updateFoodEntryUseCaseProvider = Provider<UpdateFoodEntryUseCase>((ref) {
  return UpdateFoodEntryUseCase(ref.watch(foodRepositoryProvider));
});

final deleteFoodEntryUseCaseProvider = Provider<DeleteFoodEntryUseCase>((ref) {
  return DeleteFoodEntryUseCase(ref.watch(foodRepositoryProvider));
});

final getDayLogUseCaseProvider = Provider<GetDayLogUseCase>((ref) {
  return GetDayLogUseCase(ref.watch(foodRepositoryProvider));
});

final getRecentItemsUseCaseProvider = Provider<GetRecentItemsUseCase>((ref) {
  return GetRecentItemsUseCase(ref.watch(foodRepositoryProvider));
});

final getFavoritesUseCaseProvider = Provider<GetFavoritesUseCase>((ref) {
  return GetFavoritesUseCase(ref.watch(foodRepositoryProvider));
});

final toggleFavoriteUseCaseProvider = Provider<ToggleFavoriteUseCase>((ref) {
  return ToggleFavoriteUseCase(ref.watch(foodRepositoryProvider));
});

final saveRecentUseCaseProvider = Provider<SaveRecentUseCase>((ref) {
  return SaveRecentUseCase(ref.watch(foodRepositoryProvider));
});

final dayLogControllerProvider =
    StateNotifierProvider<DayLogController, DayLogState>((ref) {
  return DayLogController(
    getDayLog: ref.watch(getDayLogUseCaseProvider),
    addEntry: ref.watch(addFoodEntryUseCaseProvider),
    updateEntry: ref.watch(updateFoodEntryUseCaseProvider),
    deleteEntry: ref.watch(deleteFoodEntryUseCaseProvider),
  )..load();
});

final searchControllerProvider =
    StateNotifierProvider.autoDispose<SearchController, SearchState>((ref) {
  return SearchController(
    searchFoods: ref.watch(searchFoodsUseCaseProvider),
  );
});

final recentItemsProvider = FutureProvider<List<FoodSearchItem>>((ref) async {
  final result = await ref.watch(getRecentItemsUseCaseProvider).call();
  return result.when(
    success: (data) => data,
    failure: (_) => [],
  );
});

final favoriteItemsProvider = FutureProvider<List<FoodSearchItem>>((ref) async {
  final result = await ref.watch(getFavoritesUseCaseProvider).call();
  return result.when(
    success: (data) => data,
    failure: (_) => [],
  );
});

final updateRecentsProvider = Provider<Future<void> Function(FoodSearchItem)>((ref) {
  final useCase = ref.watch(saveRecentUseCaseProvider);
  return (item) async {
    await useCase.call(item);
    ref.invalidate(recentItemsProvider);
  };
});

final toggleFavoriteProvider = Provider<Future<void> Function(FoodSearchItem)>((ref) {
  final useCase = ref.watch(toggleFavoriteUseCaseProvider);
  return (item) async {
    await useCase.call(item);
    ref.invalidate(favoriteItemsProvider);
  };
});
