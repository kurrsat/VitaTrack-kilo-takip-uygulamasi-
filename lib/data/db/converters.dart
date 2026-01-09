import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:weightvault/domain/models/models.dart';
class FoodItemsConverter extends TypeConverter<List<FoodItem>, String> {
  const FoodItemsConverter();

  @override
  List<FoodItem> fromSql(String fromDb) {
    final decoded = jsonDecode(fromDb) as List<dynamic>;
    return decoded.map((e) => FoodItem.fromJson(e as Map<String, dynamic>)).toList();
  }

  @override
  String toSql(List<FoodItem> value) {
    return jsonEncode(value.map((e) => e.toJson()).toList());
  }
}

class FoodTotalsConverter extends TypeConverter<FoodTotals, String> {
  const FoodTotalsConverter();

  @override
  FoodTotals fromSql(String fromDb) {
    return FoodTotals.fromJson(jsonDecode(fromDb) as Map<String, dynamic>);
  }

  @override
  String toSql(FoodTotals value) {
    return jsonEncode(value.toJson());
  }
}
