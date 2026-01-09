import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

class CrashlyticsService {
  CrashlyticsService(this._crashlytics);

  final FirebaseCrashlytics? _crashlytics;

  void recordFlutterError(FlutterErrorDetails details) {
    _crashlytics?.recordFlutterFatalError(details);
  }

  Future<void> log(String message) => _crashlytics?.log(message) ?? Future.value();

  Future<void> recordError(Object error, StackTrace stack) {
    return _crashlytics?.recordError(error, stack) ?? Future.value();
  }
}
