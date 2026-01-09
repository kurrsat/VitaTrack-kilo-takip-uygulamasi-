import 'package:image_picker/image_picker.dart';

Future<String> persistPhotoImpl(XFile file, String entryId) async {
  return file.path;
}
