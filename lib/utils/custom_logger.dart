import 'package:logger/logger.dart';

class CustomLogger {
  CustomLogger._();

  static Logger? _loggerInstance;

  static Logger get _instance {
    _loggerInstance ??= Logger();
    return _loggerInstance!;
  }

  static void i(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _instance.i(message, error: error, time: time, stackTrace: stackTrace);
  }

  static void d(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _instance.d(message, error: error, time: time, stackTrace: stackTrace);
  }

  static void e(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _instance.e(message, error: error, time: time, stackTrace: stackTrace);
  }
}
