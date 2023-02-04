part of 'logger.dart';

/// Create a message template
///
/// The given template values are inherited by all messages
/// created with this template.
class MessageTemplate {
  /// Create a message template
  ///
  /// The given template values are inherited by all messages
  /// created with this template.
  const MessageTemplate({
    this.tags = const [],
    Object? klasse,
    String? function,
  })  : _classValue = klasse,
        _functionValue = function;

  /// Groups
  final List<String> tags;

  /// Class
  final Object? _classValue;

  /// Function
  final String? _functionValue;

  /// Create a MessageTemplate with the given values
  /// and inherit the template values of the parent template.
  ///
  /// [klasse] and [function] will override the values of the parent template.
  ///
  /// [tags] will be added to the tags of the parent template.
  MessageTemplate child({
    List<String> tags = const [],
    Object? klasse,
    String? function,
  }) {
    return MessageTemplate(
      tags: [...this.tags, ...tags],
      klasse: klasse ?? _classValue,
      function: function ?? _functionValue,
    );
  }

  /// Create a child template with the given [klasse]
  MessageTemplate klasse(Object klasse) => child(klasse: klasse);

  /// Create a child template with the given [function]
  MessageTemplate function(String function) => child(function: function);

  Object? _class(Object? klasse) => klasse ?? _classValue;

  List<String> _tags(List<String>? tags) => [...this.tags, ...tags ?? []];

  String? _function(String? function) => function ?? _functionValue;

  Map<String, String> _templateValues(Map<String, dynamic> templateValues) {
    return templateValues.map((key, value) => MapEntry(key, value.toString()));
  }

  /// Create a log message
  Message log({
    required String title,
    String message = '',
    int level = 0,
    StackTrace? trace,
    bool log = true,
    List<String>? tags,
    Object? klasse,
    String? function,
    Map<String, dynamic> values = const {},
  }) {
    return Message.log(
      title: title,
      text: message,
      level: level,
      stackTrace: trace,
      log: log,
      tags: _tags(tags),
      klasse: _class(klasse),
      function: _function(function),
      templateValues: _templateValues(values),
    );
  }

  /// Create a info message
  Message info({
    required String title,
    String message = '',
    int level = 0,
    StackTrace? trace,
    bool log = true,
    List<String>? tags,
    Object? klasse,
    String? function,
    Map<String, dynamic> values = const {},
  }) {
    return Message.info(
      title: title,
      text: message,
      level: level,
      stackTrace: trace,
      log: log,
      tags: _tags(tags),
      klasse: _class(klasse),
      function: _function(function),
      templateValues: _templateValues(values),
    );
  }

  /// Create a warning message
  Message warn({
    required String title,
    String message = '',
    int level = 0,
    StackTrace? trace,
    bool log = true,
    List<String>? tags,
    Object? klasse,
    String? function,
    Map<String, dynamic> values = const {},
  }) {
    return Message.warning(
      title: title,
      text: message,
      level: level,
      stackTrace: trace,
      log: log,
      tags: _tags(tags),
      klasse: _class(klasse),
      function: _function(function),
      templateValues: _templateValues(values),
    );
  }

  /// Create a error message
  Message error({
    required String title,
    String message = '',
    int level = 0,
    StackTrace? trace,
    bool log = true,
    List<String>? tags,
    Object? klasse,
    String? function,
    Map<String, dynamic> values = const {},
  }) {
    return Message.error(
      title: title,
      text: message,
      level: level,
      stackTrace: trace,
      log: log,
      tags: _tags(tags),
      klasse: _class(klasse),
      function: _function(function),
      templateValues: _templateValues(values),
    );
  }

  /// Create a throwable error message
  ErrorMessage exception({
    required String title,
    String message = '',
    int level = 0,
    StackTrace? trace,
    bool log = true,
    List<String>? tags,
    Object? klasse,
    String? function,
    Map<String, dynamic> values = const {},
  }) {
    return ErrorMessage(
      title,
      text: message,
      level: level,
      stackTrace: trace,
      log: log,
      tags: _tags(tags),
      klasse: _class(klasse),
      function: _function(function),
      templateValues: _templateValues(values),
    );
  }
}
