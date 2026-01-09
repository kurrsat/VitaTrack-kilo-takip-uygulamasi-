import 'package:meallog/features/meal_log/data/models/food_search_item_model.dart';

const mockFoodSearchItems = [
  FoodSearchItemModel(
    id: 'mock_tomato',
    name: 'Domates',
    brand: 'Pazar',
    per100gKcal: 18,
    per100gProtein: 0.9,
    per100gCarbs: 3.9,
    per100gFat: 0.2,
    source: 'mock',
    isVerified: true,
  ),
  FoodSearchItemModel(
    id: 'mock_olive_oil',
    name: 'Zeytinya��',
    brand: 'Ege',
    per100gKcal: 884,
    per100gProtein: 0,
    per100gCarbs: 0,
    per100gFat: 100,
    source: 'mock',
    isVerified: true,
  ),
  FoodSearchItemModel(
    id: 'mock_yogurt',
    name: 'Yo�urt',
    brand: 'Sade',
    per100gKcal: 61,
    per100gProtein: 3.5,
    per100gCarbs: 4.7,
    per100gFat: 3.3,
    source: 'mock',
    isVerified: false,
  ),
];
