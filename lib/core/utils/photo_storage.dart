import 'package:image_picker/image_picker.dart';
import 'package:weightvault/core/utils/photo_storage_stub.dart'
    if (dart.library.io) 'package:weightvault/core/utils/photo_storage_io.dart'
    if (dart.library.html) 'package:weightvault/core/utils/photo_storage_web.dart';

Future<String> persistPhoto(XFile file, String entryId) {
  return persistPhotoImpl(file, entryId);
}
