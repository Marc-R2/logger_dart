part of 'logger.dart';

/// Message to throw as an exception
class ErrorMessage extends Message implements Exception {
  /// Creates an error message
  ErrorMessage(
    String title, {
    super.text,
    super.level,
    super.stackTrace,
    super.log,
    super.sourceClass,
    super.sourceFunction,
    super.templateValues,
    List<String>? tags,
    super.runtimeId,
    super.sessionId,
    super.logId,
    super.parentLogId,
  }) : super.error(title: title, tags: [...?tags, 'Exception']);
}
