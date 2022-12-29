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
    this.klasse,
    this.function,
  });

  /// Groups
  final List<String> tags;

  /// Class
  final Object? klasse;

  /// Function
  final String? function;

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
      klasse: klasse ?? this.klasse,
      function: function ?? this.function,
    );
  }

  Object? _class(Object? klasse) => klasse ?? this.klasse;

  List<String> _tags(List<String>? tags) => [...this.tags, ...tags ?? []];

  String? _function(String? function) => function ?? this.function;

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
}
