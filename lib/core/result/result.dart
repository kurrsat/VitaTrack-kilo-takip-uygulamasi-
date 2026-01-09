sealed class Result<T> {
  const Result();

  bool get isSuccess => this is Success<T>;
  bool get isFailure => this is Failure<T>;

  T? get data => this is Success<T> ? (this as Success<T>).data : null;
  AppError? get error => this is Failure<T> ? (this as Failure<T>).error : null;
}

class Success<T> extends Result<T> {
  const Success(this.data);
  @override
  final T data;
}

class Failure<T> extends Result<T> {
  const Failure(this.error);
  @override
  final AppError error;
}

class AppError {
  const AppError(this.message, {this.code, this.cause});

  final String message;
  final String? code;
  final Object? cause;
}
