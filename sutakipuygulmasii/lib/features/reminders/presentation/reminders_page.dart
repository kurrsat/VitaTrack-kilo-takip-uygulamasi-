import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:water_reminder/app/providers.dart';
import 'package:water_reminder/features/reminders/domain/reminder_config.dart';
import 'package:water_reminder/features/reminders/presentation/reminders_providers.dart';
import 'package:water_reminder/app/exit_handler.dart';

class RemindersPage extends ConsumerStatefulWidget {
  const RemindersPage({super.key});

  @override
  ConsumerState<RemindersPage> createState() => _RemindersPageState();
}

class _RemindersPageState extends ConsumerState<RemindersPage> {
  bool _todayOff = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final service = ref.read(notificationServiceProvider);
      setState(() {
        _todayOff = service.isTodayOff();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final config = ref.watch(reminderConfigProvider);
    final notifier = ref.read(reminderConfigProvider.notifier);
    final notificationService = ref.read(notificationServiceProvider);

    return Scaffold(
      appBar: AppBar(
        leading: const WaterBackButton(),
        title: const Text('Hatırlatmalar'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: SwitchListTile(
              title: const Text('Hatırlatmaları etkinleştir'),
              subtitle: const Text(
                'Hatırlatmalar için bildirimleri açıp kapatın',
              ),
              value: config.isEnabled,
              onChanged: (value) async {
                await notifier.setEnabled(value);
              },
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Hatırlatma modu',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  SegmentedButton<ReminderMode>(
                    segments: const [
                      ButtonSegment(
                        value: ReminderMode.interval,
                        label: Text('Aralık'),
                      ),
                      ButtonSegment(
                        value: ReminderMode.fixedTimes,
                        label: Text('Sabit saatler'),
                      ),
                    ],
                    selected: {config.mode},
                    onSelectionChanged: (selection) async {
                      await notifier.setMode(selection.first);
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          if (config.mode == ReminderMode.interval)
            _IntervalSettingsCard(
              intervalMinutes: config.intervalMinutes,
              onChanged: (value) async {
                await notifier.setIntervalMinutes(value);
              },
            )
          else
            _FixedTimesCard(
              times: config.fixedTimes,
              onAdd: (time) async {
                final updated = _sortedFixedTimes([
                  ...config.fixedTimes,
                  _timeRangeFromTimeOfDay(time),
                ]);
                await notifier.setFixedTimes(updated);
              },
              onEdit: (index, time) async {
                final updated = [...config.fixedTimes];
                updated[index] = _timeRangeFromTimeOfDay(time);
                await notifier.setFixedTimes(_sortedFixedTimes(updated));
              },
              onDelete: (index) async {
                final updated = [...config.fixedTimes]..removeAt(index);
                await notifier.setFixedTimes(updated);
              },
            ),
          const SizedBox(height: 12),
          _ActiveDaysCard(
            activeDays: config.activeDays,
            onToggle: (day) async {
              final updated = Set<DayOfWeek>.from(config.activeDays);
              if (updated.contains(day)) {
                if (updated.length > 1) {
                  updated.remove(day);
                }
              } else {
                updated.add(day);
              }
              await notifier.setActiveDays(updated);
            },
          ),
          const SizedBox(height: 12),
          _TimeRangeCard(
            title: 'Uyanık saat aralığı',
            range: config.awakeWindow,
            onChanged: (range) async {
              await notifier.setAwakeWindow(range);
            },
          ),
          const SizedBox(height: 12),
          _QuietHoursCard(
            range: config.quietHours,
            onToggle: (enabled) async {
              if (!enabled) {
                await notifier.setQuietHours(null);
              } else {
                await notifier.setQuietHours(
                  const TimeRange(
                    startHour: 22,
                    startMinute: 0,
                    endHour: 7,
                    endMinute: 0,
                  ),
                );
              }
            },
            onChanged: (range) async {
              await notifier.setQuietHours(range);
            },
          ),
          const SizedBox(height: 12),
          _DefaultCupCard(
            amountMl: config.defaultCupAmountMl,
            onChanged: (value) async {
              await notifier.setDefaultCupAmount(value);
            },
          ),
          const SizedBox(height: 12),
          Card(
            child: SwitchListTile(
              title: const Text('Bugün kapalı'),
              subtitle:
                  const Text('Bugünün geri kalanı için hatırlatmaları durdur'),
              value: _todayOff,
              onChanged: (value) {
                setState(() {
                  _todayOff = value;
                });
                if (value) {
                  notificationService.setTodayOff();
                } else {
                  notificationService.clearTodayOff();
                  if (config.isEnabled) {
                    notificationService.scheduleReminders(config);
                  }
                }
              },
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () async {
                        await notificationService.snoozeReminder(
                          defaultCupAmount: config.defaultCupAmountMl,
                        );
                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('15 dakika ertelendi'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      icon: const Icon(Icons.snooze),
                      label: const Text('15 dk ertele'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () async {
                        await notificationService.showTestNotification(
                          defaultCupAmount: config.defaultCupAmountMl,
                        );
                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Test bildirimi planlandı'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      icon: const Icon(Icons.notifications_active),
                      label: const Text('Test'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static List<TimeRange> _sortedFixedTimes(List<TimeRange> times) {
    final updated = List<TimeRange>.from(times);
    updated.sort((a, b) {
      final aMinutes = a.startHour * 60 + a.startMinute;
      final bMinutes = b.startHour * 60 + b.startMinute;
      return aMinutes.compareTo(bMinutes);
    });
    return updated;
  }

  static TimeRange _timeRangeFromTimeOfDay(TimeOfDay time) {
    return TimeRange(
      startHour: time.hour,
      startMinute: time.minute,
      endHour: time.hour,
      endMinute: time.minute,
    );
  }
}

class _IntervalSettingsCard extends StatelessWidget {
  const _IntervalSettingsCard({
    required this.intervalMinutes,
    required this.onChanged,
  });

  final int intervalMinutes;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final options = <int>{30, 45, 60, 90, 120, 180, intervalMinutes}.toList()
      ..sort();
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Aralık',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            DropdownButton<int>(
              value: intervalMinutes,
              items: options
                  .map(
                    (value) => DropdownMenuItem(
                      value: value,
                      child: Text('Her $value dakikada'),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  onChanged(value);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _FixedTimesCard extends StatelessWidget {
  const _FixedTimesCard({
    required this.times,
    required this.onAdd,
    required this.onEdit,
    required this.onDelete,
  });

  final List<TimeRange> times;
  final ValueChanged<TimeOfDay> onAdd;
  final void Function(int index, TimeOfDay time) onEdit;
  final ValueChanged<int> onDelete;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Sabit saatler',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            if (times.isEmpty)
              const Text(
                'Henüz sabit saat yok. En az bir tane ekleyin.',
                style: TextStyle(color: Colors.grey),
              )
            else
              Column(
                children: List.generate(times.length, (index) {
                  final time = times[index];
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.schedule),
                    title: Text(_formatTimeOfDay(
                      context,
                      TimeOfDay(hour: time.startHour, minute: time.startMinute),
                    )),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_outline),
                      onPressed: () => onDelete(index),
                    ),
                    onTap: () async {
                      final picked = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay(
                          hour: time.startHour,
                          minute: time.startMinute,
                        ),
                      );
                      if (picked != null) {
                        onEdit(index, picked);
                      }
                    },
                  );
                }),
              ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: () async {
                final picked = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (picked != null) {
                  onAdd(picked);
                }
              },
              icon: const Icon(Icons.add),
              label: const Text('Saat ekle'),
            ),
          ],
        ),
      ),
    );
  }

  static String _formatTimeOfDay(BuildContext context, TimeOfDay time) {
    return time.format(context);
  }
}

class _ActiveDaysCard extends StatelessWidget {
  const _ActiveDaysCard({
    required this.activeDays,
    required this.onToggle,
  });

  final Set<DayOfWeek> activeDays;
  final ValueChanged<DayOfWeek> onToggle;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Aktif günler',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: DayOfWeek.values.map((day) {
                final selected = activeDays.contains(day);
                return FilterChip(
                  label: Text(_dayLabel(day)),
                  selected: selected,
                  onSelected: (_) => onToggle(day),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  static String _dayLabel(DayOfWeek day) {
    switch (day) {
      case DayOfWeek.monday:
        return 'Pzt';
      case DayOfWeek.tuesday:
        return 'Sal';
      case DayOfWeek.wednesday:
        return 'Çar';
      case DayOfWeek.thursday:
        return 'Per';
      case DayOfWeek.friday:
        return 'Cum';
      case DayOfWeek.saturday:
        return 'Cmt';
      case DayOfWeek.sunday:
        return 'Paz';
    }
  }
}

class _TimeRangeCard extends StatelessWidget {
  const _TimeRangeCard({
    required this.title,
    required this.range,
    required this.onChanged,
  });

  final String title;
  final TimeRange range;
  final ValueChanged<TimeRange> onChanged;

  @override
  Widget build(BuildContext context) {
    final startTime = TimeOfDay(
      hour: range.startHour,
      minute: range.startMinute,
    );
    final endTime = TimeOfDay(
      hour: range.endHour,
      minute: range.endMinute,
    );

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () async {
                      final picked = await showTimePicker(
                        context: context,
                        initialTime: startTime,
                      );
                      if (picked == null) return;
                      onChanged(
                        TimeRange(
                          startHour: picked.hour,
                          startMinute: picked.minute,
                          endHour: range.endHour,
                          endMinute: range.endMinute,
                        ),
                      );
                    },
                    child: Text(startTime.format(context)),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Text('-'),
                ),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () async {
                      final picked = await showTimePicker(
                        context: context,
                        initialTime: endTime,
                      );
                      if (picked == null) return;
                      onChanged(
                        TimeRange(
                          startHour: range.startHour,
                          startMinute: range.startMinute,
                          endHour: picked.hour,
                          endMinute: picked.minute,
                        ),
                      );
                    },
                    child: Text(endTime.format(context)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _QuietHoursCard extends StatelessWidget {
  const _QuietHoursCard({
    required this.range,
    required this.onToggle,
    required this.onChanged,
  });

  final TimeRange? range;
  final ValueChanged<bool> onToggle;
  final ValueChanged<TimeRange> onChanged;

  @override
  Widget build(BuildContext context) {
    final enabled = range != null;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SwitchListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Sessiz saatler'),
              subtitle: const Text(
                'Bu zaman aralığında hatırlatma gönderilmez',
              ),
              value: enabled,
              onChanged: onToggle,
            ),
            if (enabled) ...[
              const SizedBox(height: 8),
              _TimeRangeCard(
                title: 'Sessiz saatler',
                range: range!,
                onChanged: onChanged,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _DefaultCupCard extends StatelessWidget {
  const _DefaultCupCard({
    required this.amountMl,
    required this.onChanged,
  });

  final int amountMl;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Varsayılan bardak miktarı',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove_circle_outline),
                  onPressed: () {
                    final next = (amountMl - 50).clamp(50, 1000);
                    onChanged(next);
                  },
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      '$amountMl ml',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add_circle_outline),
                  onPressed: () {
                    final next = (amountMl + 50).clamp(50, 1000);
                    onChanged(next);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
