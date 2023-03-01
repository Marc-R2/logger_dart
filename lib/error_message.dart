part of 'logger.dart';

/// Message to throw as an exception
class ErrorMessage extends Message implements Exception {
  /// Creates an error message
  ErrorMessage(String title, {
    super.text,
    super.level,
    super.stackTrace,
    super.log,
    super.klasse,
    super.function,
    super.templateValues,
    List<String>? tags,
  }) : super.error(title: title, tags: [...?tags, 'Exception']);
}
