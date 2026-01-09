import 'dart:convert';

import 'package:cross_file/cross_file.dart';
import 'package:csv/csv.dart';
import 'package:weightvault/domain/models/models.dart';

class ExportImportService {
  Future<ImportBundle> importBundle({
    required String uid,
    required Map<String, dynamic> json,
  }) async {
    final profileJson = json['profile'] as Map<String, dynamic>?;
    UserProfile? profile;
    if (profileJson != null) {
      final normalized = Map<String, dynamic>.from(profileJson);
      normalized.putIfAbsent(
        'lastUpdatedAt',
        () => normalized['createdAt'] ?? DateTime.now().toUtc().millisecondsSinceEpoch,
      );
      profile = UserProfile.fromJson(normalized).copyWith(uid: uid);
    }

    final weights = _parseList(json['weight_entries'], WeightEntry.fromJson)
        .map((entry) => entry.copyWith(uid: uid))
        .toList();
    final measurements = _parseList(json['measurement_entries'], MeasurementEntry.fromJson)
        .map((entry) => entry.copyWith(uid: uid))
        .toList();
    final waters = _parseList(json['water_entries'], WaterEntry.fromJson)
        .map((entry) => entry.copyWith(uid: uid))
        .toList();
    final foods = _parseList(json['food_entries'], FoodEntry.fromJson)
        .map((entry) => entry.copyWith(uid: uid))
        .toList();
    final customFoods = _parseList(json['custom_foods'], CustomFood.fromJson)
        .map((entry) => entry.copyWith(uid: uid))
        .toList();
    final fastings = _parseList(json['fasting_sessions'], FastingSession.fromJson)
        .map((entry) => entry.copyWith(uid: uid))
        .toList();
    final activities = _parseList(json['activity_entries'], ActivityEntry.fromJson)
        .map((entry) => entry.copyWith(uid: uid))
        .toList();
    final photos = _parseList(json['photo_entries'], PhotoEntry.fromJson)
        .map((entry) => entry.copyWith(uid: uid))
        .toList();

    return ImportBundle(
      profile: profile,
      weights: weights,
      measurements: measurements,
      waters: waters,
      foods: foods,
      customFoods: customFoods,
      fastings: fastings,
      activities: activities,
      photos: photos,
    );
  }

  Future<XFile> exportWeightsCsv({required List<WeightEntry> entries}) async {
    final rows = <List<dynamic>>[
      ['date', 'time', 'weight_kg', 'note', 'condition', 'mood'],
      ...entries.map(
        (entry) => [
          entry.dateTime.toIso8601String().split('T').first,
          entry.dateTime.toIso8601String().split('T').last.split('.').first,
          entry.weightKg,
          entry.note ?? '',
          entry.conditionTag?.name ?? '',
          entry.moodTag?.name ?? '',
        ],
      ),
    ];
    final csv = const ListToCsvConverter().convert(rows);
    return XFile.fromData(
      utf8.encode(csv),
      mimeType: 'text/csv',
      name: 'weight_entries.csv',
    );
  }

  Future<XFile> exportJson(Map<String, dynamic> data) async {
    final json = const JsonEncoder.withIndent('  ').convert(data);
    return XFile.fromData(
      utf8.encode(json),
      mimeType: 'application/json',
      name: 'weightvault_export.json',
    );
  }

  Future<List<WeightEntry>> importWeightJson({
    required String uid,
    required Map<String, dynamic> json,
  }) async {
    final list = (json['weight_entries'] as List<dynamic>? ?? []).cast<Map<String, dynamic>>();
    return list.map(WeightEntry.fromJson).map((entry) => entry.copyWith(uid: uid)).toList();
  }

  Future<List<WeightEntry>> importWeightCsv({
    required String uid,
    required String content,
    required String dateColumn,
    required String weightColumn,
  }) async {
    final rows = const CsvToListConverter().convert(content, eol: '\n');
    if (rows.isEmpty) {
      return [];
    }
    final header = rows.first.map((e) => e.toString()).toList();
    final dateIndex = header.indexOf(dateColumn);
    final weightIndex = header.indexOf(weightColumn);
    if (dateIndex == -1 || weightIndex == -1) {
      throw StateError('Invalid column mapping');
    }
    final entries = <WeightEntry>[];
    for (var i = 1; i < rows.length; i++) {
      final row = rows[i];
      if (row.length <= weightIndex || row.length <= dateIndex) {
        continue;
      }
      final dateValue = row[dateIndex].toString();
      final weightValue = row[weightIndex].toString();
      final date = _parseDate(dateValue);
      final weight = double.tryParse(weightValue.replaceAll(',', '.'));
      if (date == null || weight == null) {
        continue;
      }
      entries.add(
        WeightEntry(
          id: '${uid}_${date.toIso8601String()}_$i',
          uid: uid,
          dateTime: date.toUtc(),
          weightKg: weight,
          lastUpdatedAt: DateTime.now().toUtc(),
        ),
      );
    }
    return entries;
  }

  DateTime? _parseDate(String value) {
    final formats = [
      RegExp(r'^\d{4}-\d{2}-\d{2}$'),
      RegExp(r'^\d{2}\.\d{2}\.\d{4}$'),
    ];
    if (formats[0].hasMatch(value)) {
      return DateTime.tryParse(value);
    }
    if (formats[1].hasMatch(value)) {
      final parts = value.split('.');
      return DateTime(
        int.parse(parts[2]),
        int.parse(parts[1]),
        int.parse(parts[0]),
      );
    }
    return DateTime.tryParse(value);
  }

  List<T> _parseList<T>(
    Object? source,
    T Function(Map<String, dynamic>) fromJson,
  ) {
    final list = (source as List<dynamic>? ?? []).cast<Map<String, dynamic>>();
    return list.map((raw) {
      final normalized = Map<String, dynamic>.from(raw)
        ..putIfAbsent(
          'lastUpdatedAt',
          () => DateTime.now().toUtc().millisecondsSinceEpoch,
        );
      return fromJson(normalized);
    }).toList();
  }
}

class ImportBundle {
  const ImportBundle({
    required this.profile,
    required this.weights,
    required this.measurements,
    required this.waters,
    required this.foods,
    required this.customFoods,
    required this.fastings,
    required this.activities,
    required this.photos,
  });

  final UserProfile? profile;
  final List<WeightEntry> weights;
  final List<MeasurementEntry> measurements;
  final List<WaterEntry> waters;
  final List<FoodEntry> foods;
  final List<CustomFood> customFoods;
  final List<FastingSession> fastings;
  final List<ActivityEntry> activities;
  final List<PhotoEntry> photos;
}
