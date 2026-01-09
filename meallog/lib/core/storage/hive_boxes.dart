import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

const searchCacheBoxName = 'search_cache';
const foodEntriesBoxName = 'food_entries';
const recentItemsBoxName = 'recent_items';
const favoriteItemsBoxName = 'favorite_items';

final searchCacheBoxProvider = Provider<Box<Map>>((ref) {
  throw UnimplementedError();
});

final foodEntriesBoxProvider = Provider<Box<Map>>((ref) {
  throw UnimplementedError();
});

final recentItemsBoxProvider = Provider<Box<Map>>((ref) {
  throw UnimplementedError();
});

final favoriteItemsBoxProvider = Provider<Box<Map>>((ref) {
  throw UnimplementedError();
});
