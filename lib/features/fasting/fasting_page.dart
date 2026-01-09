import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:weightvault/core/providers/app_init_provider.dart';
import 'package:weightvault/core/providers/providers.dart';
import 'package:weightvault/core/ui/widgets.dart';
import 'package:weightvault/core/utils/quiet_hours_utils.dart';
import 'package:weightvault/data/repositories/repository_providers.dart';
import 'package:weightvault/domain/models/models.dart';
import 'package:weightvault/features/fasting/fasting_providers.dart';
import 'package:weightvault/l10n/app_localizations.dart';

class FastingPage extends ConsumerStatefulWidget {
  const FastingPage({super.key});

  @override
  ConsumerState<FastingPage> createState() => _FastingPageState();
}

class _FastingPageState extends ConsumerState<FastingPage> {
  FastingPlanType _planType = FastingPlanType.sixteenEight;
  int _goalHours = 16;
  Timer? _timer;
  Duration _elapsed = Duration.zero;
  String? _activeId;
  int? _lastWidgetMinute;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer(DateTime start) {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      final elapsed = DateTime.now().difference(start);
      setState(() => _elapsed = elapsed);
      _updateFastingWidget(elapsed: elapsed, goalHours: _goalHours);
    });
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    return '${hours}h ${minutes}m';
  }

  void _updateFastingWidget({required Duration elapsed, required int goalHours}) {
    final isPremium = ref.read(premiumServiceProvider).isPremium();
    if (!isPremium) {
      return;
    }
    final remainingRaw = Duration(hours: goalHours) - elapsed;
    final remaining = remainingRaw.isNegative ? Duration.zero : remainingRaw;
    final minuteMark = remaining.inMinutes;
    if (_lastWidgetMinute == minuteMark) {
      return;
    }
    _lastWidgetMinute = minuteMark;
    ref.read(widgetServiceProvider).updateFastingTimer(remaining: _formatDuration(remaining));
  }

  Future<void> _startFasting() async {
    final uid = ref.read(currentUserIdProvider);
    if (uid == null) return;
    final strings = AppLocalizations.of(context)!;
    final now = DateTime.now().toUtc();
    final session = FastingSession(
      id: const Uuid().v4(),
      uid: uid,
      start: now,
      planType: _planType,
      goalHours: _goalHours,
      completed: false,
      lastUpdatedAt: now,
    );
    await ref.read(fastingRepositoryProvider).upsert(session);
    _startTimer(now);
    final prefs = await ref.read(preferencesProvider.future);
    final quietStart = prefs.quietHoursStartMinutes;
    final quietEnd = prefs.quietHoursEndMinutes;
    var notifyAt = now.add(Duration(hours: _goalHours));
    if (quietStart != null && quietEnd != null) {
      final quiet = QuietHours(startMinutes: quietStart, endMinutes: quietEnd);
      notifyAt = quiet.nextAllowed(notifyAt);
    }
    await ref.read(notificationsServiceProvider).scheduleOneOff(
          id: 201,
          title: strings.fastingCompleteTitle,
          body: strings.fastingCompleteBody,
          time: notifyAt,
        );
    _lastWidgetMinute = null;
    _updateFastingWidget(elapsed: Duration.zero, goalHours: _goalHours);
  }

  Future<void> _stopFasting(FastingSession active) async {
    final now = DateTime.now().toUtc();
    final updated = active.copyWith(end: now, completed: true, lastUpdatedAt: now);
    await ref.read(fastingRepositoryProvider).upsert(updated);
    _timer?.cancel();
    _lastWidgetMinute = null;
    if (ref.read(premiumServiceProvider).isPremium()) {
      await ref.read(widgetServiceProvider).updateFastingTimer(remaining: '0h 0m');
    }
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    final activeAsync = ref.watch(activeFastingProvider);
    final historyAsync = ref.watch(fastingSessionsProvider);
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: Text(strings.fastingTitle),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          activeAsync.when(
            data: (active) {
              if (active == null) {
                return AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(strings.startFastTitle, style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 12),
                      DropdownButtonFormField<FastingPlanType>(
                        value: _planType,
                        items: FastingPlanType.values
                            .map(
                              (plan) => DropdownMenuItem(
                                value: plan,
                                child: Text(_planLabel(strings, plan)),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          if (value != null) setState(() => _planType = value);
                        },
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(labelText: strings.goalHoursLabel),
                        onChanged: (value) => _goalHours = int.tryParse(value) ?? _goalHours,
                      ),
                      const SizedBox(height: 12),
                      PrimaryButton(label: strings.startLabel, onPressed: _startFasting),
                    ],
                  ),
                );
              }
              if (_activeId != active.id) {
                _activeId = active.id;
                _goalHours = active.goalHours;
                _startTimer(active.start.toLocal());
              }
              final remaining = Duration(hours: active.goalHours) - _elapsed;
              return AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(strings.activeFastTitle, style: Theme.of(context).textTheme.titleLarge),
                    const SizedBox(height: 8),
                    Text(strings.elapsedLabel(_elapsed.inHours, _elapsed.inMinutes % 60)),
                    Text(strings.remainingLabel(remaining.inHours, remaining.inMinutes % 60)),
                    const SizedBox(height: 12),
                    SecondaryButton(label: strings.stopLabel, onPressed: () => _stopFasting(active)),
                  ],
                ),
              );
            },
            loading: () => LoadingView(label: strings.loadingFasting),
            error: (error, _) => ErrorState(title: strings.errorTitle, message: error.toString()),
          ),
          const SizedBox(height: 16),
          historyAsync.when(
            data: (sessions) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(strings.historyTitle, style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 8),
                  ...sessions.map(
                    (session) => ListTile(
                      title: Text(_planLabel(strings, session.planType)),
                      subtitle: Text(session.start.toLocal().toString().split(' ').first),
                      trailing: Text(session.completed ? strings.doneLabel : strings.activeLabel),
                    ),
                  ),
                ],
              );
            },
            loading: () => LoadingView(label: strings.loadingHistory),
            error: (error, _) => ErrorState(title: strings.errorTitle, message: error.toString()),
          ),
        ],
      ),
    );
  }

  String _planLabel(AppLocalizations strings, FastingPlanType plan) {
    switch (plan) {
      case FastingPlanType.sixteenEight:
        return strings.fastingPlan168;
      case FastingPlanType.eighteenSix:
        return strings.fastingPlan186;
      case FastingPlanType.twentyFour:
        return strings.fastingPlan204;
      case FastingPlanType.omad:
        return strings.fastingPlanOmad;
      case FastingPlanType.custom:
        return strings.fastingPlanCustom;
    }
  }
}
