/// A Result type for handling success and failure cases
///
/// Inspired by functional programming patterns
sealed class Result<T> {
  const Result();
}

/// Success case containing a value
final class Success<T> extends Result<T> {
  const Success(this.value);
  final T value;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Success<T> &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'Success($value)';
}

/// Failure case containing an error
final class Failure<T> extends Result<T> {
  const Failure(this.error, [this.stackTrace]);
  final Object error;
  final StackTrace? stackTrace;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Failure<T> &&
          runtimeType == other.runtimeType &&
          error == other.error;

  @override
  int get hashCode => error.hashCode;

  @override
  String toString() => 'Failure($error)';
}

/// Extension methods for Result
extension ResultExtensions<T> on Result<T> {
  /// Returns true if this is a Success
  bool get isSuccess => this is Success<T>;

  /// Returns true if this is a Failure
  bool get isFailure => this is Failure<T>;

  /// Returns the value if Success, null otherwise
  T? get valueOrNull => switch (this) {
        Success(value: final v) => v,
        Failure() => null,
      };

  /// Returns the value if Success, throws otherwise
  T get value => switch (this) {
        Success(value: final v) => v,
        Failure() => throw StateError('Called value on Failure'),
      };

  /// Returns the error if Failure, null otherwise
  Object? get errorOrNull => switch (this) {
        Success() => null,
        Failure(error: final e) => e,
      };

  /// Returns the error if Failure, throws otherwise
  Object get error => switch (this) {
        Success() => throw StateError('Called error on Success'),
        Failure(error: final e) => e,
      };

  /// Maps the value if Success
  Result<R> map<R>(R Function(T value) mapper) => switch (this) {
        Success(value: final v) => Success(mapper(v)),
        Failure(error: final e, stackTrace: final s) => Failure(e, s),
      };

  /// Flat maps the value if Success
  Result<R> flatMap<R>(Result<R> Function(T value) mapper) => switch (this) {
        Success(value: final v) => mapper(v),
        Failure(error: final e, stackTrace: final s) => Failure(e, s),
      };

  /// Executes a function based on the result
  R when<R>({
    required R Function(T value) success,
    required R Function(Object error, StackTrace? stackTrace) failure,
  }) =>
      switch (this) {
        Success(value: final v) => success(v),
        Failure(error: final e, stackTrace: final s) => failure(e, s),
      };
}
