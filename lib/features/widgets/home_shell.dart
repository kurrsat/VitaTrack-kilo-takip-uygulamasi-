import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:weightvault/core/providers/app_init_provider.dart';
import 'package:weightvault/core/providers/providers.dart';
import 'package:weightvault/core/utils/calorie_goal.dart';
import 'package:weightvault/data/repositories/repository_providers.dart';
import 'package:weightvault/features/activity/add_activity_dialog.dart';
import 'package:weightvault/features/nutrition/add_food_dialog.dart';
import 'package:weightvault/l10n/app_localizations.dart';

class HomeShell extends ConsumerStatefulWidget {
  const HomeShell({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  ConsumerState<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends ConsumerState<HomeShell> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkDailyReset();
    });
  }

  Future<void> _checkDailyReset() async {
    final uid = ref.read(currentUserIdProvider);
    if (uid == null) return;

    final profileRepo = ref.read(userProfileRepositoryProvider);
    final profile = await profileRepo.getProfile(uid);
    if (profile == null) return;

    final now = DateTime.now();
    final todayStart = DateTime(now.year, now.month, now.day);
    
    // If profile was updated before today, reset the goal to base (0 activity)
    if (profile.lastUpdatedAt.isBefore(todayStart)) {
      final weightRepo = ref.read(weightRepositoryProvider);
      // Repository doesn't expose getLatest directly, so we use watch and sort
      final entries = await weightRepo.watchEntries(uid).first;
      final latestWeight = entries.isEmpty ? null : entries.last;
      
      // Fallback to profile goal weight if no weight entry (rare but possible) or 70kg default
      final weight = latestWeight?.weightKg ?? 70.0;

      final service = ref.read(adaptiveGoalServiceProvider);
      
      final newGoal = calculateDailyCalorieGoal(
        service: service,
        weightKg: weight,
        heightCm: profile.heightCm,
        age: now.year - (profile.birthYear ?? 1990),
        gender: profile.gender ?? 'male',
        activityCalories: 0, // Reset to 0 activity
        goalType: profile.goalType,
      );

      final updatedProfile = profile.copyWith(
        tdeeTarget: newGoal,
        lastUpdatedAt: now,
      );

      await profileRepo.upsert(updatedProfile);
      debugPrint('Daily Goal Reset to $newGoal');
    }
  }

  void _onTap(int index) {
    widget.navigationShell.goBranch(index, initialLocation: index == widget.navigationShell.currentIndex);
  }

  void _openAddSheet(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return Container(
          decoration: const BoxDecoration(
            color: Color(0xFFFFFBF0),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(35),
              topRight: Radius.circular(35),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 30,
                offset: Offset(0, -5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16),
              Container(
                width: 48,
                height: 6,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              const SizedBox(height: 32),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    _AddMenuButton(
                      label: strings.addWater,
                      icon: Icons.water_drop,
                      gradient: const LinearGradient(
                        colors: [Color(0xFF00c6ff), Color(0xFF0072ff)],
                      ),
                      onTap: () {
                        Navigator.of(sheetContext).pop();
                        context.push('/quick-add-water');
                      },
                    ),
                    const SizedBox(height: 16),
                    _AddMenuButton(
                      label: 'Öğün Ekle',
                      icon: Icons.restaurant,
                      gradient: const LinearGradient(
                        colors: [Color(0xFFff512f), Color(0xFFf09819)],
                      ),
                      onTap: () {
                        Navigator.of(sheetContext).pop();
                        showDialog<void>(
                          context: context,
                          builder: (_) => const AddFoodDialog(),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    _AddMenuButton(
                      label: 'Aktivite Ekle',
                      icon: Icons.fitness_center,
                      gradient: const LinearGradient(
                        colors: [Color(0xFFEF4444), Color(0xFFDC2626)],
                      ),
                      onTap: () {
                        Navigator.of(sheetContext).pop();
                        showDialog<void>(
                          context: context,
                          builder: (_) => const AddActivityDialog(),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    _AddMenuButton(
                      label: 'Fotoğraf Ekle',
                      icon: Icons.camera_alt,
                      gradient: const LinearGradient(
                        colors: [Color(0xFFec008c), Color(0xFFfc6767)],
                      ),
                      onTap: () {
                        Navigator.of(sheetContext).pop();
                        widget.navigationShell.goBranch(3);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 48),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    return Scaffold(
      body: widget.navigationShell,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openAddSheet(context),
        backgroundColor: const Color(0xFF22d3ee),
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: const Icon(Icons.add, size: 32, color: Colors.black),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: widget.navigationShell.currentIndex,
        onDestinationSelected: _onTap,
        backgroundColor: Colors.white,
        indicatorColor: Colors.transparent,
        destinations: [
          NavigationDestination(
            icon: _NavIcon(icon: Icons.home, isSelected: widget.navigationShell.currentIndex == 0, color: Colors.blue),
            label: strings.dashboard,
          ),
          NavigationDestination(
            icon: _NavIcon(icon: Icons.list_alt, isSelected: widget.navigationShell.currentIndex == 1, color: Colors.orange),
            label: strings.log,
          ),
          NavigationDestination(
            icon: _NavIcon(icon: Icons.bar_chart, isSelected: widget.navigationShell.currentIndex == 2, color: Colors.purple),
            label: strings.reportsTitle,
          ),
          NavigationDestination(
            icon: _NavIcon(icon: Icons.photo_camera_back, isSelected: widget.navigationShell.currentIndex == 3, color: Colors.green),
            label: strings.photos,
          ),
          NavigationDestination(
            icon: _NavIcon(icon: Icons.settings, isSelected: widget.navigationShell.currentIndex == 4, color: Colors.grey),
            label: strings.settings,
          ),
        ],
      ),
    );
  }
}

class _NavIcon extends StatelessWidget {
  const _NavIcon({required this.icon, required this.isSelected, required this.color});
  final IconData icon;
  final bool isSelected;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      color: isSelected ? color : Colors.grey.shade400,
    );
  }
}

class _AddMenuButton extends StatelessWidget {
  const _AddMenuButton({
    required this.label,
    required this.icon,
    required this.gradient,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final Gradient gradient;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(50), // Fully rounded
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 15,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
            Icon(
              icon,
              color: Colors.white,
              size: 28,
            ),
          ],
        ),
      ),
    );
  }
}
