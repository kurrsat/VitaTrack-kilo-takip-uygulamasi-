import 'package:flutter/widgets.dart';
import 'package:weightvault/core/utils/local_image_stub.dart'
    if (dart.library.io) 'package:weightvault/core/utils/local_image_io.dart'
    if (dart.library.html) 'package:weightvault/core/utils/local_image_web.dart';

Widget buildLocalImage(
  String path, {
  double? width,
  double? height,
  BoxFit? fit,
}) {
  return buildLocalImageImpl(path, width: width, height: height, fit: fit);
}

bool localFileExists(String path) {
  return localFileExistsImpl(path);
}
