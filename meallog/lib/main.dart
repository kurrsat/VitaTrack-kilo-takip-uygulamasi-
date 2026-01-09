import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meallog/app.dart';
import 'package:meallog/core/storage/hive_boxes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  final searchCacheBox = await Hive.openBox<Map>(searchCacheBoxName);
  final foodEntriesBox = await Hive.openBox<Map>(foodEntriesBoxName);
  final recentItemsBox = await Hive.openBox<Map>(recentItemsBoxName);
  final favoriteItemsBox = await Hive.openBox<Map>(favoriteItemsBoxName);

  runApp(
    ProviderScope(
      overrides: [
        searchCacheBoxProvider.overrideWithValue(searchCacheBox),
        foodEntriesBoxProvider.overrideWithValue(foodEntriesBox),
        recentItemsBoxProvider.overrideWithValue(recentItemsBox),
        favoriteItemsBoxProvider.overrideWithValue(favoriteItemsBox),
      ],
      child: const MealLogApp(),
    ),
  );
}
