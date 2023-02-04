part of 'logger.dart';

class ErrorMessage extends Message implements Exception {
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
