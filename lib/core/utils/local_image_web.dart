import 'package:flutter/widgets.dart';
Widget buildLocalImageImpl(
  String path, {
  double? width,
  double? height,
  BoxFit? fit,
}) {
  return Image.network(
    path,
    width: width,
    height: height,
    fit: fit,
  );
}

bool localFileExistsImpl(String path) {
  return true;
}
