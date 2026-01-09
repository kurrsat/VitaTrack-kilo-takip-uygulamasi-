// ignore_for_file: avoid_slow_async_io

import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

Future<String> persistPhotoImpl(XFile file, String entryId) async {
  final directory = await getApplicationDocumentsDirectory();
  final photosDir = Directory(p.join(directory.path, 'photos'));
  if (!await photosDir.exists()) {
    await photosDir.create(recursive: true);
  }
  final extension = p.extension(file.path);
  final safeExtension = extension.isEmpty ? '.jpg' : extension;
  final destination = p.join(photosDir.path, '$entryId$safeExtension');
  await file.saveTo(destination);
  return destination;
}
