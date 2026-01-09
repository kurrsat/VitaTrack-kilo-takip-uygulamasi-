import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weightvault/core/ui/widgets.dart';
import 'package:weightvault/domain/models/models.dart';
import 'package:weightvault/features/weight/weight_providers.dart';
import 'package:weightvault/l10n/app_localizations.dart';

class AnalysisSettingsPage extends ConsumerStatefulWidget {
  const AnalysisSettingsPage({super.key});

  @override
  ConsumerState<AnalysisSettingsPage> createState() => _AnalysisSettingsPageState();
}

class _AnalysisSettingsPageState extends ConsumerState<AnalysisSettingsPage> {
  SmoothingLevel _smoothing = SmoothingLevel.medium;

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    final settings = ref.watch(trendSettingsProvider);
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: Text(strings.analysisSettingsTitle),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(strings.analyticsSmoothingTitle, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                SegmentedButton<SmoothingLevel>(
                  segments: [
                    ButtonSegment(
                      value: SmoothingLevel.low,
                      label: Text(strings.smoothingLow),
                    ),
                    ButtonSegment(
                      value: SmoothingLevel.medium,
                      label: Text(strings.smoothingMedium),
                    ),
                    ButtonSegment(
                      value: SmoothingLevel.high,
                      label: Text(strings.smoothingHigh),
                    ),
                  ],
                  selected: {_smoothing},
                  onSelectionChanged: (value) {
                    final next = value.first;
                    setState(() => _smoothing = next);
                    _applySmoothing(next);
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(strings.advancedSettingsTitle, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 12),
                DropdownButtonFormField<TrendMethod>(
                  value: settings.method,
                  decoration: InputDecoration(labelText: strings.trendMethodLabel),
                  items: TrendMethod.values
                      .map(
                        (method) => DropdownMenuItem(
                          value: method,
                          child: Text(_trendMethodLabel(strings, method)),
                        ),
                      )
                      .toList(),
                  onChanged: (method) {
                    if (method == null) return;
                    ref.read(trendSettingsProvider.notifier).setMethod(method);
                  },
                ),
                const SizedBox(height: 12),
                Text(strings.alphaLabel(settings.alpha.toStringAsFixed(2))),
                Slider(
                  value: settings.alpha,
                  min: 0.05,
                  max: 0.95,
                  onChanged: (value) => ref.read(trendSettingsProvider.notifier).setAlpha(value),
                ),
                Text(strings.betaLabel(settings.beta.toStringAsFixed(2))),
                Slider(
                  value: settings.beta,
                  min: 0.05,
                  max: 0.95,
                  onChanged: (value) => ref.read(trendSettingsProvider.notifier).setBeta(value),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _applySmoothing(SmoothingLevel level) {
    final values = level.values;
    ref.read(trendSettingsProvider.notifier)
      ..setAlpha(values.alpha)
      ..setBeta(values.beta);
  }

  String _trendMethodLabel(AppLocalizations strings, TrendMethod method) {
    switch (method) {
      case TrendMethod.movingAverage:
        return strings.trendMethodMovingAverage;
      case TrendMethod.exponential:
        return strings.trendMethodExponential;
      case TrendMethod.doubleExponential:
        return strings.trendMethodDoubleExponential;
      case TrendMethod.custom:
        return strings.trendMethodCustom;
    }
  }
}

enum SmoothingLevel { low, medium, high }

extension on SmoothingLevel {
  _SmoothingValues get values {
    switch (this) {
      case SmoothingLevel.low:
        return const _SmoothingValues(alpha: 0.2, beta: 0.05);
      case SmoothingLevel.medium:
        return const _SmoothingValues(alpha: 0.4, beta: 0.1);
      case SmoothingLevel.high:
        return const _SmoothingValues(alpha: 0.7, beta: 0.2);
    }
  }
}

class _SmoothingValues {
  const _SmoothingValues({required this.alpha, required this.beta});

  final double alpha;
  final double beta;
}
