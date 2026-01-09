import 'package:drift/drift.dart';
import 'package:weightvault/data/db/platform_db_stub.dart'
    if (dart.library.io) 'package:weightvault/data/db/platform_db_io.dart'
    if (dart.library.html) 'package:weightvault/data/db/platform_db_web.dart';

Future<QueryExecutor> openConnection({String? encryptionKey}) {
  return createExecutor(encryptionKey: encryptionKey);
}
