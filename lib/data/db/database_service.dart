import 'package:weightvault/data/db/app_database.dart';
class DatabaseService {
  AppDatabase? _database;

  bool get isInitialized => _database != null;

  AppDatabase get db {
    final database = _database;
    if (database == null) {
      throw StateError('Database not initialized');
    }
    return database;
  }

  Future<void> init({String? encryptionKey}) async {
    if (_database != null) {
      return;
    }
    _database = await AppDatabase.open(encryptionKey: encryptionKey);
  }

  Future<void> close() async {
    await _database?.close();
  }
}
