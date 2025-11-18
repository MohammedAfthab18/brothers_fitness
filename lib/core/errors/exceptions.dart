import 'package:firebase_core/firebase_core.dart';

/// Base application exception used across services.
class AppException implements Exception {
  const AppException({
    required this.message,
    this.code,
    this.cause,
    this.stackTrace,
  });

  final String message;
  final String? code;
  final Object? cause;
  final StackTrace? stackTrace;

  factory AppException.fromFirebase(
    FirebaseException exception, [
    StackTrace? stackTrace,
  ]) {
    return AppException(
      message: exception.message ?? 'Unexpected Firebase error',
      code: exception.code,
      cause: exception,
      stackTrace: stackTrace ?? exception.stackTrace,
    );
  }

  @override
  String toString() => 'AppException($code): $message';
}
