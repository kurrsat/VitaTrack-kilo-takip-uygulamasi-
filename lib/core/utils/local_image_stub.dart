import 'package:flutter/widgets.dart';
Widget buildLocalImageImpl(
  String path, {
  double? width,
  double? height,
  BoxFit? fit,
}) {
  return const SizedBox.shrink();
}

bool localFileExistsImpl(String path) {
  return false;
}
