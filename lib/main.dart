import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_widget/home_widget.dart';
import 'package:weightvault/app/app.dart';
import 'package:weightvault/core/constants/app_constants.dart';
import 'package:weightvault/core/db/sqlcipher_setup.dart';
import 'package:weightvault/core/services/messaging_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await configureSqlCipher();
  if (!kIsWeb && defaultTargetPlatform == TargetPlatform.iOS) {
    await HomeWidget.setAppGroupId(AppConstants.appGroupId);
  }
  if (!kIsWeb) {
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }
  runApp(const ProviderScope(child: WeightVaultApp()));
}
