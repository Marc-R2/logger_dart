part of 'logger.dart';

// TODO(me): const constructors for better performance

/// Message
class Message {
  /// Creates a message of type log
  Message.log({
    required this.title,
    this.text = '',
    this.level = 0,
    this.stackTrace,
    bool log = true,
    List<String>? tags,
    Object? klasse,
    String? function,
    this.templateValues = const {},
  })  : type = 0,
        tags = tags ?? [],
        time = DateTime.now() {
    _handleClassFunc(klasse, function);
    if (log) Logger.log(this);
  }

  /// Creates a message of type info
  Message.info({
    required this.title,
    this.text = '',
    this.level = 0,
    this.stackTrace,
    bool log = true,
    List<String>? tags,
    Object? klasse,
    String? function,
    this.templateValues = const {},
  })  : type = 1,
        tags = tags ?? [],
        time = DateTime.now() {
    _handleClassFunc(klasse, function);
    if (log) Logger.log(this);
  }

  /// Creates a message of type warning
  Message.warning({
    required this.title,
    this.text = '',
    this.level = 0,
    this.stackTrace,
    bool log = true,
    List<String>? tags,
    Object? klasse,
    String? function,
    this.templateValues = const {},
  })  : type = 2,
        tags = tags ?? [],
        time = DateTime.now() {
    _handleClassFunc(klasse, function);
    if (log) Logger.log(this);
  }

  /// Creates a message of type error
  Message.error({
    required this.title,
    this.text = '',
    this.level = 0,
    this.stackTrace,
    bool log = true,
    List<String>? tags,
    Object? klasse,
    String? function,
    this.templateValues = const {},
  })  : type = 3,
        tags = tags ?? [],
        time = DateTime.now() {
    _handleClassFunc(klasse, function);
    if (log) Logger.log(this);
  }

  /// Creates a message of type log
  Message.trace({
    required this.title,
    this.text = '',
    this.level = -1,
    this.stackTrace,
    bool log = false,
    List<String>? tags,
    Object? klasse,
    String? function,
    this.templateValues = const {},
  })  : type = 9,
        tags = tags ?? [],
        time = DateTime.now() {
    _handleClassFunc(klasse, function);
    //print(toString());
    if (log) Logger.log(this);
  }

  /// Rebuilds a message based on a [map]
  Message.fromMap(Map<dynamic, dynamic> map)
      : title = (map['title'] ?? 'Error') as String,
        text = (map['text'] ?? '') as String,
        time = DateTime.fromMillisecondsSinceEpoch((map['time'] ?? 0) as int),
        level = (map['level'] ?? 0) as int,
        type = (map['type'] ?? 0) as int,
        templateValues = ((map['templates'] ?? <dynamic, dynamic>{}) as Map)
            .map((key, value) => MapEntry(key.toString(), value.toString())),
        tags = ((map['tags'] ?? <String>[]) as List)
            .map<String>((dynamic e) => e.toString())
            .toList();

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

  /// The higher the worse
  final int level;

  /// 0: log, 1: info, 2: warning, 3: error
  final int type;

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
    switch (type) {
      case 0:
        return '\x1B[37m$string$_endColorMarker';
      case 1:
        return '\x1B[34m$string$_endColorMarker';
      case 2:
        return '\x1B[33m$string$_endColorMarker';
      case 3:
        return '\x1B[31m$string$_endColorMarker';
    }
    return string;
  }

  void _handleClassFunc(Object? klasse, String? function) {
    if (klasse != null) {
      if (klasse is String) {
        tags.add('class:$klasse');
      } else {
        tags.add('class:${klasse.runtimeType}');
      }
    }
    if (function != null) tags.add('func:$function');
  }

  /// Turns the message into a map
  ///
  /// This can later be used to recreate the message via fromMap
  Map<String, dynamic> toMap({bool includeStackTrace = false}) {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['text'] = text;
    map['type'] = type;
    map['level'] = level;
    map['tags'] = tags;
    map['time'] = time.millisecondsSinceEpoch;
    map['templates'] = templateValues;

    if (includeStackTrace && stackTrace != null) {
      map['stackTrace'] = stackTrace.toString();
    }

    return map;
  }

  /// Turns the type of the message into a string
  String typeToString() {
    switch (type) {
      case 0:
        return 'Log:';
      case 1:
        return 'Info:';
      case 2:
        return 'Warning:';
      case 3:
        return 'Error:';
    }
    return '';
  }

  /// Removes all curly brackets from a given [text]
  static String removeCurlyBrackets(String? text) {
    if (text == null) return '';
    return text.replaceAll('{', '').replaceAll('}', '');
  }

  /// Replaces the templates in a given [text]
  /// with the values in [templateValues]
  ///
  /// Curly brackets are not allowed in values and will be deleted
  ///
  /// Using regex
  String replaceTemplates(String text, {bool? recursion}) {
    // RegEx to find "{key}"
    final regExp = RegExp('{([a-zA-Z0-9]+)}');

    // Check if there is a 2 opening curly brackets
    // without a closing one in between
    // TODO(Marc-R2): Improve recursion detection
    // final regExp2 = RegExp('{{([a-zA-Z0-9]+)}}');

    final disableRecursion =
        !(recursion ?? (text.contains('{{') || text.contains('}}')));

    if (disableRecursion) {
      return text.replaceAllMapped(regExp, (match) {
        final key = match.group(1);
        return templateValues[key] ?? '<$key>';
      });
    }

    var resultText = text;

    var done = false;
    while (!done) {
      final match = regExp.allMatches(resultText);

      if (match.isEmpty) {
        done = true;
      } else {
        final key = removeCurlyBrackets(match.last.group(1));
        if (key.contains('{') || key.contains('}')) {
          return 'Error: Invalid state for: $key';
        }

        final value = templateValues[key] ?? '<$key>';
        resultText = resultText.replaceFirst('{$key}', value);
      }
    }

    return resultText;
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
      str.write(typeToString());
    }

    if (title && this.title.isNotEmpty) {
      if (str.isNotEmpty) str.write(' ');
      str.write(titleString);
      if (level || (tags && this.tags.isNotEmpty)) str.write(':');
    }

    if (level) {
      if (!title) str.write(' ');
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
