import 'package:health/health.dart';
class HealthService {
  HealthService({Health? health}) : _health = health ?? Health();

  final Health _health;

  Future<bool> requestPermissions() async {
    final types = [HealthDataType.STEPS, HealthDataType.WEIGHT];
    final permissions = [HealthDataAccess.READ, HealthDataAccess.READ];
    return _health.requestAuthorization(types, permissions: permissions);
  }

  Future<int> fetchTodaySteps() async {
    final now = DateTime.now();
    final midnight = DateTime(now.year, now.month, now.day);
    final steps = await _health.getTotalStepsInInterval(midnight, now);
    return steps ?? 0;
  }
}
