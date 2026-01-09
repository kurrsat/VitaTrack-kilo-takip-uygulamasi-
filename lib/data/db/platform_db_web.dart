// ignore_for_file: deprecated_member_use

import 'package:drift/drift.dart';
import 'package:drift/web.dart';

Future<QueryExecutor> createExecutor({String? encryptionKey}) async {
  return WebDatabase('weightvault');
}
