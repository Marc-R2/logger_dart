part of 'logger.dart';

// TODO(me): const constructors for better performance

extension on Object {
  /// Returns the name of the class
  String get className {
    if (this is Type) return (this as Type).toString();
    if (this is String) return this as String;
    return runtimeType.toString();
  }
}

/// Message
class Message {
  ///
  Message({
    required this.title,
    required this.time,
    required this.type,
    this.text = '',
    this.level = 0,
    this.stackTrace,
    bool log = true,
    this.tags = const [],
    this.sourceFunction,
    this.sourceClass,
    this.templateValues = const {},
    String? runtimeSession,
    this.logId = 0,
    this.parentLogId,
  }) : runtimeSession = runtimeSession ?? Logging.runtimeSession {
    if (log) Logger.log(this);
  }

  /// Creates a message of type log
  Message.log({
    required this.title,
    this.text = '',
    this.level = 0,
    this.stackTrace,
    bool log = true,
    this.tags = const [],
    Object? klasse,
    this.sourceFunction,
    this.templateValues = const {},
    String? runtimeSession,
    this.logId = 0,
    this.parentLogId,
  })  : type = MessageType.log,
        time = DateTime.now(),
        sourceClass = klasse?.className,
        runtimeSession = runtimeSession ?? Logging.runtimeSession {
    if (log) Logger.log(this);
  }

  /// Creates a message of type info
  Message.info({
    required this.title,
    this.text = '',
    this.level = 0,
    this.stackTrace,
    bool log = true,
    this.tags = const [],
    Object? klasse,
    this.sourceFunction,
    this.templateValues = const {},
    String? runtimeSession,
    this.logId = 0,
    this.parentLogId,
  })  : type = MessageType.info,
        time = DateTime.now(),
        sourceClass = klasse?.className,
        runtimeSession = runtimeSession ?? Logging.runtimeSession {
    if (log) Logger.log(this);
  }

  /// Creates a message of type warning
  Message.warning({
    required this.title,
    this.text = '',
    this.level = 0,
    this.stackTrace,
    bool log = true,
    this.tags = const [],
    Object? klasse,
    this.sourceFunction,
    this.templateValues = const {},
    String? runtimeSession,
    this.logId = 0,
    this.parentLogId,
  })  : type = MessageType.warning,
        time = DateTime.now(),
        sourceClass = klasse?.className,
        runtimeSession = runtimeSession ?? Logging.runtimeSession {
    if (log) Logger.log(this);
  }

  /// Creates a message of type error
  Message.error({
    required this.title,
    this.text = '',
    this.level = 0,
    this.stackTrace,
    bool log = true,
    this.tags = const [],
    Object? sourceClass,
    this.sourceFunction,
    this.templateValues = const {},
    String? runtimeSession,
    this.logId = 0,
    this.parentLogId,
  })  : type = MessageType.error,
        time = DateTime.now(),
        sourceClass = sourceClass?.className,
        runtimeSession = runtimeSession ?? Logging.runtimeSession {
    if (log) Logger.log(this);
  }

  /// Creates a message of type log
  Message.trace({
    required this.title,
    this.text = '',
    this.level = -1,
    this.stackTrace,
    bool log = false,
    this.tags = const [],
    Object? klasse,
    this.sourceFunction,
    this.templateValues = const {},
    String? runtimeSession,
    this.logId = 0,
    this.parentLogId,
  })  : type = MessageType.trace,
        time = DateTime.now(),
        sourceClass = klasse?.className,
        runtimeSession = runtimeSession ?? Logging.runtimeSession {
    if (log) Logger.log(this);
  }

  /// Rebuilds a message based on a [map]
  factory Message.fromMap(Map<String, dynamic> map) =>
      MessageStorage.fromJson(map).toMessage();

  /// Name or Title of the message
  ///
  /// Do not use variables in the title,
  /// use [templateValues] instead
  ///
  /// Define a template with {_key_} to insert the value
  /// of the given key in [templateValues]
  ///
  /// When the key is not found in [templateValues],
  /// the bracket will be replaced: <_key_>
  final String title;

  /// Gets the title with the replaced template values
  String get titleString => replaceTemplates(title);

  /// Content of the message
  ///
  /// Do not use variables in the text,
  /// use [templateValues] instead
  ///
  /// Define a template with {_key_} to insert the value
  /// of the given key in [templateValues]
  ///
  /// When the key is not found in [templateValues],
  /// the bracket will be replaced: <_key_>
  final String text;

  /// Gets the text with the replaced template values
  String get textString => replaceTemplates(text);

  /// Values for templates in the [text] of the message
  final Map<String, String> templateValues;

  /// Time of the message
  ///
  /// Usually the DateTime from the creation of the message
  final DateTime time;

  /// Time of the message in microseconds
  int get timeMC => time.microsecondsSinceEpoch;

  /// Time of the message in milliseconds
  int get timeMS => time.millisecondsSinceEpoch;

  /// The higher the worse
  final int level;

  /// 0: log, 1: info, 2: warning, 3: error
  final MessageType type;

  /// Groups
  List<String> tags;

  /// Can provide stacktrace information when available
  StackTrace? stackTrace;

  /// Conter for testmode
  late final int testModeCount = Logger.testModeCounter;

  /// A marker used to stop coloring
  static const _endColorMarker = '\x1B[0m';

  /// toString with type-matching color
  String prettyString({bool stackTrace = false}) {
    final string = toString(stackTrace: stackTrace);
    return '${type.terminalColor}$string$_endColorMarker';
  }

  final String? sourceClass;

  final String? sourceFunction;

  final String runtimeSession;

  final int logId;

  final int? parentLogId;

  String get messageCode {
    final statics = '$type;$title;$sourceFunction;$sourceClass;$text;$level';
    final hash = Hash.sha256(statics);
    return hash.substring(0, 8);
  }

  /// Turns the message into a map
  ///
  /// This can later be used to recreate the message via fromMap
  Map<String, dynamic> toMap() => MessageStorage.fromMessage(this).toJson();

  /// Replaces the templates in a given [text]
  /// with the values in [templateValues]
  ///
  /// [maxDepth] - By default a maximum of 32 replacements will be
  /// processed to prevent infinite loops.
  /// You can increase the [maxDepth] but not disable it.
  ///
  /// Using regex
  String replaceTemplates(String inputValue, {int maxDepth = 32}) {
    final pattern = RegExp('{([^{}]+)}');
    var input = inputValue.trim();
    var iteration = 0;
    while ((iteration += 1) < maxDepth && iteration >= 0) {
      final match = pattern.firstMatch(input);
      if (match == null) break;
      final key = match.group(1);
      final value = templateValues[key] ?? '<$key>';
      input = input.replaceFirst(match.group(0) ?? '', value);
    }
    return input;
  }

  @override
  String toString({
    bool time = true,
    bool type = true,
    bool title = true,
    bool level = true,
    bool tags = true,
    bool text = true,
    bool stackTrace = false,
  }) {
    final str = StringBuffer();

    if (time) {
      if (!Logger.testMode) {
        str.write('${this.time}');
      } else {
        str.write('TestMode: $testModeCount');
      }
    }

    if (type) {
      if (str.isNotEmpty) str.write(' ');
      str.write(this.type.stringName);
    }

    if (title && this.title.isNotEmpty) {
      if (str.isNotEmpty) str.write(' ');
      str.write(titleString);
      if (level || (tags && this.tags.isNotEmpty)) str.write(':');
    }

    if (level) {
      if (!title && str.isNotEmpty) str.write(' ');
      str.write('(${this.level})');
    }

    if (tags && this.tags.isNotEmpty) {
      if (str.isNotEmpty) str.write(' ');
      str.write('[${this.tags.join(', ')}]');
    }

    if (text && this.text.isNotEmpty) {
      if (str.isNotEmpty) str.write(' => ');
      str.write(textString);
    }

    if (stackTrace && this.stackTrace != null) {
      if (str.isNotEmpty) str.write('\n');
      str.write(this.stackTrace.toString());
    }

    return str.toString();
  }
}
