import 'package:meallog/core/errors/app_exception.dart';

sealed class Result<T> {
  const Result();

  R when<R>({required R Function(T data) success, required R Function(AppException error) failure});

  bool get isSuccess => this is Success<T>;
  bool get isFailure => this is Failure<T>;
}

class Success<T> extends Result<T> {
  const Success(this.value);

  final T value;

  @override
  R when<R>({required R Function(T data) success, required R Function(AppException error) failure}) {
    return success(value);
  }
}

class Failure<T> extends Result<T> {
  const Failure(this.error);

  final AppException error;

  @override
  R when<R>({required R Function(T data) success, required R Function(AppException error) failure}) {
    return failure(error);
  }
}
