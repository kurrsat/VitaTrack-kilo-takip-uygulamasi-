import 'dart:convert';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weightvault/core/providers/app_init_provider.dart';
import 'package:weightvault/core/providers/providers.dart';
import 'package:weightvault/core/ui/widgets.dart';
import 'package:weightvault/data/repositories/repository_providers.dart';
import 'package:weightvault/l10n/app_localizations.dart';

class CsvImportWizardPage extends ConsumerStatefulWidget {
  const CsvImportWizardPage({super.key});

  @override
  ConsumerState<CsvImportWizardPage> createState() => _CsvImportWizardPageState();
}

class _CsvImportWizardPageState extends ConsumerState<CsvImportWizardPage> {
  String? _content;
  List<String> _columns = [];
  String? _dateColumn;
  String? _weightColumn;
  bool _busy = false;

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv'],
      withData: true,
    );
    if (result == null || result.files.single.bytes == null) return;
    final content = utf8.decode(result.files.single.bytes!);
    final header = content.split('\n').first.split(',');
    setState(() {
      _content = content;
      _columns = header;
      _dateColumn = header.isNotEmpty ? header.first : null;
      _weightColumn = header.length > 1 ? header[1] : null;
    });
  }

  Future<void> _import() async {
    final uid = ref.read(currentUserIdProvider);
    if (uid == null || _content == null || _dateColumn == null || _weightColumn == null) return;
    setState(() => _busy = true);
    try {
      final strings = AppLocalizations.of(context)!;
      final entries = await ref.read(exportImportServiceProvider).importWeightCsv(
            uid: uid,
            content: _content!,
            dateColumn: _dateColumn!,
            weightColumn: _weightColumn!,
          );
      for (final entry in entries) {
        await ref.read(weightRepositoryProvider).upsert(entry);
      }
      await ref.read(crashlyticsProvider).log('import_csv');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(strings.importedEntries(entries.length))),
        );
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: Text(strings.csvImportWizardTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_busy) LoadingView(label: strings.importingLabel),
            PrimaryButton(label: strings.selectCsvFile, onPressed: _pickFile),
            const SizedBox(height: 16),
            if (_columns.isNotEmpty) ...[
              DropdownButtonFormField<String>(
                value: _dateColumn,
                items: _columns.map((col) => DropdownMenuItem(value: col, child: Text(col))).toList(),
                onChanged: (value) => setState(() => _dateColumn = value),
                decoration: InputDecoration(labelText: strings.dateColumnLabel),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _weightColumn,
                items: _columns.map((col) => DropdownMenuItem(value: col, child: Text(col))).toList(),
                onChanged: (value) => setState(() => _weightColumn = value),
                decoration: InputDecoration(labelText: strings.weightColumnLabel),
              ),
              const SizedBox(height: 16),
              PrimaryButton(label: strings.importLabel, onPressed: _busy ? null : _import),
            ],
          ],
        ),
      ),
    );
  }
}
