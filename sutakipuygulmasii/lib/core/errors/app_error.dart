import 'package:equatable/equatable.dart';

/// Base class for all application errors
abstract class AppError extends Equatable {
  const AppError(this.message, [this.stackTrace]);

  final String message;
  final StackTrace? stackTrace;

  @override
  List<Object?> get props => [message];

  @override
  String toString() => '$runtimeType: $message';
}

/// Network related errors
class NetworkError extends AppError {
  const NetworkError(super.message, [super.stackTrace]);
}

/// Database related errors
class DatabaseError extends AppError {
  const DatabaseError(super.message, [super.stackTrace]);
}

/// Validation errors
class ValidationError extends AppError {
  const ValidationError(super.message, [super.stackTrace]);
}

/// Permission errors
class PermissionError extends AppError {
  const PermissionError(super.message, [super.stackTrace]);
}

/// Not found errors
class NotFoundError extends AppError {
  const NotFoundError(super.message, [super.stackTrace]);
}

/// Unexpected errors
class UnexpectedError extends AppError {
  const UnexpectedError(super.message, [super.stackTrace]);
}
