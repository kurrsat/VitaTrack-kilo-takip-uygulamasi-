import 'dart:io';

import 'package:flutter/widgets.dart';
Widget buildLocalImageImpl(
  String path, {
  double? width,
  double? height,
  BoxFit? fit,
}) {
  return Image.file(
    File(path),
    width: width,
    height: height,
    fit: fit,
  );
}

bool localFileExistsImpl(String path) {
  return File(path).existsSync();
}
