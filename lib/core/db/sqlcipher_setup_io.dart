import 'package:flutter/foundation.dart';
import 'package:sqlcipher_flutter_libs/sqlcipher_flutter_libs.dart';
import 'package:sqlite3/open.dart';

Future<void> configureSqlCipherImpl() async {
  if (defaultTargetPlatform != TargetPlatform.android) {
    return;
  }
  open.overrideFor(OperatingSystem.android, openCipherOnAndroid);
  await applyWorkaroundToOpenSqlCipherOnOldAndroidVersions();
}
