import 'package:weightvault/core/db/sqlcipher_setup_stub.dart'
    if (dart.library.io) 'package:weightvault/core/db/sqlcipher_setup_io.dart'
    if (dart.library.html) 'package:weightvault/core/db/sqlcipher_setup_stub.dart';

Future<void> configureSqlCipher() => configureSqlCipherImpl();
