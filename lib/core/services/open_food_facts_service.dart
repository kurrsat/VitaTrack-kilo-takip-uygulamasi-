import 'package:dio/dio.dart';
import 'package:weightvault/core/config/env.dart';
class OpenFoodFactsService {
  OpenFoodFactsService({Dio? dio}) : _dio = dio ?? Dio();

  final Dio _dio;

  Future<Map<String, dynamic>?> searchFirstByName(String query) async {
    final trimmed = query.trim();
    if (trimmed.isEmpty) return null;
    final base = _rootBase(Env.openFoodFactsBaseUrl ?? 'https://world.openfoodfacts.org');
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '$base/cgi/search.pl',
        queryParameters: {
          'search_terms': trimmed,
          'search_simple': 1,
          'action': 'process',
          'json': 1,
          'page_size': 20,
          'fields': 'product_name,product_name_tr,generic_name,brands,code,nutriments,data_quality_tags',
        },
      );
      if (response.statusCode == 200) {
        final data = response.data;
        final products = (data?['products'] as List?)?.cast<Map<String, dynamic>>() ?? const [];
        return _pickBestProduct(products, trimmed);
      }
      return null;
    } on DioException {
      return null;
    }
  }

  Future<Map<String, dynamic>?> lookupBarcode(String barcode) async {
    final base = _apiBase(Env.openFoodFactsBaseUrl ?? 'https://world.openfoodfacts.org');
    try {
      final response = await _dio.get<Map<String, dynamic>>('$base/product/$barcode.json');
      if (response.statusCode == 200) {
        final data = response.data;
        if (data != null && data['status'] == 1) {
          return data['product'] as Map<String, dynamic>;
        }
      }
      return null;
    } on DioException {
      return null;
    }
  }

  String _normalizeBase(String base) {
    if (base.endsWith('/')) {
      return base.substring(0, base.length - 1);
    }
    return base;
  }

  String _rootBase(String base) {
    final normalized = _normalizeBase(base);
    if (normalized.endsWith('/api/v2')) {
      return normalized.substring(0, normalized.length - '/api/v2'.length);
    }
    return normalized;
  }

  String _apiBase(String base) {
    final normalized = _normalizeBase(base);
    if (normalized.endsWith('/api/v2')) {
      return normalized;
    }
    return '$normalized/api/v2';
  }

  bool _hasCalories(Map<String, dynamic> product) {
    final kcal = _extractKcal(product);
    return kcal != null && kcal > 0;
  }

  double? _toDouble(dynamic value) {
    if (value == null) return null;
    if (value is num) return value.toDouble();
    return double.tryParse(value.toString());
  }

  Map<String, dynamic>? _pickBestProduct(List<Map<String, dynamic>> products, String query) {
    if (products.isEmpty) return null;
    final normalizedQuery = _normalize(query);
    final matched = <Map<String, dynamic>>[];
    for (final product in products) {
      final name = _pickName(product);
      if (name.isEmpty) continue;
      final normalizedName = _normalize(name);
      if (normalizedName.contains(normalizedQuery)) {
        matched.add(product);
      }
    }
    if (matched.isEmpty) return null;
    matched.sort((a, b) {
      final scoreA = _scoreProduct(a, normalizedQuery);
      final scoreB = _scoreProduct(b, normalizedQuery);
      if (scoreA != scoreB) return scoreB.compareTo(scoreA);
      final aName = _pickName(a);
      final bName = _pickName(b);
      return aName.length.compareTo(bName.length);
    });
    return matched.first;
  }

  String _pickName(Map<String, dynamic> product) {
    final nameTr = product['product_name_tr']?.toString().trim() ?? '';
    if (nameTr.isNotEmpty) return nameTr;
    final name = product['product_name']?.toString().trim() ?? '';
    if (name.isNotEmpty) return name;
    return product['generic_name']?.toString().trim() ?? '';
  }

  double? _extractKcal(Map<String, dynamic> product) {
    final nutriments = product['nutriments'] as Map<String, dynamic>? ?? {};
    final kcal = _toDouble(nutriments['energy-kcal_100g'] ?? nutriments['energy-kcal']);
    if (kcal != null && kcal > 0) return kcal;
    final kj = _toDouble(
      nutriments['energy-kj_100g'] ?? nutriments['energy-kj'] ?? nutriments['energy_100g'],
    );
    if (kj != null && kj > 0) {
      return kj / 4.184;
    }
    return null;
  }

  int _scoreProduct(Map<String, dynamic> product, String normalizedQuery) {
    final name = _pickName(product);
    if (name.isEmpty) return 0;
    final normalizedName = _normalize(name);
    var score = 0;
    if (normalizedName == normalizedQuery) {
      score += 100;
    } else if (normalizedName.startsWith(normalizedQuery)) {
      score += 80;
    } else if (normalizedName.contains(normalizedQuery)) {
      score += 60;
    }
    if (_hasCalories(product)) {
      score += 20;
    }
    if ((product['product_name_tr']?.toString().trim() ?? '').isNotEmpty) {
      score += 10;
    }
    return score;
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
