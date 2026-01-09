import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
class StorageService {
  StorageService(this._storage);

  final FirebaseStorage _storage;

  FirebaseStorage get storage => _storage;

  Future<String> uploadPhoto({
    required XFile file,
    required String uid,
    required String entryId,
  }) async {
    final ref = _storage.ref('users/$uid/photos/$entryId.jpg');
    final bytes = await file.readAsBytes();
    final task = await ref.putData(
      bytes,
      SettableMetadata(contentType: 'image/jpeg'),
    );
    if (task.state != TaskState.success) {
      throw StateError('Photo upload failed');
    }
    return ref.getDownloadURL();
  }

  Future<void> deleteByUrl(String url) async {
    final ref = _storage.refFromURL(url);
    await ref.delete();
  }
}
