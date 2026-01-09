import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:weightvault/core/ui/widgets.dart';
import 'package:weightvault/data/repositories/repository_providers.dart';
import 'package:weightvault/domain/models/models.dart';
import 'package:weightvault/features/log/log_models.dart';
import 'package:weightvault/l10n/app_localizations.dart';

class RecordDetailPage extends ConsumerStatefulWidget {
  const RecordDetailPage({required this.record, super.key});

  final LogRecord record;

  @override
  ConsumerState<RecordDetailPage> createState() => _RecordDetailPageState();
}

class _RecordDetailPageState extends ConsumerState<RecordDetailPage> {
  final _primaryController = TextEditingController();
  final _secondaryController = TextEditingController();
  final _proteinController = TextEditingController();
  final _carbController = TextEditingController();
  final _fatController = TextEditingController();
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final record = widget.record;
    switch (record.type) {
      case RecordType.weight:
        final entry = record.entry as WeightEntry;
        _primaryController.text = entry.weightKg.toStringAsFixed(1);
        return;
      case RecordType.water:
        final entry = record.entry as WaterEntry;
        _primaryController.text = entry.ml.toString();
        return;
      case RecordType.activity:
        final entry = record.entry as ActivityEntry;
        _primaryController.text = entry.durationMin.toString();
        _secondaryController.text = entry.calories.toStringAsFixed(0);
        return;
      case RecordType.food:
        final entry = record.entry as FoodEntry;
        _primaryController.text = entry.totals.cal.toStringAsFixed(0);
        _proteinController.text = entry.totals.protein.toStringAsFixed(1);
        _carbController.text = entry.totals.carb.toStringAsFixed(1);
        _fatController.text = entry.totals.fat.toStringAsFixed(1);
        return;
      case RecordType.photo:
        return;
    }
  }

  @override
  void dispose() {
    _primaryController.dispose();
    _secondaryController.dispose();
    _proteinController.dispose();
    _carbController.dispose();
    _fatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    final record = widget.record;
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: Text(strings.recordDetailsTitle),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_recordTitle(strings, record), style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 8),
                Text(_dateLabel(context, record.dateTime)),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _buildEditor(strings, record),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: FilledButton(
                  onPressed: _saving ? null : () => _save(strings, record),
                  child: Text(strings.save),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton(
                  onPressed: _saving ? null : () => _delete(strings, record),
                  child: Text(strings.deleteLabel),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEditor(AppLocalizations strings, LogRecord record) {
    switch (record.type) {
      case RecordType.weight:
        return AppCard(
          child: TextField(
            controller: _primaryController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: strings.weightLabel),
          ),
        );
      case RecordType.water:
        return AppCard(
          child: TextField(
            controller: _primaryController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: strings.waterAmountLabel),
          ),
        );
      case RecordType.activity:
        return AppCard(
          child: Column(
            children: [
              TextField(
                controller: _primaryController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: strings.activityDurationLabel),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _secondaryController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: strings.caloriesLabel),
              ),
            ],
          ),
        );
      case RecordType.food:
        return AppCard(
          child: Column(
            children: [
              TextField(
                controller: _primaryController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: strings.caloriesLabel),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _proteinController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: strings.proteinLabel),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _carbController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: strings.carbLabel),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _fatController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: strings.fatLabel),
              ),
            ],
          ),
        );
      case RecordType.photo:
        return AppCard(
          child: Text(strings.photoDetailMessage),
        );
    }
  }

  Future<void> _save(AppLocalizations strings, LogRecord record) async {
    setState(() => _saving = true);
    try {
      switch (record.type) {
        case RecordType.weight:
          final entry = record.entry as WeightEntry;
          final value = double.tryParse(_primaryController.text.replaceAll(',', '.'));
          if (value != null) {
            await ref.read(weightRepositoryProvider).upsert(
                  entry.copyWith(weightKg: value, lastUpdatedAt: DateTime.now().toUtc()),
                );
          }
        case RecordType.water:
          final entry = record.entry as WaterEntry;
          final value = int.tryParse(_primaryController.text);
          if (value != null) {
            await ref.read(waterRepositoryProvider).upsert(
                  entry.copyWith(ml: value, lastUpdatedAt: DateTime.now().toUtc()),
                );
          }
        case RecordType.activity:
          final entry = record.entry as ActivityEntry;
          final minutes = int.tryParse(_primaryController.text) ?? entry.durationMin;
          final calories =
              double.tryParse(_secondaryController.text.replaceAll(',', '.')) ??
                  entry.calories;
          await ref.read(activityRepositoryProvider).upsert(
                entry.copyWith(
                  durationMin: minutes,
                  calories: calories,
                  lastUpdatedAt: DateTime.now().toUtc(),
                ),
              );
        case RecordType.food:
          final entry = record.entry as FoodEntry;
          final calories =
              double.tryParse(_primaryController.text.replaceAll(',', '.')) ??
                  entry.totals.cal;
          final protein =
              double.tryParse(_proteinController.text.replaceAll(',', '.')) ??
                  entry.totals.protein;
          final carb =
              double.tryParse(_carbController.text.replaceAll(',', '.')) ??
                  entry.totals.carb;
          final fat =
              double.tryParse(_fatController.text.replaceAll(',', '.')) ??
                  entry.totals.fat;
          await ref.read(foodRepositoryProvider).upsert(
                entry.copyWith(
                  totals: FoodTotals(
                    cal: calories,
                    protein: protein,
                    carb: carb,
                    fat: fat,
                    fiber: entry.totals.fiber,
                    sodium: entry.totals.sodium,
                    sugar: entry.totals.sugar,
                  ),
                  lastUpdatedAt: DateTime.now().toUtc(),
                ),
              );
        case RecordType.photo:
          break;
      }
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(strings.recordSavedMessage)),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _saving = false);
      }
    }
  }

  Future<void> _delete(AppLocalizations strings, LogRecord record) async {
    switch (record.type) {
      case RecordType.weight:
        await ref.read(weightRepositoryProvider).softDelete(record.uid, record.id);
      case RecordType.water:
        await ref.read(waterRepositoryProvider).softDelete(record.uid, record.id);
      case RecordType.food:
        await ref.read(foodRepositoryProvider).softDelete(record.uid, record.id);
      case RecordType.activity:
        await ref.read(activityRepositoryProvider).softDelete(record.uid, record.id);
      case RecordType.photo:
        await ref.read(photoRepositoryProvider).softDelete(record.uid, record.id);
    }
    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  String _recordTitle(AppLocalizations strings, LogRecord record) {
    switch (record.type) {
      case RecordType.weight:
        final entry = record.entry as WeightEntry;
        return '${entry.weightKg.toStringAsFixed(1)} kg';
      case RecordType.water:
        final entry = record.entry as WaterEntry;
        return '${entry.ml} ml';
      case RecordType.food:
        final entry = record.entry as FoodEntry;
        return '${_mealLabel(strings, entry.mealType)} • ${entry.totals.cal.toStringAsFixed(0)} kcal';
      case RecordType.activity:
        final entry = record.entry as ActivityEntry;
        return '${entry.type} • ${entry.calories.toStringAsFixed(0)} kcal';
      case RecordType.photo:
        final entry = record.entry as PhotoEntry;
        return '${strings.progressPhotosTitle} • ${_photoLabel(strings, entry.type)}';
    }
  }

  String _dateLabel(BuildContext context, DateTime dateTime) {
    final locale = Localizations.localeOf(context).toString();
    return DateFormat('dd MMM yyyy HH:mm', locale).format(dateTime);
  }

  String _mealLabel(AppLocalizations strings, MealType meal) {
    switch (meal) {
      case MealType.breakfast:
        return strings.mealBreakfast;
      case MealType.lunch:
        return strings.mealLunch;
      case MealType.dinner:
        return strings.mealDinner;
      case MealType.snack:
        return strings.mealSnack;
    }
  }

  String _photoLabel(AppLocalizations strings, PhotoType type) {
    switch (type) {
      case PhotoType.front:
        return strings.photoTypeFront;
      case PhotoType.side:
        return strings.photoTypeSide;
      case PhotoType.back:
        return strings.photoTypeBack;
    }
  }
}
