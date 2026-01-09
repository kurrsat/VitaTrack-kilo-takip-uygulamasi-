import 'package:flutter_dotenv/flutter_dotenv.dart';
class Env {
  static String? get revenueCatApiKey => dotenv.env['REVENUECAT_API_KEY'];
  static String? get openFoodFactsBaseUrl =>
      dotenv.env['OPENFOODFACTS_BASE_URL'] ?? 'https://world.openfoodfacts.org';
  static String? get usdaApiKey => dotenv.env['USDA_API_KEY'];
  static String? get feedbackEmail => dotenv.env['FEEDBACK_EMAIL'] ?? 'support@weightvault.app';
  static String? get firebaseEmulatorHost => dotenv.env['FIREBASE_EMULATOR_HOST'];
  static int get firebaseAuthEmulatorPort =>
      int.tryParse(dotenv.env['FIREBASE_AUTH_EMULATOR_PORT'] ?? '') ?? 9099;
  static int get firebaseFirestoreEmulatorPort =>
      int.tryParse(dotenv.env['FIREBASE_FIRESTORE_EMULATOR_PORT'] ?? '') ?? 8080;
  static int get firebaseStorageEmulatorPort =>
      int.tryParse(dotenv.env['FIREBASE_STORAGE_EMULATOR_PORT'] ?? '') ?? 9199;
}
