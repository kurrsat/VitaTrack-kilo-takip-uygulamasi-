import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions? get currentPlatform {
    if (kIsWeb) {
      return _web;
    }
    if (defaultTargetPlatform == TargetPlatform.android) {
      return _android;
    }
    return null;
  }

  static const FirebaseOptions _android = FirebaseOptions(
    apiKey: 'AIzaSyDZCKZJ2qR9OxEzmlAaMlMFNnhqwqG8880',
    appId: '1:174293706550:android:36e0f6c7e13e5ab7a9f597',
    messagingSenderId: '174293706550',
    projectId: 'kilotakip-e5815',
    storageBucket: 'kilotakip-e5815.firebasestorage.app',
  );

  static FirebaseOptions? get _web {
    final apiKey = dotenv.env['FIREBASE_API_KEY'];
    final appId = dotenv.env['FIREBASE_APP_ID'];
    final messagingSenderId = dotenv.env['FIREBASE_MESSAGING_SENDER_ID'];
    final projectId = dotenv.env['FIREBASE_PROJECT_ID'];
    if (_isMissing(apiKey) ||
        _isMissing(appId) ||
        _isMissing(messagingSenderId) ||
        _isMissing(projectId)) {
      return null;
    }
    return FirebaseOptions(
      apiKey: apiKey!,
      appId: appId!,
      messagingSenderId: messagingSenderId!,
      projectId: projectId!,
      authDomain: dotenv.env['FIREBASE_AUTH_DOMAIN'],
      storageBucket: dotenv.env['FIREBASE_STORAGE_BUCKET'],
      measurementId: dotenv.env['FIREBASE_MEASUREMENT_ID'],
    );
  }

  static bool _isMissing(String? value) => value == null || value.isEmpty;
}
