import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:water_reminder/app/router.dart';
import 'package:water_reminder/features/onboarding/presentation/onboarding_providers.dart';
import 'package:water_reminder/features/onboarding/presentation/steps/welcome_step.dart';
import 'package:water_reminder/features/onboarding/presentation/steps/profile_step.dart';
import 'package:water_reminder/features/onboarding/presentation/steps/goal_step.dart';
import 'package:water_reminder/features/onboarding/presentation/steps/cups_step.dart';
import 'package:water_reminder/features/onboarding/presentation/steps/notification_step.dart';

/// Main onboarding flow coordinator
class OnboardingPage extends ConsumerWidget {
  const OnboardingPage({super.key});

  static const int totalSteps = 5;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentStep = ref.watch(onboardingStepProvider);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Progress indicator
            if (currentStep > 0) _buildProgressIndicator(currentStep),

            // Current step content
            Expanded(
              child: _buildStep(currentStep, context, ref),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressIndicator(int currentStep) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: List.generate(
          totalSteps,
          (index) => Expanded(
            child: Container(
              height: 4,
              margin: EdgeInsets.only(right: index < totalSteps - 1 ? 8 : 0),
              decoration: BoxDecoration(
                color: index < currentStep ? Colors.blue : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStep(int step, BuildContext context, WidgetRef ref) {
    switch (step) {
      case 0:
        return WelcomeStep(
          onNext: () => ref.read(onboardingStepProvider.notifier).state = 1,
        );
      case 1:
        return ProfileStep(
          onNext: () => ref.read(onboardingStepProvider.notifier).state = 2,
          onBack: () => ref.read(onboardingStepProvider.notifier).state = 0,
        );
      case 2:
        return GoalStep(
          onNext: () => ref.read(onboardingStepProvider.notifier).state = 3,
          onBack: () => ref.read(onboardingStepProvider.notifier).state = 1,
        );
      case 3:
        return CupsStep(
          onNext: () => ref.read(onboardingStepProvider.notifier).state = 4,
          onBack: () => ref.read(onboardingStepProvider.notifier).state = 2,
        );
      case 4:
        return NotificationStep(
          onComplete: () async {
            // Complete onboarding
            await ref
                .read(onboardingProfileProvider.notifier)
                .completeOnboarding();
            ref.invalidate(isFirstRunProvider);
            if (context.mounted) {
              context.go(Routes.home);
            }
          },
          onBack: () => ref.read(onboardingStepProvider.notifier).state = 3,
        );
      default:
        return const Center(child: Text('Bilinmeyen adim'));
    }
  }
}
