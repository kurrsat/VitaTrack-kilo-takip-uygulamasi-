import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:weightvault/core/services/notifications_service.dart';
import 'package:weightvault/firebase_options.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (Firebase.apps.isNotEmpty) {
    return;
  }
  final options = DefaultFirebaseOptions.currentPlatform;
  if (options != null) {
    await Firebase.initializeApp(options: options);
  } else if (!kIsWeb) {
    await Firebase.initializeApp();
  }
}

class MessagingService {
  MessagingService(this._messaging, this._notificationsService);

  final FirebaseMessaging _messaging;
  final NotificationsService _notificationsService;

  Future<void> init() async {
    if (kIsWeb) {
      return;
    }
    await _messaging.requestPermission();
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification != null) {
        _notificationsService.showNotification(
          title: notification.title ?? 'WeightVault',
          body: notification.body ?? '',
        );
      }
    });
  }
}
