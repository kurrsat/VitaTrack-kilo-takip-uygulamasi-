import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import 'package:weightvault/core/providers/app_init_provider.dart';
import 'package:weightvault/core/providers/providers.dart';
import 'package:weightvault/core/utils/calorie_goal.dart';
import 'package:weightvault/data/local/seed_food_service.dart';
import 'package:weightvault/data/repositories/repository_providers.dart';
import 'package:weightvault/domain/models/models.dart';
import 'package:weightvault/l10n/app_localizations.dart';

class AuthPage extends ConsumerStatefulWidget {
  const AuthPage({super.key});

  @override
  ConsumerState<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends ConsumerState<AuthPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLogin = true;
  bool _loading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() => _loading = true);
    final authService = ref.read(authServiceProvider);
    try {
      if (_isLogin) {
        await authService.signInEmail(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
      } else {
        await authService.registerEmail(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
      }
      await _ensureNormalMode();
      final needsProfileSetup = await _ensureProfile();
      await ref.read(crashlyticsProvider).log('login');
      if (!mounted) {
        return;
      }
      if (needsProfileSetup) {
        context.go('/profile-setup');
        return;
      }
      context.go('/home/dashboard');
    } catch (e) {
      if (mounted) {
        var message = e.toString();
        // Simple error mapping
        if (message.contains('weak-password')) {
          message = 'Şifre çok zayıf. En az 6 karakter olmalı.';
        } else if (message.contains('email-already-in-use')) {
          message = 'Bu e-posta adresi zaten kullanımda.';
        } else if (message.contains('invalid-email')) {
          message = 'Geçersiz e-posta adresi girdiniz.';
        } else if (message.contains('user-not-found') || message.contains('wrong-password')) {
          message = 'E-posta veya şifre hatalı.';
        } else if (message.contains('network-request-failed')) {
          message = 'İnternet bağlantınızı kontrol edin.';
        } else {
          // Clean up "Exception:" prefix if present
          message = message.replaceAll('Exception:', '').trim();
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  Future<bool> _ensureProfile() async {
    final prefs = await ref.read(preferencesProvider.future);
    final draft = prefs.onboardingGoalDraft;
    final authService = ref.read(authServiceProvider);
    final uid = authService.currentUser?.uid;
    if (uid == null) {
      return false;
    }
    final profileRepo = ref.read(userProfileRepositoryProvider);
    final existing = await profileRepo.getProfile(uid);
    if (existing != null) {
      return false;
    }
    if (!_hasProfileDraft(draft)) {
      return true;
    }
    final goalType = GoalType.values.firstWhere(
      (type) => type.name == (draft['goalType'] as String? ?? 'lose'),
      orElse: () => GoalType.lose,
    );
    final units = UnitsSystem.values.firstWhere(
      (type) => type.name == (draft['units'] as String? ?? 'metric'),
      orElse: () => UnitsSystem.metric,
    );
    final goalDateMillis = draft['goalDate'] as int?;
    final goalDate = goalDateMillis != null
        ? DateTime.fromMillisecondsSinceEpoch(goalDateMillis, isUtc: true)
        : DateTime.now().toUtc().add(const Duration(days: 90));
    final birthYear = draft['birthYear'] as int?;
    final gender = draft['gender'] as String?;
    final height = (draft['heightCm'] as double?) ?? 170;
    final currentWeight = (draft['currentWeight'] as double?) ??
        (draft['goalWeight'] as double?) ??
        70;
    double? dailyGoal;
    if (birthYear != null && gender != null) {
      final age = DateTime.now().year - birthYear;
      if (age > 0) {
        dailyGoal = calculateDailyCalorieGoal(
          service: ref.read(adaptiveGoalServiceProvider),
          weightKg: currentWeight,
          heightCm: height,
          age: age,
          gender: gender,
          activityCalories: 0,
          goalType: goalType,
        );
      }
    }
    final profile = UserProfile(
      uid: uid,
      name: draft['name'] as String? ?? 'User',
      heightCm: height,
      birthYear: birthYear,
      gender: gender,
      units: units,
      goalType: goalType,
      goalWeight: (draft['goalWeight'] as double?) ?? 70,
      goalDate: goalDate,
      tdeeTarget: dailyGoal,
      adaptiveGoalsEnabled: true,
      lastUpdatedAt: DateTime.now().toUtc(),
      createdAt: DateTime.now().toUtc(),
    );
    await profileRepo.upsert(profile);
    if (draft['currentWeight'] != null) {
      await ref.read(weightRepositoryProvider).upsert(
            WeightEntry(
              id: const Uuid().v4(),
              uid: uid,
              dateTime: DateTime.now().toUtc(),
              weightKg: currentWeight,
              lastUpdatedAt: DateTime.now().toUtc(),
            ),
          );
    }
    await SeedFoodService(ref.read(customFoodRepositoryProvider)).ensureSeedFoods(uid);
    return false;
  }

  bool _hasProfileDraft(Map<String, dynamic> draft) {
    final name = draft['name'] as String?;
    final height = draft['heightCm'] as double?;
    final goalWeight = draft['goalWeight'] as double?;
    final currentWeight = draft['currentWeight'] as double?;
    final birthYear = draft['birthYear'] as int?;
    final gender = draft['gender'] as String?;
    if (name == null || name.trim().isEmpty) {
      return false;
    }
    if (height == null || height <= 0) {
      return false;
    }
    if (goalWeight == null || goalWeight <= 0) {
      return false;
    }
    if (currentWeight == null || currentWeight <= 0) {
      return false;
    }
    if (birthYear == null || gender == null || gender.isEmpty) {
      return false;
    }
    return true;
  }

  Future<void> _ensureNormalMode() async {
    final prefs = await ref.read(preferencesProvider.future);
    await prefs.setDemoMode(value: false);
    await prefs.setModeSelected(value: true);
    ref.invalidate(preferencesProvider);
    ref.invalidate(currentUserIdProvider);
    ref.invalidate(appInitProvider);
  }

  Future<void> _forgotPassword() async {
    final authService = ref.read(authServiceProvider);
    await authService.sendPasswordReset(email: _emailController.text.trim());
    if (mounted) {
      final strings = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(strings.passwordResetSent)),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF2CD8D5), // Cyan
              Color(0xFF6B8DD6), // Blue
              Color(0xFF8E37D7), // Purple
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(32),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 30,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Header / Title
                    Text(
                      _isLogin ? strings.login : strings.register,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0D1F3C),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Inputs
                    TextField(
                      controller: _emailController,
                      style: const TextStyle(color: Colors.black87),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: strings.emailLabel,
                        prefixIcon: const Icon(Icons.email_outlined),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade50,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      style: const TextStyle(color: Colors.black87),
                      decoration: InputDecoration(
                        labelText: strings.passwordLabel,
                        prefixIcon: const Icon(Icons.lock_outline),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        filled: true,
                        fillColor: Colors.grey.shade50,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Action Button
                    if (_loading)
                      const Center(child: CircularProgressIndicator())
                    else
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF6B8DD6), Color(0xFF8E37D7)],
                          ),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                             BoxShadow(
                               color: const Color(0xFF8E37D7).withOpacity(0.3),
                               blurRadius: 10,
                               offset: const Offset(0, 4),
                             ),
                          ],
                        ),
                        child: ElevatedButton(
                          onPressed: _submit,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          ),
                          child: Text(
                            _isLogin ? strings.login : strings.register,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    const SizedBox(height: 16),
                    Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         TextButton(
                           onPressed: () => setState(() => _isLogin = !_isLogin),
                           child: Text(_isLogin ? strings.createAccount : strings.haveAccount),
                         ),
                       ],
                    ),
                    
                    TextButton(
                      onPressed: _forgotPassword,
                      child: Text(strings.forgotPassword, style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
                    ),
                    const SizedBox(height: 24),

                    const Divider(),
                    const SizedBox(height: 24),

                    // Social Buttons
                    _SocialButton(
                      label: strings.continueWithGoogle,
                      icon: Icons.g_mobiledata, // Fallback icon
                      color: Colors.red.shade50,
                      textColor: Colors.red.shade700,
                      onPressed: () async {
                        setState(() => _loading = true);
                        try {
                          await ref.read(authServiceProvider).signInGoogle();
                          await _ensureNormalMode();
                          final needsProfileSetup = await _ensureProfile();
                          await ref.read(crashlyticsProvider).log('login_google');
                          if (!context.mounted) {
                            return;
                          }
                          if (needsProfileSetup) {
                            context.go('/profile-setup');
                            return;
                          }
                          context.go('/home/dashboard');
                        } finally {
                          if (mounted) {
                            setState(() => _loading = false);
                          }
                        }
                      },
                    ),
                    const SizedBox(height: 12),
                    _SocialButton(
                      label: strings.continueWithApple,
                      icon: Icons.apple,
                      color: Colors.black.withOpacity(0.05),
                       textColor: Colors.black87,
                      onPressed: () async {
                        setState(() => _loading = true);
                        try {
                          await ref.read(authServiceProvider).signInApple();
                          await _ensureNormalMode();
                          final needsProfileSetup = await _ensureProfile();
                          await ref.read(crashlyticsProvider).log('login_apple');
                          if (!context.mounted) {
                            return;
                          }
                          if (needsProfileSetup) {
                            context.go('/profile-setup');
                            return;
                          }
                          context.go('/home/dashboard');
                        } finally {
                          if (mounted) {
                            setState(() => _loading = false);
                          }
                        }
                      },
                    ),
                      
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  const _SocialButton({
    required this.label,
    required this.icon,
    required this.color,
    required this.textColor,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final Color color;
  final Color textColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: textColor),
            const SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(
                color: textColor,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
