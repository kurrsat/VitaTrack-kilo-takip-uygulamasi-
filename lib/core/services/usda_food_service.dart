import 'package:dio/dio.dart';
import 'package:weightvault/core/config/env.dart';

class UsdaFoodService {
  UsdaFoodService({Dio? dio}) : _dio = dio ?? Dio();

  final Dio _dio;

  Future<Map<String, dynamic>?> searchFirstByName(String query) async {
    final trimmed = query.trim();
    final apiKey = Env.usdaApiKey;
    if (trimmed.isEmpty || apiKey == null || apiKey.isEmpty) {
      return null;
    }
    final response = await _dio.get<Map<String, dynamic>>(
      'https://api.nal.usda.gov/fdc/v1/foods/search',
      queryParameters: {
        'api_key': apiKey,
        'query': trimmed,
        'pageSize': 10,
      },
    );
    if (response.statusCode == 200) {
      final data = response.data;
      final foods = (data?['foods'] as List?)?.cast<Map<String, dynamic>>() ?? const [];
      return _pickBestFood(foods, trimmed);
    }
    return null;
  }

  Map<String, dynamic>? _pickBestFood(List<Map<String, dynamic>> foods, String query) {
    if (foods.isEmpty) return null;
    final normalizedQuery = _normalize(query);
    final matched = <Map<String, dynamic>>[];
    for (final food in foods) {
      final description = food['description']?.toString().trim() ?? '';
      if (description.isEmpty) continue;
      if (_normalize(description).contains(normalizedQuery)) {
        matched.add(food);
      }
    }
    final candidates = matched.isNotEmpty ? matched : foods;
    final withCalories = candidates.where(_hasCalories).toList();
    final preferred = withCalories.isNotEmpty ? withCalories : candidates;
    final best = (preferred..sort((a, b) {
      final rankCompare = _dataTypeRank(a).compareTo(_dataTypeRank(b));
      if (rankCompare != 0) return rankCompare;
      final aDesc = a['description']?.toString().trim() ?? '';
      final bDesc = b['description']?.toString().trim() ?? '';
      return aDesc.length.compareTo(bDesc.length);
    }))
        .first;
    return _toOpenFoodFactsProduct(best);
  }

  Map<String, dynamic>? _toOpenFoodFactsProduct(Map<String, dynamic> food) {
    final description = food['description']?.toString().trim() ?? '';
    if (description.isEmpty) return null;
    final nutrients = _nutrients(food);
    final nutriments = <String, dynamic>{};
    final normalization = _servingNormalization(food);
    final kcal = _energyKcal(nutrients, normalization: normalization);
    final protein = _nutrientValue(
      nutrients,
      id: 1003,
      name: 'Protein',
      normalization: normalization,
    );
    final carbs = _nutrientValue(
      nutrients,
      id: 1005,
      name: 'Carbohydrate, by difference',
      normalization: normalization,
    );
    final fat = _nutrientValue(
      nutrients,
      id: 1004,
      name: 'Total lipid (fat)',
      normalization: normalization,
    );
    if (kcal != null) nutriments['energy-kcal_100g'] = kcal;
    if (protein != null) nutriments['proteins_100g'] = protein;
    if (carbs != null) nutriments['carbohydrates_100g'] = carbs;
    if (fat != null) nutriments['fat_100g'] = fat;
    final result = <String, dynamic>{
      'product_name': description,
      'nutriments': nutriments,
    };
    final brand = _pickBrand(food);
    if (brand.isNotEmpty) {
      result['brands'] = brand;
    }
    return result;
  }

  bool _hasCalories(Map<String, dynamic> food) {
    return _energyKcal(_nutrients(food), normalization: _servingNormalization(food)) != null;
  }

  List<Map<String, dynamic>> _nutrients(Map<String, dynamic> food) {
    final raw = food['foodNutrients'];
    if (raw is List) {
      return raw.cast<Map<String, dynamic>>();
    }
    return const [];
  }

  double? _energyKcal(List<Map<String, dynamic>> nutrients, {double normalization = 1}) {
    final byId = _nutrientValue(
      nutrients,
      id: 1008,
      name: 'Energy',
      normalization: normalization,
    );
    if (byId != null && byId > 0) return byId;
    return null;
  }

  double? _nutrientValue(
    List<Map<String, dynamic>> nutrients, {
    int? id,
    String? name,
    double normalization = 1,
  }) {
    for (final nutrient in nutrients) {
      if (id != null && nutrient['nutrientId'] == id) {
        return _nutrientAmount(nutrient, normalization);
      }
      if (name != null) {
        final nutrientName = nutrient['nutrientName'] ?? nutrient['name'];
        if (nutrientName != null &&
            nutrientName.toString().toLowerCase() == name.toLowerCase()) {
          return _nutrientAmount(nutrient, normalization);
        }
      }
    }
    return null;
  }

  double? _nutrientAmount(Map<String, dynamic> nutrient, double normalization) {
    final value = _toDouble(nutrient['value'] ?? nutrient['amount']);
    if (value == null) return null;
    final unit = nutrient['unitName']?.toString().toUpperCase();
    var normalized = value;
    if (unit == 'KJ') {
      normalized = normalized / 4.184;
    }
    if (normalization != 1) {
      normalized = normalized * normalization;
    }
    return normalized;
  }

  double? _toDouble(dynamic value) {
    if (value == null) return null;
    if (value is num) return value.toDouble();
    return double.tryParse(value.toString());
  }

  double _servingNormalization(Map<String, dynamic> food) {
    final type = food['dataType']?.toString().toLowerCase() ?? '';
    if (type != 'branded') return 1;
    final servingSize = _toDouble(food['servingSize']);
    if (servingSize == null || servingSize <= 0) return 1;
    final unit = food['servingSizeUnit']?.toString().toLowerCase() ?? '';
    if (unit == 'g' || unit == 'gram' || unit == 'grams') {
      return 100 / servingSize;
    }
    return 1;
  }

  String _pickBrand(Map<String, dynamic> food) {
    final brandOwner = food['brandOwner']?.toString().trim() ?? '';
    if (brandOwner.isNotEmpty) return brandOwner;
    return food['brandName']?.toString().trim() ?? '';
  }

  int _dataTypeRank(Map<String, dynamic> food) {
    final type = food['dataType']?.toString().toLowerCase() ?? '';
    if (type == 'foundation') return 0;
    if (type == 'sr legacy') return 1;
    if (type == 'survey (fndds)' || type == 'survey') return 2;
    if (type == 'branded') return 3;
    return 4;
  }

  String _normalize(String value) {
    var normalized = value
        .replaceAll('\u0131', 'i')
        .replaceAll('\u0130', 'i')
        .replaceAll('\u011f', 'g')
        .replaceAll('\u011e', 'g')
        .replaceAll('\u015f', 's')
        .replaceAll('\u015e', 's')
        .replaceAll('\u00fc', 'u')
        .replaceAll('\u00dc', 'u')
        .replaceAll('\u00f6', 'o')
        .replaceAll('\u00d6', 'o')
        .replaceAll('\u00e7', 'c')
        .replaceAll('\u00c7', 'c');
    normalized = normalized.toLowerCase();
    normalized = normalized.replaceAll(RegExp('[^a-z0-9 ]'), ' ');
    normalized = normalized.replaceAll(RegExp(r'\s+'), ' ').trim();
    return normalized;
  }
}
