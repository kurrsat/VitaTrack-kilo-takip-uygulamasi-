import 'package:dio/dio.dart';
import 'package:meallog/features/meal_log/data/models/food_search_item_model.dart';

class FoodRemoteDataSource {
  FoodRemoteDataSource(this._dio);

  final Dio _dio;

  Future<List<FoodSearchItemModel>> searchFoods(String query) async {
    final response = await _dio.get<Map<String, dynamic>>(
      'https://world.openfoodfacts.org/api/v2/search',
      queryParameters: {
        'search_terms': query,
        'page_size': 24,
        'fields': 'product_name,product_name_tr,generic_name,brands,code,nutriments,data_quality_tags',
      },
    );

    final data = response.data;
    final products = (data?['products'] as List?)?.cast<Map<String, dynamic>>() ?? const [];
    return products
        .map(FoodSearchItemModel.fromOpenFoodFacts)
        .where((item) => item.name.trim().isNotEmpty)
        .toList();
  }
}
