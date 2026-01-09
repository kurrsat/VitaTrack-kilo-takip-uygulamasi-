import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:water_reminder/app/router.dart';
import 'package:water_reminder/core/errors/app_error.dart';
import 'package:water_reminder/core/result/result.dart';
import 'package:water_reminder/core/services/export_restore_service.dart';
import 'package:water_reminder/features/hydration/domain/beverage_type.dart';
import 'package:water_reminder/features/hydration/domain/quick_add_defaults.dart';
import 'package:water_reminder/features/hydration/presentation/hydration_providers.dart';
import 'package:water_reminder/app/exit_handler.dart';

class _SettingsStrings {
  const _SettingsStrings();

  String get settings => 'Ayarlar';
  String get settingsProfile => 'Profil';
  String get settingsProfileSubtitle => 'Kisisel bilgiler';
  String get settingsGoal => 'Hedef';
  String get settingsGoalSubtitle => 'Gunluk su hedefi';
  String get settingsReminders => 'Hatirlaticilar';
  String get settingsRemindersSubtitle => 'Bildirimleri planla';
  String get settingsCups => 'Hizli ekle';
  String get settingsCupsSubtitle => 'Varsayilan icecek miktarlari';
  String get settingsNotifications => 'Bildirim testi';
  String get settingsNotificationsSubtitle => 'Test hatirlatma gonder';
  String get settingsData => 'Veri';
  String get settingsDataSubtitle => 'Disari aktar veya sifirla';
  String get settingsPremium => 'Premium';
  String get settingsPremiumSubtitle => 'Ek ozellikleri ac';
  String get settingsHelp => 'Yardim';
  String get settingsHelpSubtitle => 'Ipuclari ve SSS';
  String get settingsPrivacy => 'Gizlilik';
  String get settingsPrivacySubtitle => 'Verilerin nasil saklanir';
  String get exportData => 'Veriyi disa aktar';
  String get exportDataDesc => 'Yedek dosyasi kaydet';
  String get restoreData => 'Veriyi geri yukle';
  String get restoreDataDesc => 'Yedek dosyadan ice aktar';
  String get resetAllData => 'Tum verileri sifirla';
  String get resetAllDataDesc => 'Bu cihazdaki verileri sil';
  String get resetConfirmTitle => 'Veriler sifirlansin mi?';
  String get resetConfirmMessage =>
      'Bu islem tum yerel verileri silecektir. Geri alinmaz.';
  String get cancel => 'Iptal';
  String get reset => 'Sifirla';
  String get helpTitle => 'Yardim';
  String get helpNotificationsTitle => 'Bildirimler calismiyor';
  String get helpNotificationsIos =>
      "Ayarlar > Bildirimler'den bu uygulama icin izinleri ac.";
  String get helpNotificationsAndroid =>
      "Uygulama bilgisi > Bildirimler'den kanallari ac.";
  String get helpFaqTitle => 'SSS';
  String get helpFaq1Q => 'Ne siklikla su icmeliyim?';
  String get helpFaq1A => 'Gun boyu kucuk yudumlarla ic.';
  String get helpFaq2Q => 'Hedefim neden farkli?';
  String get helpFaq2A => 'Hedefin aktivite ve ayarlara gore degisir.';
  String get helpFaq3Q => 'Verilerimi yedekleyebilir miyim?';
  String get helpFaq3A => 'Veri bolumunden Veriyi disa aktar secenegini kullan.';
  String get privacyTitle => 'Gizlilik';
  String get privacyLocalStorage => 'Yerel depolama';
  String get privacyLocalStorageDesc =>
      'Veriler, disari aktarmadigin surece bu cihazda kalir.';
  String get privacyNoTracking => 'Takip yok';
  String get privacyNoTrackingDesc => 'Verilerini takip etmeyiz veya satmayiz.';
  String get privacyPermissions => 'Izinler';
  String get privacyPermissionsDesc =>
      'Bildirimler sadece hatirlatma icindir.';
}

/// Comprehensive settings page
class SettingsPageContent extends ConsumerWidget {
  const SettingsPageContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const strings = _SettingsStrings();

    return Scaffold(
      appBar: AppBar(
        leading: const WaterBackButton(),
        title: Text(strings.settings),
      ),
      body: ListView(
        children: [
          // Profile Section
          ListTile(
            leading: const Icon(Icons.person),
            title: Text(strings.settingsProfile),
            subtitle: Text(strings.settingsProfileSubtitle),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push(Routes.profileEdit),
          ),

          // Goal Section
          ListTile(
            leading: const Icon(Icons.track_changes),
            title: Text(strings.settingsGoal),
            subtitle: Text(strings.settingsGoalSubtitle),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push(Routes.goalSettings),
          ),

          const Divider(),

          // Reminders Section
          ListTile(
            leading: const Icon(Icons.notifications),
            title: Text(strings.settingsReminders),
            subtitle: Text(strings.settingsRemindersSubtitle),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push(Routes.reminderSettings),
          ),

          // Cups Section
          ListTile(
            leading: const Icon(Icons.local_drink),
            title: Text(strings.settingsCups),
            subtitle: Text(strings.settingsCupsSubtitle),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push(Routes.cupsSettings),
          ),

          // Test Notifications
          ListTile(
            leading: const Icon(Icons.bug_report),
            title: Text(strings.settingsNotifications),
            subtitle: Text(strings.settingsNotificationsSubtitle),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.go(Routes.testNotification),
          ),

          const Divider(),

          // Data Management
          ListTile(
            leading: const Icon(Icons.storage),
            title: Text(strings.settingsData),
            subtitle: Text(strings.settingsDataSubtitle),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push(Routes.dataManagement),
          ),

          // Premium
          ListTile(
            leading: const Icon(Icons.star, color: Colors.amber),
            title: Text(strings.settingsPremium),
            subtitle: Text(strings.settingsPremiumSubtitle),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.go(Routes.premium),
          ),

          const Divider(),

          // Help
          ListTile(
            leading: const Icon(Icons.help),
            title: Text(strings.settingsHelp),
            subtitle: Text(strings.settingsHelpSubtitle),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push(Routes.help),
          ),

          // Privacy
          ListTile(
            leading: const Icon(Icons.privacy_tip),
            title: Text(strings.settingsPrivacy),
            subtitle: Text(strings.settingsPrivacySubtitle),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => context.push(Routes.privacy),
          ),

          const SizedBox(height: 20),

          // App Version
          const Center(
            child: Text(
              'Version 1.0.0',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class QuickAddSettingsPage extends ConsumerStatefulWidget {
  const QuickAddSettingsPage({super.key});

  @override
  ConsumerState<QuickAddSettingsPage> createState() =>
      _QuickAddSettingsPageState();
}

class _QuickAddSettingsPageState extends ConsumerState<QuickAddSettingsPage> {
  final _waterController = TextEditingController();
  final _teaController = TextEditingController();
  final _coffeeController = TextEditingController();
  bool _loadedFromStore = false;

  @override
  void initState() {
    super.initState();
    _applyDefaults(QuickAddDefaults.standard);
  }

  @override
  void dispose() {
    _waterController.dispose();
    _teaController.dispose();
    _coffeeController.dispose();
    super.dispose();
  }

  void _applyDefaults(QuickAddDefaults defaults) {
    _waterController.text = defaults.waterMl.toString();
    _teaController.text = defaults.teaMl.toString();
    _coffeeController.text = defaults.coffeeMl.toString();
  }

  int _readAmount(TextEditingController controller, int fallback) {
    final parsed = int.tryParse(controller.text);
    final value = parsed ?? fallback;
    return value.clamp(50, 2000);
  }

  void _adjustAmount(
    TextEditingController controller,
    int fallback,
    int delta,
  ) {
    final current = _readAmount(controller, fallback);
    final next = (current + delta).clamp(50, 2000);
    controller.text = next.toString();
  }

  Future<void> _saveDefaults() async {
    final defaults = QuickAddDefaults(
      waterMl: _readAmount(
        _waterController,
        QuickAddDefaults.standard.waterMl,
      ),
      teaMl: _readAmount(
        _teaController,
        QuickAddDefaults.standard.teaMl,
      ),
      coffeeMl: _readAmount(
        _coffeeController,
        QuickAddDefaults.standard.coffeeMl,
      ),
    );

    await saveQuickAddDefaults(ref, defaults);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Hizli ekle varsayilanlari guncellendi'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final defaultsAsync = ref.watch(quickAddDefaultsProvider);

    defaultsAsync.whenData((defaults) {
      if (_loadedFromStore) return;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted || _loadedFromStore) return;
        _loadedFromStore = true;
        _applyDefaults(defaults);
      });
    });

    return Scaffold(
      appBar: AppBar(
        leading: const WaterBackButton(),
        title: const Text('Hizli Ekle'),
      ),
      body: defaultsAsync.when(
        data: (_) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const Text(
                'Hizli ekleme icin varsayilan miktarlari ayarla.',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 16),
              _QuickAddAmountCard(
                label: 'Su',
                icon: Icons.water_drop,
                color: BeverageType.water.color,
                controller: _waterController,
                onDecrease: () => _adjustAmount(
                  _waterController,
                  QuickAddDefaults.standard.waterMl,
                  -50,
                ),
                onIncrease: () => _adjustAmount(
                  _waterController,
                  QuickAddDefaults.standard.waterMl,
                  50,
                ),
              ),
              const SizedBox(height: 12),
              _QuickAddAmountCard(
                label: 'Cay',
                icon: Icons.emoji_food_beverage,
                color: BeverageType.blackTea.color,
                controller: _teaController,
                onDecrease: () => _adjustAmount(
                  _teaController,
                  QuickAddDefaults.standard.teaMl,
                  -50,
                ),
                onIncrease: () => _adjustAmount(
                  _teaController,
                  QuickAddDefaults.standard.teaMl,
                  50,
                ),
              ),
              const SizedBox(height: 12),
              _QuickAddAmountCard(
                label: 'Kahve',
                icon: Icons.local_cafe,
                color: BeverageType.coffee.color,
                controller: _coffeeController,
                onDecrease: () => _adjustAmount(
                  _coffeeController,
                  QuickAddDefaults.standard.coffeeMl,
                  -50,
                ),
                onIncrease: () => _adjustAmount(
                  _coffeeController,
                  QuickAddDefaults.standard.coffeeMl,
                  50,
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _saveDefaults,
                icon: const Icon(Icons.save),
                label: const Text('Kaydet'),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Hata: $error'),
        ),
      ),
    );
  }
}

class _QuickAddAmountCard extends StatelessWidget {
  const _QuickAddAmountCard({
    required this.label,
    required this.icon,
    required this.color,
    required this.controller,
    required this.onDecrease,
    required this.onIncrease,
  });

  final String label;
  final IconData icon;
  final Color color;
  final TextEditingController controller;
  final VoidCallback onDecrease;
  final VoidCallback onIncrease;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: color.withOpacity(0.12),
                  foregroundColor: color,
                  child: Icon(icon),
                ),
                const SizedBox(width: 12),
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                IconButton(
                  onPressed: onDecrease,
                  icon: const Icon(Icons.remove_circle_outline),
                  color: color,
                ),
                Expanded(
                  child: TextField(
                    controller: controller,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      suffixText: 'ml',
                    ),
                  ),
                ),
                IconButton(
                  onPressed: onIncrease,
                  icon: const Icon(Icons.add_circle_outline),
                  color: color,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Data management page
class DataManagementPage extends ConsumerWidget {
  const DataManagementPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const strings = _SettingsStrings();
    final service = ExportRestoreService();

    return Scaffold(
      appBar: AppBar(
        leading: const WaterBackButton(),
        title: Text(strings.settingsData),
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.upload),
            title: Text(strings.exportData),
            subtitle: Text(strings.exportDataDesc),
            onTap: () async {
              // Show loading
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => const Center(
                  child: CircularProgressIndicator(),
                ),
              );

              final result = await service.exportData();

              if (context.mounted) {
                Navigator.of(context).pop(); // Close loading

                switch (result) {
                  case Success(:final value):
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(value),
                        backgroundColor: Colors.green,
                      ),
                    );
                  case Failure(:final error):
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text((error as AppError).message),
                        backgroundColor: Colors.red,
                      ),
                    );
                }
              }
            },
          ),

          ListTile(
            leading: const Icon(Icons.download),
            title: Text(strings.restoreData),
            subtitle: Text(strings.restoreDataDesc),
            onTap: () async {
              // Show loading
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => const Center(
                  child: CircularProgressIndicator(),
                ),
              );

              final result = await service.importData();

              if (context.mounted) {
                Navigator.of(context).pop(); // Close loading

                switch (result) {
                  case Success(:final value):
                    // Show success with app restart instruction
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Ice aktarma basarili'),
                        content: Text(value),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              // Navigate to home to trigger refresh
                              context.go(Routes.home);
                            },
                            child: const Text('Tamam'),
                          ),
                        ],
                      ),
                    );
                  case Failure(:final error):
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text((error as AppError).message),
                        backgroundColor: Colors.red,
                        duration: const Duration(seconds: 5),
                      ),
                    );
                }
              }
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.delete_forever, color: Colors.red),
            title: Text(
              strings.resetAllData,
              style: const TextStyle(color: Colors.red),
            ),
            subtitle: Text(strings.resetAllDataDesc),
            onTap: () => _showResetConfirmDialog(context, strings),
          ),
        ],
      ),
    );
  }

  Future<void> _showResetConfirmDialog(
      BuildContext context, _SettingsStrings strings) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(strings.resetConfirmTitle),
        content: Text(strings.resetConfirmMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(strings.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: Text(strings.reset),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      await _resetAllData();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Tum veriler sifirlandi')),
        );
        context.go(Routes.onboarding);
      }
    }
  }

  Future<void> _resetAllData() async {
    // Delete all Hive boxes
    await Hive.deleteBoxFromDisk('user_profile');
    await Hive.deleteBoxFromDisk('app_state');
    await Hive.deleteBoxFromDisk('intake_logs');
    await Hive.deleteBoxFromDisk('achievements');
    await Hive.deleteBoxFromDisk('quick_add_settings');
    await Hive.deleteBoxFromDisk('daily_goal_history');
    await Hive.deleteBoxFromDisk('reminder_config');
  }
}

/// Help and troubleshooting page
class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    const strings = _SettingsStrings();

    return Scaffold(
      appBar: AppBar(
        leading: const WaterBackButton(),
        title: Text(strings.helpTitle),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Notifications Troubleshooting
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.notifications_off, color: Colors.orange),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          strings.helpNotificationsTitle,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'iOS:',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(strings.helpNotificationsIos),
                  const SizedBox(height: 12),
                  Text(
                    'Android:',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(strings.helpNotificationsAndroid),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // FAQ Section
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    strings.helpFaqTitle,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildFaqItem(
                    strings.helpFaq1Q,
                    strings.helpFaq1A,
                  ),
                  const Divider(),
                  _buildFaqItem(
                    strings.helpFaq2Q,
                    strings.helpFaq2A,
                  ),
                  const Divider(),
                  _buildFaqItem(
                    strings.helpFaq3Q,
                    strings.helpFaq3A,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFaqItem(String question, String answer) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            answer,
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

/// Privacy policy page
class PrivacyPage extends StatelessWidget {
  const PrivacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    const strings = _SettingsStrings();

    return Scaffold(
      appBar: AppBar(
        leading: const WaterBackButton(),
        title: Text(strings.privacyTitle),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Local Storage
          Card(
            color: Colors.green.shade50,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.phone_android, color: Colors.green),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          strings.privacyLocalStorage,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(strings.privacyLocalStorageDesc),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // No Tracking
          Card(
            color: Colors.blue.shade50,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.block, color: Colors.blue),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          strings.privacyNoTracking,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(strings.privacyNoTrackingDesc),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Permissions
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.security),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          strings.privacyPermissions,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(strings.privacyPermissionsDesc),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
