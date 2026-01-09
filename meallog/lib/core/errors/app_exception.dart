class AppException implements Exception {
  AppException(this.message, {this.code, this.cause});

  final String message;
  final String? code;
  final Object? cause;

  @override
  String toString() {
    if (code == null) {
      return 'AppException($message)';
    }
    return 'AppException($message, code: $code)';
  }
}
