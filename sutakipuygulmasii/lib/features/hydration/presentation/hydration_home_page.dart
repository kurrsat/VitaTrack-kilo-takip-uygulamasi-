import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:water_reminder/app/exit_handler.dart';
import 'package:water_reminder/features/hydration/domain/beverage_type.dart';
import 'package:water_reminder/features/hydration/domain/quick_add_defaults.dart';
import 'package:water_reminder/features/hydration/presentation/hydration_providers.dart';
import 'package:water_reminder/features/hydration/presentation/widgets/add_water_bottom_sheet.dart';
import 'package:water_reminder/features/hydration/presentation/widgets/progress_ring.dart';
import 'package:water_reminder/features/onboarding/presentation/onboarding_providers.dart';

/// Main hydration tracking page with progress ring and quick actions
class HydrationHomePage extends ConsumerWidget {
  const HydrationHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todayTotalAsync = ref.watch(todayTotalProvider);
    final goalProgressAsync = ref.watch(goalProgressProvider);
    final remainingAsync = ref.watch(remainingMlProvider);
    final profileAsync = ref.watch(userProfileProvider);
    final lastUsedAsync = ref.watch(lastUsedAmountProvider);
    final quickAddDefaultsAsync = ref.watch(quickAddDefaultsProvider);
    final theme = Theme.of(context);

    final quickAddDefaults =
        quickAddDefaultsAsync.value ?? QuickAddDefaults.standard;
    final defaultWaterAmount = quickAddDefaults.waterMl;

    final quickAddItems = [
      _QuickAddItem(
        label: 'Su',
        amountMl: quickAddDefaults.waterMl,
        beverageType: BeverageType.water,
        icon: Icons.water_drop,
        color: BeverageType.water.color,
      ),
      _QuickAddItem(
        label: 'Cay',
        amountMl: quickAddDefaults.teaMl,
        beverageType: BeverageType.blackTea,
        icon: Icons.emoji_food_beverage,
        color: BeverageType.blackTea.color,
      ),
      _QuickAddItem(
        label: 'Kahve',
        amountMl: quickAddDefaults.coffeeMl,
        beverageType: BeverageType.coffee,
        icon: Icons.local_cafe,
        color: BeverageType.coffee.color,
      ),
    ];

    Future<void> addWithUndo(_QuickAddItem item) async {
      final log = await addWater(
        ref,
        item.amountMl,
        beverageType: item.beverageType,
      );
      if (!context.mounted) return;
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(
          SnackBar(
            content: Text('${item.amountMl} ml ${item.label} eklendi'),
            duration: const Duration(seconds: 5),
            backgroundColor: item.color.withOpacity(0.9),
            action: SnackBarAction(
              label: 'Geri al',
              onPressed: () async {
                await deleteLogById(ref, log.id);
              },
            ),
          ),
        );
    }

    void showAddBottomSheet() {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        builder: (context) => const AddWaterBottomSheet(),
      );
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        leading: const WaterBackButton(),
        title: const Text('Bugun'),
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              // TODO: Navigate to logs page
            },
            tooltip: 'Gecmis',
          ),
        ],
      ),
      body: Stack(
        children: [
          const _HomeBackground(),
          SafeArea(
            child: todayTotalAsync.when(
              data: (total) {
                final progress = goalProgressAsync.value ?? 0.0;
                final remaining = remainingAsync.value ?? 0;
                final goal = profileAsync.value?.effectiveDailyGoal ?? 2000;

                return SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 120),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      Text(
                        'Su icmeyi unutma',
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Gunluk hedefini takip et ve duzenli kal',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 20),
                      _GlassCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const _SectionHeader(
                              title: 'Hizli ekle',
                              subtitle: 'Tek dokunusla kaydet',
                            ),
                            const SizedBox(height: 12),
                            LayoutBuilder(
                              builder: (context, constraints) {
                                final itemWidth =
                                    (constraints.maxWidth - 24) / 3;
                                return Wrap(
                                  spacing: 12,
                                  runSpacing: 12,
                                  children: [
                                    for (final item in quickAddItems)
                                      SizedBox(
                                        width: itemWidth,
                                        child: _QuickAddButton(
                                          item: item,
                                          onTap: () => addWithUndo(item),
                                        ),
                                      ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      _GlassCard(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const _SectionHeader(
                                    title: 'Bugun ilerleme',
                                    subtitle: 'Su hedefin',
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    '$total ml',
                                    style: theme.textTheme.headlineMedium
                                        ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Hedef $goal ml',
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: Colors.white70,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  _ProgressStatusChip(
                                    progress: progress,
                                    remaining: remaining,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            ProgressRing(
                              progress: progress,
                              size: 140,
                              backgroundColor: Colors.white.withOpacity(0.2),
                              progressColor: Colors.white,
                              completeColor: const Color(0xFF5CE7C6),
                              textColor: Colors.white,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      _StatsGrid(
                        total: total,
                        goal: goal,
                        remaining: remaining,
                      ),
                      const SizedBox(height: 16),
                      lastUsedAsync.when(
                        data: (lastAmount) {
                          if (lastAmount == null ||
                              lastAmount == defaultWaterAmount) {
                            return const SizedBox.shrink();
                          }
                          return _GlassCard(
                            padding: const EdgeInsets.all(6),
                            child: OutlinedButton.icon(
                              onPressed: () async {
                                await addWithUndo(
                                  _QuickAddItem(
                                    label: 'Su',
                                    amountMl: lastAmount,
                                    beverageType: BeverageType.water,
                                    icon: Icons.water_drop,
                                    color: BeverageType.water.color,
                                  ),
                                );
                              },
                              icon: const Icon(Icons.refresh),
                              label: Text('Son kullanilan: $lastAmount ml'),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.white,
                                side: const BorderSide(color: Colors.white30),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 12,
                                ),
                              ),
                            ),
                          );
                        },
                        loading: () => const SizedBox.shrink(),
                        error: (_, __) => const SizedBox.shrink(),
                      ),
                    ],
                  ),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, _) => Center(
                child: Text('Hata: $error'),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: showAddBottomSheet,
        icon: const Icon(Icons.add),
        label: const Text('Ekle'),
        tooltip: 'Ozel miktar ekle',
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF0B4DB8),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class _HomeBackground extends StatelessWidget {
  const _HomeBackground();

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF0B4DB8),
                Color(0xFF1A7FE8),
              ],
            ),
          ),
        ),
        Positioned(
          top: -60,
          right: -40,
          child: _GlowOrb(
            size: 180,
            color: Colors.white.withOpacity(0.08),
          ),
        ),
        Positioned(
          top: 220,
          left: -50,
          child: _GlowOrb(
            size: 140,
            color: Colors.white.withOpacity(0.06),
          ),
        ),
        Positioned(
          bottom: -40,
          right: -20,
          child: _GlowOrb(
            size: 160,
            color: Colors.white.withOpacity(0.05),
          ),
        ),
      ],
    );
  }
}

class _GlowOrb extends StatelessWidget {
  const _GlowOrb({
    required this.size,
    required this.color,
  });

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

class _GlassCard extends StatelessWidget {
  const _GlassCard({
    required this.child,
    this.padding = const EdgeInsets.all(16),
  });

  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white24,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: padding,
        child: child,
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.title,
    this.subtitle,
  });

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 4),
          Text(
            subtitle!,
            style: theme.textTheme.bodySmall?.copyWith(
              color: Colors.white70,
            ),
          ),
        ],
      ],
    );
  }
}

class _ProgressStatusChip extends StatelessWidget {
  const _ProgressStatusChip({
    required this.progress,
    required this.remaining,
  });

  final double progress;
  final int remaining;

  @override
  Widget build(BuildContext context) {
    final label = progress >= 1.0
        ? 'Hedef tamam'
        : 'Kalan $remaining ml';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.16),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white24),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}

class _StatsGrid extends StatelessWidget {
  const _StatsGrid({
    required this.total,
    required this.goal,
    required this.remaining,
  });

  final int total;
  final int goal;
  final int remaining;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final halfWidth = (constraints.maxWidth - 12) / 2;
        return Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            SizedBox(
              width: halfWidth,
              child: _StatTile(
                title: 'Bugun',
                value: '$total ml',
                icon: Icons.water_drop,
              ),
            ),
            SizedBox(
              width: halfWidth,
              child: _StatTile(
                title: 'Hedef',
                value: '$goal ml',
                icon: Icons.flag,
              ),
            ),
            SizedBox(
              width: constraints.maxWidth,
              child: _StatTile(
                title: 'Kalan',
                value: '$remaining ml',
                icon: Icons.timelapse,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({
    required this.title,
    required this.value,
    required this.icon,
  });

  final String title;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return _GlassCard(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.16),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 18, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _QuickAddItem {
  const _QuickAddItem({
    required this.label,
    required this.amountMl,
    required this.beverageType,
    required this.icon,
    required this.color,
  });

  final String label;
  final int amountMl;
  final BeverageType beverageType;
  final IconData icon;
  final Color color;
}

class _QuickAddButton extends StatelessWidget {
  const _QuickAddButton({
    required this.item,
    required this.onTap,
  });

  final _QuickAddItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final background = item.color.withOpacity(0.22);
    final border = item.color.withOpacity(0.45);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Ink(
          height: 92,
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: border),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.18),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  item.icon,
                  size: 18,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                item.label,
                style: theme.textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.16),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  '${item.amountMl} ml',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: Colors.white70,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
