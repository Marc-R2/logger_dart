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
    String? runtimeSession,
    String? sessionId,
  })  : _classValue = klasse,
        _functionValue = function,
        _runtimeId = runtimeSession,
        _sessionId = sessionId;

  /// Groups
  final List<String> tags;

  /// Class
  final Object? _classValue;

  /// Function
  final String? _functionValue;

  /// Runtime session
  final String? _runtimeId;

  final String? _sessionId;

  String? get runtimeId => _runtimeId;

  String? get sessionId => _sessionId;

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
      runtimeSession: _runtimeId,
    );
  }

  /// Create a child template with the given [klasse]
  MessageTemplate klasse(Object klasse) => child(klasse: klasse);

  /// Create a child template with the given [function]
  MessageTemplate function(String function) => child(function: function);

  Object? _class(Object? klasse) => klasse ?? _classValue;

  List<String> _tags(List<String>? tags) => [...this.tags, ...tags ?? []];

  String? _function(String? function) => function ?? _functionValue;

  String? _runtime(String? runtime) => runtime ?? _runtimeId;

  String? _session(String? session) => session ?? _sessionId;

  Map<String, String> _templateValues(Map<String, dynamic> templateValues) {
    return templateValues.map((key, value) => MapEntry(key, value.toString()));
  }

  int? _getLogId() {
    if (this is! Log) return null;
    return (this as Log).createId();
  }

  int? _getParentLogId() {
    if (this is! Log) return null;
    return (this as Log).getLastMessage()?.logId;
  }

  Message _addMessage(Message message) {
    if (this is! Log) return message;
    (this as Log).messages.add(message);
    return message;
  }

  /// Create a trace message
  Message trace({
    required String title,
    String message = '',
    int level = 0,
    StackTrace? trace,
    bool log = true,
    List<String>? tags,
    Object? klasse,
    String? function,
    Map<String, dynamic> values = const {},
    String? runtimeSession,
    String? sessionId,
  }) {
    final msg = Message.trace(
      title: title,
      text: message,
      level: level,
      stackTrace: trace,
      log: log,
      tags: _tags(tags),
      klasse: _class(klasse),
      sourceFunction: _function(function),
      templateValues: _templateValues(values),
      runtimeSession: _runtime(runtimeSession),
      sessionId: _session(sessionId),
      logId: _getLogId(),
      parentLogId: _getParentLogId(),
    );
    return _addMessage(msg);
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
    String? runtimeSession,
    String? sessionId,
  }) {
    final msg = Message.log(
      title: title,
      text: message,
      level: level,
      stackTrace: trace,
      log: log,
      tags: _tags(tags),
      klasse: _class(klasse),
      sourceFunction: _function(function),
      templateValues: _templateValues(values),
      runtimeSession: _runtime(runtimeSession),
      sessionId: _session(sessionId),
      logId: _getLogId(),
      parentLogId: _getParentLogId(),
    );
    return _addMessage(msg);
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
    String? runtimeSession,
    String? sessionId,
  }) {
    final msg = Message.info(
      title: title,
      text: message,
      level: level,
      stackTrace: trace,
      log: log,
      tags: _tags(tags),
      klasse: _class(klasse),
      sourceFunction: _function(function),
      templateValues: _templateValues(values),
      runtimeSession: _runtime(runtimeSession),
      sessionId: _session(sessionId),
      logId: _getLogId(),
      parentLogId: _getParentLogId(),
    );
    return _addMessage(msg);
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
    String? runtimeSession,
    String? sessionId,
  }) {
    final msg = Message.warning(
      title: title,
      text: message,
      level: level,
      stackTrace: trace,
      log: log,
      tags: _tags(tags),
      klasse: _class(klasse),
      sourceFunction: _function(function),
      templateValues: _templateValues(values),
      runtimeSession: _runtime(runtimeSession),
      sessionId: _session(sessionId),
      logId: _getLogId(),
      parentLogId: _getParentLogId(),
    );
    return _addMessage(msg);
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
    String? runtimeId,
    String? sessionId,
  }) {
    final msg = Message.error(
      title: title,
      text: message,
      level: level,
      stackTrace: trace,
      log: log,
      tags: _tags(tags),
      sourceClass: _class(klasse),
      sourceFunction: _function(function),
      templateValues: _templateValues(values),
      runtimeId: _runtime(runtimeId),
      sessionId: _session(sessionId),
      logId: _getLogId(),
      parentLogId: _getParentLogId(),
    );
    return _addMessage(msg);
  }

  /// Create a throwable error message
  ErrorMessage exception({
    required String title,
    String message = '',
    int level = 0,
    StackTrace? trace,
    bool log = true,
    List<String>? tags,
    Object? sourceClass,
    String? sourceFunction,
    Map<String, dynamic> values = const {},
    String? runtimeSession,
    String? sessionId,
  }) {
    final msg = ErrorMessage(
      title,
      text: message,
      level: level,
      stackTrace: trace,
      log: log,
      tags: _tags(tags),
      sourceClass: _class(sourceClass),
      sourceFunction: _function(sourceFunction),
      templateValues: _templateValues(values),
      runtimeId: _runtime(runtimeSession),
      sessionId: _session(sessionId),
      logId: _getLogId(),
      parentLogId: _getParentLogId(),
    );
    _addMessage(msg);
    return msg;
  }
}
