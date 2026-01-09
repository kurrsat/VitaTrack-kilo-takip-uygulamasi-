import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Notification step - educate about permissions and test
class NotificationStep extends ConsumerWidget {
  const NotificationStep({
    super.key,
    required this.onComplete,
    required this.onBack,
  });

  final VoidCallback onComplete;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Takipte Kal',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Zamaninda hatirlatmalar icin bildirimleri ac',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 32),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Notification benefits
                  _buildBenefitCard(
                    icon: Icons.notifications_active,
                    title: 'Akilli Hatirlatmalar',
                    description:
                        'Programina gore dogru zamanlarda bildirim al',
                    color: Colors.blue,
                  ),
                  const SizedBox(height: 16),
                  _buildBenefitCard(
                    icon: Icons.touch_app,
                    title: 'Hizli Islemler',
                    description: 'Bildirimlerden direkt su kaydi yap',
                    color: Colors.green,
                  ),
                  const SizedBox(height: 16),
                  _buildBenefitCard(
                    icon: Icons.schedule,
                    title: 'Esnek Takvim',
                    description: 'Hatirlatma saatlerini ve sessiz saatleri ayarla',
                    color: Colors.orange,
                  ),

                  const SizedBox(height: 32),

                  // Test notification button
                  Card(
                    color: Colors.purple.shade50,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          const Icon(
                            Icons.notification_add,
                            size: 48,
                            color: Colors.purple,
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Bildirim Testi',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Hatirlatmalarin cihazinda nasil gorundugunu gor',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(height: 16),
                          // Test button temporarily removed for web compatibility
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  Card(
                    color: Colors.grey.shade100,
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Icon(Icons.info_outline, size: 20),
                          SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Bildirim ayarlarini uygulamada her zaman duzenleyebilirsin',
                              style: TextStyle(fontSize: 13),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Navigation buttons
          Row(
            children: [
              TextButton(
                onPressed: onBack,
                child: const Text('Geri'),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: onComplete,
                child: const Text('Kurulumu Bitir'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBenefitCard({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 32),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
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
