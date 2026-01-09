import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:weightvault/core/ui/widgets.dart';
import 'package:weightvault/data/repositories/repository_providers.dart';
import 'package:weightvault/domain/models/models.dart';
import 'package:weightvault/features/activity/activity_providers.dart';
import 'package:weightvault/features/log/log_models.dart';
import 'package:weightvault/features/log/record_detail_page.dart';
import 'package:weightvault/features/photos/photo_providers.dart';
import 'package:weightvault/features/reports/reports_providers.dart';
import 'package:weightvault/features/water/water_providers.dart';
import 'package:weightvault/features/weight/weight_providers.dart';
import 'package:weightvault/l10n/app_localizations.dart';

class LogPage extends ConsumerStatefulWidget {
  const LogPage({super.key});

  @override
  ConsumerState<LogPage> createState() => _LogPageState();
}

class _LogPageState extends ConsumerState<LogPage> {
  RecordFilter _filter = RecordFilter.all;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    final weightsAsync = ref.watch(weightEntriesProvider);
    final waterAsync = ref.watch(waterHistoryProvider);
    final foodAsync = ref.watch(allFoodEntriesProvider);
    final activityAsync = ref.watch(activityEntriesProvider);
    final photoAsync = ref.watch(photoEntriesProvider);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(strings.log),
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFE0F7FA), // Light blue
              Color(0xFFFFF3E0), // Light peach
            ],
          ),
        ),
        child: SafeArea(
          child: _buildBody(
            context: context,
            strings: strings,
            weightsAsync: weightsAsync,
            waterAsync: waterAsync,
            foodAsync: foodAsync,
            activityAsync: activityAsync,
            photoAsync: photoAsync,
          ),
        ),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          gradient: const LinearGradient(
            colors: [Color(0xFF6EE7B7), Color(0xFF10B981)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF10B981).withOpacity(0.5),
              blurRadius: 15,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: FloatingActionButton(
          onPressed: () {
            // TODO: Navigate to add entry screen
          },
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: const Icon(Icons.add, size: 32, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildBody({
    required BuildContext context,
    required AppLocalizations strings,
    required AsyncValue<List<WeightEntry>> weightsAsync,
    required AsyncValue<List<WaterEntry>> waterAsync,
    required AsyncValue<List<FoodEntry>> foodAsync,
    required AsyncValue<List<ActivityEntry>> activityAsync,
    required AsyncValue<List<PhotoEntry>> photoAsync,
  }) {
    if (weightsAsync.isLoading ||
        waterAsync.isLoading ||
        foodAsync.isLoading ||
        activityAsync.isLoading ||
        photoAsync.isLoading) {
      return const LoadingView();
    }
    final error = weightsAsync.error ??
        waterAsync.error ??
        foodAsync.error ??
        activityAsync.error ??
        photoAsync.error;
    if (error != null) {
      return ErrorState(title: strings.errorSomethingWentWrong, message: error.toString());
    }
    final records = _buildRecords(
      weights: weightsAsync.value ?? const [],
      waters: waterAsync.value ?? const [],
      foods: foodAsync.value ?? const [],
      activities: activityAsync.value ?? const [],
      photos: photoAsync.value ?? const [],
    );
    final filtered = _applyFilter(records, _filter);
    if (filtered.isEmpty) {
      return EmptyState(
        title: strings.emptyLogTitle,
        message: strings.emptyLogMessage,
      );
    }
    final grouped = _groupByDay(filtered);
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        FilterChips(
          selected: _filter,
          onSelected: (value) => setState(() => _filter = value),
        ),
        const SizedBox(height: 12),
        ...grouped.entries.expand(
          (entry) => [
            RecordDaySectionHeader(label: entry.key),
            const SizedBox(height: 8),
            ...entry.value.map((record) => _buildDismissible(context, strings, record)),
            const SizedBox(height: 12),
          ],
        ),
      ],
    );
  }

  Widget _buildDismissible(
    BuildContext context,
    AppLocalizations strings,
    LogRecord record,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Dismissible(
        key: ValueKey('${record.type.name}_${record.id}'),
        confirmDismiss: (direction) async {
          if (direction == DismissDirection.startToEnd) {
            _openDetails(context, record);
            return false;
          }
          final confirmed = await showDialog<bool>(
            context: context,
            builder: (dialogContext) => AlertDialog(
              title: Text(strings.deleteConfirmTitle),
              content: Text(strings.deleteConfirmMessage),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(false),
                  child: Text(strings.cancel),
                ),
                FilledButton(
                  onPressed: () => Navigator.of(dialogContext).pop(true),
                  child: Text(strings.deleteLabel),
                ),
              ],
            ),
          );
          if (confirmed ?? false) {
            await _deleteRecord(record);
            return true;
          }
          return false;
        },
        background: _SwipeActionBackground(
          color: Theme.of(context).colorScheme.primaryContainer,
          icon: Icons.edit,
          label: strings.editLabel,
          alignment: Alignment.centerLeft,
        ),
        secondaryBackground: _SwipeActionBackground(
          color: Theme.of(context).colorScheme.errorContainer,
          icon: Icons.delete,
          label: strings.deleteLabel,
          alignment: Alignment.centerRight,
        ),
        child: RecordListItem(
          record: record,
          onTap: () => _openDetails(context, record),
        ),
      ),
    );
  }

  void _openDetails(BuildContext context, LogRecord record) {
    if (record.type == RecordType.food) {
      _showFoodDetails(context, record);
    } else if (record.type == RecordType.water) {
      _showWaterDetails(context, record);
    } else {
      Navigator.of(context).push<void>(
        MaterialPageRoute<void>(
          builder: (_) => RecordDetailPage(record: record),
        ),
      );
    }
  }

  void _showFoodDetails(BuildContext context, LogRecord record) {
    final entry = record.entry as FoodEntry;
    final strings = AppLocalizations.of(context)!;
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            const Icon(Icons.restaurant, color: Colors.orange),
            const SizedBox(width: 8),
            Text(_mealLabel(strings, entry.mealType)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${entry.totals.cal.toStringAsFixed(0)} kcal',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
            const SizedBox(height: 16),
            if (entry.items.isNotEmpty)
              ...entry.items.map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        '${item.name} (${item.grams.toStringAsFixed(0)}g)',
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                    Text('${item.cal.toStringAsFixed(0)} kcal'),
                  ],
                ),
              ),)
            else
               const Text('Hiç ürün yok'),
            
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _macroColumn('Prot', entry.totals.protein, Colors.purple),
                _macroColumn('Carb', entry.totals.carb, Colors.blue),
                _macroColumn('Fat', entry.totals.fat, Colors.amber),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Kapat'),
          ),
        ],
      ),
    );
  }

  void _showWaterDetails(BuildContext context, LogRecord record) {
    final entry = record.entry as WaterEntry;
    final strings = AppLocalizations.of(context)!;
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            const Icon(Icons.water_drop, color: Colors.blue),
            const SizedBox(width: 8),
            Text(strings.waterTitle),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${entry.ml} ml',
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              DateFormat('HH:mm').format(entry.date.toLocal()),
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Kapat'),
          ),
        ],
      ),
    );
  }

  Widget _macroColumn(String label, double val, Color color) {
    return Column(
      children: [
        Text(
          val.toStringAsFixed(1),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: color,
            fontSize: 16,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: color.withOpacity(0.8),
            fontSize: 12,
          ),
        ),
      ],
    );
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

  Future<void> _deleteRecord(LogRecord record) async {
    final uid = record.uid;
    switch (record.type) {
      case RecordType.weight:
        await ref.read(weightRepositoryProvider).softDelete(uid, record.id);
      case RecordType.water:
        await ref.read(waterRepositoryProvider).softDelete(uid, record.id);
      case RecordType.food:
        await ref.read(foodRepositoryProvider).softDelete(uid, record.id);
      case RecordType.activity:
        await ref.read(activityRepositoryProvider).softDelete(uid, record.id);
      case RecordType.photo:
        await ref.read(photoRepositoryProvider).softDelete(uid, record.id);
    }
  }

  List<LogRecord> _buildRecords({
    required List<WeightEntry> weights,
    required List<WaterEntry> waters,
    required List<FoodEntry> foods,
    required List<ActivityEntry> activities,
    required List<PhotoEntry> photos,
  }) {
    final records = <LogRecord>[];
    for (final entry in weights) {
      if (entry.isDeleted) continue;
      records.add(
        LogRecord(
          id: entry.id,
          uid: entry.uid,
          type: RecordType.weight,
          dateTime: entry.dateTime.toLocal(),
          entry: entry,
        ),
      );
    }
    for (final entry in waters) {
      if (entry.isDeleted) continue;
      records.add(
        LogRecord(
          id: entry.id,
          uid: entry.uid,
          type: RecordType.water,
          dateTime: entry.lastUpdatedAt.toLocal(),
          entry: entry,
        ),
      );
    }
    for (final entry in foods) {
      if (entry.isDeleted) continue;
      records.add(
        LogRecord(
          id: entry.id,
          uid: entry.uid,
          type: RecordType.food,
          dateTime: entry.dateTime.toLocal(),
          entry: entry,
        ),
      );
    }
    for (final entry in activities) {
      if (entry.isDeleted) continue;
      records.add(
        LogRecord(
          id: entry.id,
          uid: entry.uid,
          type: RecordType.activity,
          dateTime: entry.dateTime.toLocal(),
          entry: entry,
        ),
      );
    }
    for (final entry in photos) {
      if (entry.isDeleted) continue;
      records.add(
        LogRecord(
          id: entry.id,
          uid: entry.uid,
          type: RecordType.photo,
          dateTime: entry.date.toLocal(),
          entry: entry,
        ),
      );
    }
    records.sort((a, b) => b.dateTime.compareTo(a.dateTime));
    return records;
  }

  List<LogRecord> _applyFilter(List<LogRecord> records, RecordFilter filter) {
    final type = filter.toRecordType();
    if (type == null) {
      return records;
    }
    return records.where((record) => record.type == type).toList();
  }

  Map<String, List<LogRecord>> _groupByDay(List<LogRecord> records) {
    final strings = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).toString();
    final dateFormat = DateFormat('dd MMM yyyy', locale);
    final now = DateTime.now();
    final grouped = <String, List<LogRecord>>{};
    for (final record in records) {
      final day = DateTime(record.dateTime.year, record.dateTime.month, record.dateTime.day);
      final label = _dayLabel(strings, dateFormat, now, day);
      grouped.putIfAbsent(label, () => []).add(record);
    }
    return grouped;
  }

  String _dayLabel(
    AppLocalizations strings,
    DateFormat dateFormat,
    DateTime now,
    DateTime day,
  ) {
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    if (_isSameDay(day, today)) {
      return strings.todayLabel;
    }
    if (_isSameDay(day, yesterday)) {
      return strings.yesterdayLabel;
    }
    return dateFormat.format(day);
  }

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;
}

class FilterChips extends StatelessWidget {
  const FilterChips({
    required this.selected,
    required this.onSelected,
    super.key,
  });

  final RecordFilter selected;
  final ValueChanged<RecordFilter> onSelected;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildChip(strings.logFilterAll, RecordFilter.all, const LinearGradient(colors: [Color(0xFF9575CD), Color(0xFF7E57C2)])),
          _buildChip(strings.logFilterWeight, RecordFilter.weight, const LinearGradient(colors: [Color(0xFF3B82F6), Color(0xFF60A5FA)])),
          _buildChip(strings.logFilterWater, RecordFilter.water, const LinearGradient(colors: [Color(0xFF00D4FF), Color(0xFF00BFAE)])),
          _buildChip(strings.logFilterFood, RecordFilter.food, const LinearGradient(colors: [Color(0xFFFF6B35), Color(0xFFFFB347)])),
          _buildChip(strings.logFilterActivity, RecordFilter.activity, const LinearGradient(colors: [Color(0xFFFF006E), Color(0xFFE91E63)])),
          _buildChip(strings.logFilterPhoto, RecordFilter.photo, const LinearGradient(colors: [Color(0xFFFF006E), Color(0xFF8338EC)])),
        ],
      ),
    );
  }

  Widget _buildChip(String label, RecordFilter value, Gradient gradient) {
    final isSelected = selected == value;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: GestureDetector(
        onTap: () => onSelected(value),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            gradient: isSelected ? gradient : null,
            color: isSelected ? null : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(24),
            boxShadow: isSelected
                ? [BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 8, offset: const Offset(0, 4))]
                : null,
          ),
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black87,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}

class RecordDaySectionHeader extends StatelessWidget {
  const RecordDaySectionHeader({required this.label, super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(label, style: Theme.of(context).textTheme.titleMedium);
  }
}

class RecordListItem extends StatelessWidget {
  const RecordListItem({
    required this.record,
    required this.onTap,
    super.key,
  });

  final LogRecord record;
  final VoidCallback onTap;


  Gradient _gradientForType(RecordType type) {
    switch (type) {
      case RecordType.weight:
        return const LinearGradient(
          colors: [Color(0xFF3B82F6), Color(0xFF2563EB)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case RecordType.water:
        return const LinearGradient(
          colors: [Color(0xFF00c6ff), Color(0xFF0072ff)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case RecordType.food:
        return const LinearGradient(
          colors: [Color(0xFFff512f), Color(0xFFf09819)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case RecordType.activity:
        return const LinearGradient(
          colors: [Color(0xFFEF4444), Color(0xFFDC2626)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case RecordType.photo:
        return const LinearGradient(
          colors: [Color(0xFFec008c), Color(0xFFfc6767)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    final timeLabel = _formatTime(context, strings, record.dateTime);
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: _gradientForType(record.type),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Icon Container
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                _iconForType(record.type),
                color: Colors.white,
                size: 28,
              ),
            ),
            const SizedBox(width: 16),
            // Text Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _typeLabel(strings, record.type),
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _titleForRecord(strings, record),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    timeLabel,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
            // Chevron Right
            const Icon(
              Icons.chevron_right,
              color: Colors.white60,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }

  String _typeLabel(AppLocalizations strings, RecordType type) {
    switch (type) {
      case RecordType.weight:
        return 'Kilo';
      case RecordType.water:
        return 'Su';
      case RecordType.food:
        return 'Yemek';
      case RecordType.activity:
        return 'Aktiv';
      case RecordType.photo:
        return strings.progressPhotosTitle;
    }
  }

  String _titleForRecord(AppLocalizations strings, LogRecord record) {
    switch (record.type) {
      case RecordType.weight:
        final entry = record.entry as WeightEntry;
        return '${entry.weightKg.toStringAsFixed(1)} kg';
      case RecordType.water:
        final entry = record.entry as WaterEntry;
        return 'Su - ${entry.ml} ml';
      case RecordType.food:
        final entry = record.entry as FoodEntry;
        final mealLabel = _mealLabel(strings, entry.mealType);
        final calLabel = '${entry.totals.cal.toStringAsFixed(0)} kcal';
        // If single item, show its name
        if (entry.items.length == 1) {
             return '${entry.items.first.name} • $calLabel';
        }
        return '$mealLabel • $calLabel';
      case RecordType.activity:
        final entry = record.entry as ActivityEntry;
        return '${entry.type} • ${entry.calories.toStringAsFixed(0)} kcal';
      case RecordType.photo:
        final entry = record.entry as PhotoEntry;
        return '${strings.progressPhotosTitle} • ${_photoLabel(strings, entry.type)}';
    }
  }

  IconData _iconForType(RecordType type) {
    switch (type) {
      case RecordType.weight:
        return Icons.monitor_weight;
      case RecordType.water:
        return Icons.water_drop;
      case RecordType.food:
        return Icons.restaurant;
      case RecordType.activity:
        return Icons.fitness_center;
      case RecordType.photo:
        return Icons.photo_camera_back;
    }
  }

  String _formatTime(
    BuildContext context,
    AppLocalizations strings,
    DateTime dateTime,
  ) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final day = DateTime(dateTime.year, dateTime.month, dateTime.day);
    final time = DateFormat('HH:mm', Localizations.localeOf(context).toString()).format(dateTime);
    if (_isSameDay(day, today)) {
      return '${strings.todayLabel} $time';
    }
    if (_isSameDay(day, yesterday)) {
      return '${strings.yesterdayLabel} $time';
    }
    final date = DateFormat('dd MMM yyyy', Localizations.localeOf(context).toString())
        .format(dateTime);
    return '$date $time';
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

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;
}

class _SwipeActionBackground extends StatelessWidget {
  const _SwipeActionBackground({
    required this.color,
    required this.icon,
    required this.label,
    required this.alignment,
  });

  final Color color;
  final IconData icon;
  final String label;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      alignment: alignment,
      child: Row(
        mainAxisAlignment: alignment == Alignment.centerLeft
            ? MainAxisAlignment.start
            : MainAxisAlignment.end,
        children: [
          Icon(icon),
          const SizedBox(width: 8),
          Text(label),
        ],
      ),
    );
  }
}
