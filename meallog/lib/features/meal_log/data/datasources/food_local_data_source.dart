import 'package:hive/hive.dart';
import 'package:meallog/core/utils/date_utils.dart';
import 'package:meallog/features/meal_log/data/models/food_entry_model.dart';
import 'package:meallog/features/meal_log/data/models/food_search_item_model.dart';

class CachedSearchResult {
  CachedSearchResult({required this.items, required this.cachedAt});

  final List<FoodSearchItemModel> items;
  final DateTime cachedAt;
}

class FoodLocalDataSource {
  FoodLocalDataSource({
    required Box<Map> searchCacheBox,
    required Box<Map> entriesBox,
    required Box<Map> recentBox,
    required Box<Map> favoritesBox,
  })  : _searchCacheBox = searchCacheBox,
        _entriesBox = entriesBox,
        _recentBox = recentBox,
        _favoritesBox = favoritesBox;

  final Box<Map> _searchCacheBox;
  final Box<Map> _entriesBox;
  final Box<Map> _recentBox;
  final Box<Map> _favoritesBox;

  Future<void> cacheSearch(String query, List<FoodSearchItemModel> items) async {
    final key = _normalizeQuery(query);
    await _searchCacheBox.put(key, {
      'cachedAt': DateTime.now().toIso8601String(),
      'items': items.map((item) => item.toJson()).toList(),
    });
  }

  CachedSearchResult? getCachedSearch(String query) {
    final key = _normalizeQuery(query);
    final cached = _searchCacheBox.get(key);
    if (cached == null) return null;
    final cachedAt = DateTime.tryParse(cached['cachedAt'] as String? ?? '');
    final items = (cached['items'] as List?)
            ?.cast<Map>()
            .map((item) => FoodSearchItemModel.fromJson(item.cast<String, dynamic>()))
            .toList() ??
        [];
    if (cachedAt == null) return null;
    return CachedSearchResult(items: items, cachedAt: cachedAt);
  }

  Future<void> saveEntry(FoodEntryModel entry) async {
    await _entriesBox.put(entry.id, entry.toJson());
  }

  Future<void> updateEntry(FoodEntryModel entry) async {
    await _entriesBox.put(entry.id, entry.toJson());
  }

  Future<void> deleteEntry(String id) async {
    await _entriesBox.delete(id);
  }

  Future<List<FoodEntryModel>> getEntriesForDate(DateTime date) async {
    final key = dayKey(date);
    final values = _entriesBox.values
        .whereType<Map>()
        .where((value) => value['dateKey'] == key)
        .map((value) => FoodEntryModel.fromJson(value.cast<String, dynamic>()))
        .toList();
    values.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return values;
  }

  Future<void> saveRecent(FoodSearchItemModel item) async {
    await _recentBox.put(item.id, {
      ...item.toJson(),
      'lastUsed': DateTime.now().toIso8601String(),
    });
  }

  Future<List<FoodSearchItemModel>> getRecent() async {
    final values = _recentBox.values
        .whereType<Map>()
        .map((value) => value.cast<String, dynamic>())
        .toList();
    values.sort((a, b) {
      final aTime = DateTime.tryParse(a['lastUsed'] as String? ?? '') ?? DateTime(1970);
      final bTime = DateTime.tryParse(b['lastUsed'] as String? ?? '') ?? DateTime(1970);
      return bTime.compareTo(aTime);
    });
    return values.take(8).map(FoodSearchItemModel.fromJson).toList();
  }

  Future<List<FoodSearchItemModel>> getFavorites() async {
    return _favoritesBox.values
        .whereType<Map>()
        .map((value) => value.cast<String, dynamic>())
        .map(FoodSearchItemModel.fromJson)
        .toList();
  }

  Future<bool> toggleFavorite(FoodSearchItemModel item) async {
    if (_favoritesBox.containsKey(item.id)) {
      await _favoritesBox.delete(item.id);
      return false;
    }
    await _favoritesBox.put(item.id, item.toJson());
    return true;
  }

  static String _normalizeQuery(String query) => query.trim().toLowerCase();
}
