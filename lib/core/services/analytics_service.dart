import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService {
  AnalyticsService(this._analytics);

  final FirebaseAnalytics? _analytics;

  Future<void> logEvent(String name, {Map<String, Object?>? parameters}) {
    final analytics = _analytics;
    if (analytics == null) {
      return Future.value();
    }
    final cleaned = parameters == null
        ? null
        : Map<String, Object>.fromEntries(
            parameters.entries
                .where((entry) => entry.value != null)
                .map((entry) => MapEntry(entry.key, entry.value!)),
          );
    return analytics.logEvent(name: name, parameters: cleaned);
  }
}
