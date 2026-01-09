import 'package:uuid/uuid.dart';
import 'package:weightvault/core/services/preferences_service.dart';
import 'package:weightvault/core/services/secure_storage_service.dart';

class DatabaseEncryptionService {
  DatabaseEncryptionService(this._prefs, this._secureStorage);

  final PreferencesService _prefs;
  final SecureStorageService _secureStorage;
  final _uuid = const Uuid();

  Future<String?> getActiveKey() async {
    if (!_prefs.dbEncryptionEnabled) {
      return null;
    }
    return _secureStorage.readEncryptionKey();
  }

  Future<String> enable() async {
    final key = _uuid.v4();
    await _secureStorage.writeEncryptionKey(key);
    await _prefs.setDbEncryptionEnabled(value: true);
    return key;
  }

  Future<void> disable() async {
    await _secureStorage.deleteEncryptionKey();
    await _prefs.setDbEncryptionEnabled(value: false);
  }
}
