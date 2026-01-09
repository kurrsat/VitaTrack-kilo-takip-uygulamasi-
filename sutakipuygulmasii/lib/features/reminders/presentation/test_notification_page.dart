import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:water_reminder/app/providers.dart';
import 'package:water_reminder/features/reminders/domain/reminder_config.dart';
import 'package:water_reminder/app/exit_handler.dart';

/// Minimal test page for notification testing
class TestNotificationPage extends ConsumerWidget {
  const TestNotificationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationService = ref.watch(notificationServiceProvider);

    return Scaffold(
      appBar: AppBar(
        leading: const WaterBackButton(),
        title: const Text('Bildirim Testi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Bildirim Testi',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Su hatirlatma bildirimlerini test et. Test bildirimi '
              '10 saniye icinde gorunur.',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () async {
                await notificationService.showTestNotification();
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                          'Test bildirimi 10 saniye icin planlandi'),
                      duration: const Duration(seconds: 3),
                    ),
                  );
                }
              },
              icon: const Icon(Icons.notifications_active),
              label: const Text('Test Bildirimi Gonder (10 sn)'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () async {
                // Create a simple test reminder config
                final config = ReminderConfig(
                  id: 'test_reminder',
                  mode: ReminderMode.interval,
                  isEnabled: true,
                  intervalMinutes: 60,
                  awakeWindow: const TimeRange(
                    startHour: 8,
                    startMinute: 0,
                    endHour: 22,
                    endMinute: 0,
                  ),
                );

                await notificationService.scheduleReminders(config);

                final pending =
                    await notificationService.getPendingNotifications();

                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${pending.length} hatirlatici planlandi'),
                      duration: const Duration(seconds: 3),
                    ),
                  );
                }
              },
              icon: const Icon(Icons.schedule),
              label: const Text('Aralikli Hatirlatici Planla'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
              ),
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: () async {
                await notificationService.cancelAllReminders();
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Tum hatirlaticilar iptal edildi'),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                }
              },
              icon: const Icon(Icons.cancel),
              label: const Text('Tum Hatirlaticilari Iptal Et'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.all(16),
              ),
            ),
            const SizedBox(height: 32),
            FutureBuilder<List<PendingNotificationRequest>>(
              future: notificationService.getPendingNotifications(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const CircularProgressIndicator();
                }

                final pendingList = snapshot.data!;

                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Builder(builder: (context) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Bekleyen Bildirimler: ${pendingList.length}',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 8),
                          if (pendingList.isEmpty)
                            const Text('Bekleyen bildirim yok')
                          else
                            ...pendingList.take(5).map((p) => Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4),
                                  child: Text(
                                    'ID: ${p.id} - ${p.title ?? ''}',
                                  ),
                                )),
                        ],
                      );
                    }),
                  ),
                );
              },
            ),
            const Spacer(),
            const Card(
              color: Colors.blue,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bildirim Islemleri',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '"+200 ml" ile su kaydi yap\n'
                      '"Ertele 15 dk" ile ertele',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
