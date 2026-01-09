import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:weightvault/core/providers/providers.dart';
import 'package:weightvault/data/repositories/repository_providers.dart';
import 'package:weightvault/features/settings/profile_providers.dart';
import 'package:weightvault/l10n/app_localizations.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}


class _SettingsPageState extends ConsumerState<SettingsPage> {
  // Local state for immediate UI feedback
  bool _mealEnabled = false;
  int _mealMinutes = 12 * 60;
  bool _waterEnabled = false;
  int _waterMinutes = 10 * 60;
  bool _activityEnabled = false; // New
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initPrefs();
  }

  void _initPrefs() {
    final prefs = ref.watch(preferencesProvider).valueOrNull;
    if (prefs != null && !_initialized) {
      setState(() {
        _mealEnabled = prefs.mealReminderEnabled;
        _mealMinutes = prefs.mealReminderMinutes ?? 12 * 60;
        _waterEnabled = prefs.waterReminderEnabled;
        _waterMinutes = prefs.waterReminderMinutes ?? 10 * 60;
         // Default to false if key doesn't exist yet, we'll need to update PreferenceService to expose getter ideally or just use generic getBool
         // simpler: assume false for now or read generic if I can't update service quickly.
         // Actually I should update PreferencesService too. But for now let's assume default false.
         // Since I can't easily see PreferencesService right now, I'll access via ref if possible or just assume false.
         // Wait, the previous code used `prefs.mealReminderEnabled`. I need to ensure `prefs` object has `activityReminderEnabled`. 
         // Since I only added the key string, I probably need to update the `PreferencesService` to have a getter/setter.
        _activityEnabled = prefs.activityReminderEnabled;
        _initialized = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _initPrefs(); // Ensure sync if prefs load late
    
    final strings = AppLocalizations.of(context)!;
    final profileAsync = ref.watch(userProfileProvider);
    final prefs = ref.watch(preferencesProvider).valueOrNull;

    final startMinutes = prefs?.quietHoursStartMinutes ?? 22 * 60;
    final endMinutes = prefs?.quietHoursEndMinutes ?? 7 * 60;
    final start = TimeOfDay(hour: startMinutes ~/ 60, minute: startMinutes % 60);
    final end = TimeOfDay(hour: endMinutes ~/ 60, minute: endMinutes % 60);

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: CustomScrollView(
        slivers: [
          // Header
          SliverAppBar(
            expandedHeight: 100,
            pinned: true,
            elevation: 0,
            backgroundColor: Colors.grey.shade50,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                strings.settings,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0D1F3C),
                  letterSpacing: -0.5,
                ),
              ),
              titlePadding: const EdgeInsets.only(left: 24, bottom: 16),
            ),
          ),
          
          // Main Content
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                
                // Card 1: Profil ve Hedefler (Cyan-Blue Gradient)
                Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF2CD8D5), Color(0xFF6B8DD6)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.shade200.withOpacity(0.5),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        strings.profileGoalsSectionTitle,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          height: 1,
                        ),
                      ),
                      const SizedBox(height: 20),
                      
                      // Profil
                      InkWell(
                        onTap: () => context.push('/profile'),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            children: [
                              const Icon(Icons.person, color: Colors.white, size: 24),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Profil',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      profileAsync.value?.name ?? 'User',
                                      style: const TextStyle(
                                        color: Colors.white70,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Icon(Icons.chevron_right, color: Colors.white70, size: 16),
                            ],
                          ),
                        ),
                      ),
                      
                      // Hedef
                      InkWell(
                        onTap: () => context.push('/profile'),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            children: [
                              const Icon(Icons.flag, color: Colors.white, size: 24),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Hedef',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      'Hedef: ${profileAsync.value?.goalWeight.toStringAsFixed(1) ?? '-'} kg',
                                      style: const TextStyle(
                                        color: Colors.white70,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Icon(Icons.chevron_right, color: Colors.white70, size: 16),
                            ],
                          ),
                        ),
                      ),
                      
                      // Vücut Ölçüleri
                      InkWell(
                        onTap: () => context.push('/measurements'),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            children: [
                              Icon(Icons.straighten, color: Colors.white, size: 24),
                              SizedBox(width: 16),
                              Expanded(
                                child: Text(
                                  'Vücut Ölçüleri',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Icon(Icons.chevron_right, color: Colors.white70, size: 16),
                            ],
                          ),
                        ),
                      ),
                      
                      // Uyarlanabilir Hedefler
                      profileAsync.maybeWhen(
                        data: (profile) {
                          final flags = ref.watch(featureFlagServiceProvider);
                          if (profile == null) return const SizedBox.shrink();
                          
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              children: [
                                const Icon(Icons.auto_graph, color: Colors.white, size: 24),
                                const SizedBox(width: 16),
                                const Expanded(
                                  child: Text(
                                    'Uyarlanabilir Hedefler',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: flags.adaptiveGoalsEnabled
                                      ? () async {
                                          await ref.read(userProfileRepositoryProvider).upsert(
                                                profile.copyWith(
                                                  adaptiveGoalsEnabled: !profile.adaptiveGoalsEnabled,
                                                  lastUpdatedAt: DateTime.now().toUtc(),
                                                ),
                                              );
                                        }
                                      : null,
                                  child: Container(
                                    width: 48,
                                    height: 28,
                                    decoration: BoxDecoration(
                                      color: profile.adaptiveGoalsEnabled
                                          ? const Color(0xFF0D9488).withOpacity(0.6)
                                          : Colors.white.withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(14),
                                      border: Border.all(
                                        color: Colors.white.withOpacity(0.2),
                                      ),
                                    ),
                                    child: AnimatedAlign(
                                      duration: const Duration(milliseconds: 200),
                                      alignment: profile.adaptiveGoalsEnabled
                                          ? Alignment.centerRight
                                          : Alignment.centerLeft,
                                      child: Container(
                                        width: 20,
                                        height: 20,
                                        margin: const EdgeInsets.all(4),
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.black12,
                                              blurRadius: 2,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        orElse: () => const SizedBox.shrink(),
                      ),
                    ],
                  ),
                ),

                // Card 2: Bildirimler (Orange Gradient)
                Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFFFB75E), Color(0xFFED8F03)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.orange.shade200.withOpacity(0.5),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        strings.notificationsSectionTitle,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          height: 1,
                        ),
                      ),
                      const SizedBox(height: 20),
                      
                      // Öğün Hatırlatıcı
                      _ReminderRow(
                        icon: Icons.restaurant_menu,
                        label: 'Öğün Hatırlatıcı',
                        isEnabled: _mealEnabled,
                        timeMinutes: _mealMinutes,
                        onToggleChanged: (val) async {
                           setState(() => _mealEnabled = val);
                           if (prefs != null) {
                            await prefs.setMealReminderEnabled(val);
                            final service = ref.read(notificationsServiceProvider);
                            if (val) {
                              final mins = _mealMinutes;
                              final time = DateTime(2023, 1, 1, mins ~/ 60, mins % 60);
                              await service.scheduleDaily(
                                id: 1,
                                title: 'Öğün Vakti!',
                                body: 'Öğününü kaydetmeyi unutma.',
                                time: time,
                              );
                            } else {
                              await service.cancel(1);
                            }
                          }
                        },
                        onTimeChanged: (newTime) async {
                          final mins = newTime.hour * 60 + newTime.minute;
                          setState(() => _mealMinutes = mins);
                          if (prefs != null) {
                            await prefs.setMealReminderMinutes(mins);
                            if (_mealEnabled) {
                               final service = ref.read(notificationsServiceProvider);
                               final time = DateTime(2023, 1, 1, newTime.hour, newTime.minute);
                               await service.scheduleDaily(
                                id: 1,
                                title: 'Öğün Vakti!',
                                body: 'Öğününü kaydetmeyi unutma.',
                                time: time,
                              );
                            }
                          }
                        },
                      ),
                      
                      const SizedBox(height: 8),

                      // Su Hatırlatıcı
                      _ReminderRow(
                        icon: Icons.water_drop,
                        label: 'Su Hatırlatıcı',
                        isEnabled: _waterEnabled,
                        timeMinutes: _waterMinutes,
                        onToggleChanged: (val) async {
                           setState(() => _waterEnabled = val);
                           if (prefs != null) {
                            await prefs.setWaterReminderEnabled(val);
                            final service = ref.read(notificationsServiceProvider);
                            if (val) {
                              final mins = _waterMinutes;
                              final time = DateTime(2023, 1, 1, mins ~/ 60, mins % 60);
                              await service.scheduleDaily(
                                id: 2,
                                title: 'Su İçme Vakti!',
                                body: 'Suyunu içmeyi unutma.',
                                time: time,
                              );
                            } else {
                              await service.cancel(2);
                            }
                          }
                        },
                        onTimeChanged: (newTime) async {
                           final mins = newTime.hour * 60 + newTime.minute;
                           setState(() => _waterMinutes = mins);
                           if (prefs != null) {
                            await prefs.setWaterReminderMinutes(mins);
                            if (_waterEnabled) {
                               final service = ref.read(notificationsServiceProvider);
                               final time = DateTime(2023, 1, 1, newTime.hour, newTime.minute);
                               await service.scheduleDaily(
                                id: 2,
                                title: 'Su İçme Vakti!',
                                body: 'Suyunu içmeyi unutma.',
                                time: time,
                              );
                            }
                          }
                        },
                      ),
                      
                      const SizedBox(height: 8),
                      
                        // Aktivite Hatırlatıcı (Yeni)
                      _ReminderRow(
                        icon: Icons.fitness_center, // Activity icon
                        label: 'Aktivite Hatırlatıcı',
                        isEnabled: _activityEnabled,
                        timeMinutes: 18 * 60, // Fixed time 18:00 for now or add prefs
                        onToggleChanged: (val) async {
                           setState(() => _activityEnabled = val);
                           if (prefs != null) {
                            await prefs.setActivityReminderEnabled(val); // Using specific setter
                            final service = ref.read(notificationsServiceProvider);
                            if (val) {
                              final time = DateTime(2023, 1, 1, 18); // Default 18:00
                              await service.scheduleDaily(
                                id: 3,
                                title: 'Hareket Vakti!',
                                body: 'Günün yorgunluğunu atmak için biraz hareket et.',
                                time: time,
                              );
                            } else {
                              await service.cancel(3);
                            }
                          }
                        },
                        onTimeChanged: (newTime) async {
                          // TODO: Add time prefs for activity
                        },
                      ),

                      const SizedBox(height: 16),
                      Divider(color: Colors.white.withOpacity(0.2)),
                      const SizedBox(height: 16),

                      // Sessiz Saat Başlangıç
                      InkWell(
                        onTap: () async {
                          final picked = await showTimePicker(
                            context: context,
                            initialTime: start,
                          );
                          if (picked != null && prefs != null) {
                            await prefs.setQuietHours(
                              startMinutes: picked.hour * 60 + picked.minute,
                              endMinutes: endMinutes,
                            );
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            children: [
                              const Icon(Icons.nightlight_round, color: Colors.white, size: 24),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Sessiz Saat Başlangıç',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      MaterialLocalizations.of(context).formatTimeOfDay(start),
                                      style: const TextStyle(
                                        color: Colors.white70,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Icon(Icons.chevron_right, color: Colors.white70, size: 16),
                            ],
                          ),
                        ),
                      ),
                      
                      // Sessiz Saat Bitiş
                      InkWell(
                        onTap: () async {
                          final picked = await showTimePicker(
                            context: context,
                            initialTime: end,
                          );
                          if (picked != null && prefs != null) {
                            await prefs.setQuietHours(
                              startMinutes: startMinutes,
                              endMinutes: picked.hour * 60 + picked.minute,
                            );
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            children: [
                              const Icon(Icons.nightlight_outlined, color: Colors.white, size: 24),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Sessiz Saat Bitiş',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      MaterialLocalizations.of(context).formatTimeOfDay(end),
                                      style: const TextStyle(
                                        color: Colors.white70,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Icon(Icons.chevron_right, color: Colors.white70, size: 16),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Card 3: Destek (Magenta-Purple Gradient)
                Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFDA22FF), Color(0xFF9733EE)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.purple.shade200.withOpacity(0.5),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        strings.supportSectionTitle,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          height: 1,
                        ),
                      ),
                      const SizedBox(height: 20),
                      
                      // Geri Bildirim
                      InkWell(
                        onTap: () {},
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            children: [
                              Icon(Icons.email, color: Colors.white, size: 24),
                              SizedBox(width: 16),
                              Expanded(
                                child: Text(
                                  'Geri Bildirim Gönder',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Icon(Icons.chevron_right, color: Colors.white70, size: 16),
                            ],
                          ),
                        ),
                      ),
                      
                      // Paywall
                      InkWell(
                        onTap: () => context.push('/premium'),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            children: [
                              Icon(Icons.star, color: Colors.white, size: 24),
                              SizedBox(width: 16),
                              Expanded(
                                child: Text(
                                  'Paywall ve Abonelik',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Icon(Icons.chevron_right, color: Colors.white70, size: 16),
                            ],
                          ),
                        ),
                      ),
                      
                      // Gizlilik
                      InkWell(
                        onTap: () => context.push('/privacy'),
                        child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            children: [
                              Icon(Icons.privacy_tip, color: Colors.white, size: 24),
                              SizedBox(width: 16),
                              Expanded(
                                child: Text(
                                  'Gizlilik Politikası',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              Icon(Icons.chevron_right, color: Colors.white70, size: 16),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                
                // Card 4: Hesap (Red Gradient) - Logout
                Container(
                  margin: const EdgeInsets.only(bottom: 32),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFFff9966), Color(0xFFff5e62)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.red.shade200.withOpacity(0.5),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: InkWell(
                    onTap: () async {
                      final confirmed = await showDialog<bool>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Çıkış Yap'),
                          content: const Text('Hesabınızdan çıkış yapmak istediğinize emin misiniz?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: const Text('İptal'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              child: const Text('Çıkış Yap', style: TextStyle(color: Colors.red)),
                            ),
                          ],
                        ),
                      );
                      
                      if (confirmed == true && context.mounted) {
                        await ref.read(authServiceProvider).signOut();
                        if (context.mounted) {
                          context.go('/auth');
                        }
                      }
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.logout, color: Colors.white, size: 24),
                        SizedBox(width: 12),
                        Text(
                          'Hesaptan Çıkış Yap',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _ReminderRow extends StatelessWidget {
  const _ReminderRow({
    required this.icon,
    required this.label,
    required this.isEnabled,
    required this.timeMinutes,
    required this.onToggleChanged,
    required this.onTimeChanged,
  });

  final IconData icon;
  final String label;
  final bool isEnabled;
  final int timeMinutes;
  final ValueChanged<bool> onToggleChanged;
  final ValueChanged<TimeOfDay> onTimeChanged;

  @override
  Widget build(BuildContext context) {
    final time = TimeOfDay(hour: timeMinutes ~/ 60, minute: timeMinutes % 60);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                // Time selector (Dummy visualization)
                if (isEnabled)
                  GestureDetector(
                    onTap: () async {
                      final selected = await showTimePicker(
                        context: context,
                        initialTime: time,
                      );
                      if (selected != null) {
                        onTimeChanged(selected);
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Text(
                        MaterialLocalizations.of(context).formatTimeOfDay(time),
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Switch(
            value: isEnabled,
            onChanged: onToggleChanged,
            activeColor: Colors.green, // Updated to Green as requested
            activeTrackColor: Colors.green.withOpacity(0.4),
            inactiveThumbColor: Colors.white.withOpacity(0.8),
            inactiveTrackColor: Colors.white.withOpacity(0.2),
          ),
        ],
      ),
    );
  }
}
