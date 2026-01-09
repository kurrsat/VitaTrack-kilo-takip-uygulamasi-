import 'package:flutter_secure_storage/flutter_secure_storage.dart';
class SecureStorageService {
  SecureStorageService({FlutterSecureStorage? storage})
      : _storage = storage ?? const FlutterSecureStorage();

  final FlutterSecureStorage _storage;

  static const _encryptionKey = 'db_encryption_key';

  Future<String?> readEncryptionKey() => _storage.read(key: _encryptionKey);

  Future<void> writeEncryptionKey(String key) =>
      _storage.write(key: _encryptionKey, value: key);

  Future<void> deleteEncryptionKey() => _storage.delete(key: _encryptionKey);
}
