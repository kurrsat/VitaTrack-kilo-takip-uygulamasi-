import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
import 'package:weightvault/core/providers/app_init_provider.dart';
import 'package:weightvault/core/providers/providers.dart';
import 'package:weightvault/core/ui/widgets.dart';
import 'package:weightvault/data/repositories/repository_providers.dart';
import 'package:weightvault/features/data_export_import/import_csv_wizard_page.dart';
import 'package:weightvault/l10n/app_localizations.dart';
class DataExportImportPage extends ConsumerStatefulWidget {
  const DataExportImportPage({super.key});

  @override
  ConsumerState<DataExportImportPage> createState() => _DataExportImportPageState();
}

class _DataExportImportPageState extends ConsumerState<DataExportImportPage> {
  bool _busy = false;

  Future<void> _exportJson() async {
    final uid = ref.read(currentUserIdProvider);
    if (uid == null) return;
    setState(() => _busy = true);
    try {
      final strings = AppLocalizations.of(context)!;
      final data = await _buildExportData(uid);
      final file = await ref.read(exportImportServiceProvider).exportJson(data);
      await ref.read(crashlyticsProvider).log('export_json');
      await Share.shareXFiles([file], text: strings.exportJsonShare);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _exportCsv() async {
    final uid = ref.read(currentUserIdProvider);
    if (uid == null) return;
    setState(() => _busy = true);
    try {
      final strings = AppLocalizations.of(context)!;
      final weights = await ref.read(weightRepositoryProvider).watchEntries(uid).first;
      final file = await ref.read(exportImportServiceProvider).exportWeightsCsv(entries: weights);
      await ref.read(crashlyticsProvider).log('export_csv');
      await Share.shareXFiles([file], text: strings.exportCsvShare);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<Map<String, dynamic>> _buildExportData(String uid) async {
    final weights = await ref.read(weightRepositoryProvider).watchEntries(uid).first;
    final measurements = await ref.read(measurementRepositoryProvider).watchEntries(uid).first;
    final waters = await ref.read(waterRepositoryProvider).watchAll(uid).first;
    final foods = await ref.read(foodRepositoryProvider).watchAll(uid).first;
    final customFoods = await ref.read(customFoodRepositoryProvider).watchAll(uid).first;
    final fastings = await ref.read(fastingRepositoryProvider).watchAll(uid).first;
    final activities = await ref.read(activityRepositoryProvider).watchAll(uid).first;
    final photos = await ref.read(photoRepositoryProvider).watchAll(uid).first;
    final profile = await ref.read(userProfileRepositoryProvider).getProfile(uid);

    return {
      'profile': profile?.toJson(),
      'weight_entries': weights.map((e) => e.toJson()).toList(),
      'measurement_entries': measurements.map((e) => e.toJson()).toList(),
      'water_entries': waters.map((e) => e.toJson()).toList(),
      'food_entries': foods.map((e) => e.toJson()).toList(),
      'custom_foods': customFoods.map((e) => e.toJson()).toList(),
      'fasting_sessions': fastings.map((e) => e.toJson()).toList(),
      'activity_entries': activities.map((e) => e.toJson()).toList(),
      'photo_entries': photos.map((e) => e.toJson()).toList(),
    };
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: Text(strings.exportImportTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_busy) LoadingView(label: strings.workingLabel),
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(strings.exportTitle, style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 12),
                  PrimaryButton(label: strings.exportJson, onPressed: _busy ? null : _exportJson),
                  const SizedBox(height: 8),
                  SecondaryButton(label: strings.exportCsv, onPressed: _busy ? null : _exportCsv),
                ],
              ),
            ),
            const SizedBox(height: 16),
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(strings.importTitle, style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 12),
                  PrimaryButton(
                    label: strings.importJson,
                    onPressed: () => context.push('/import-json'),
                  ),
                  const SizedBox(height: 8),
                  SecondaryButton(
                    label: strings.csvImportWizard,
                    onPressed: () => Navigator.of(context).push<void>(
                      MaterialPageRoute<void>(builder: (_) => const CsvImportWizardPage()),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
