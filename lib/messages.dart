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
  })  : type = 0,
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
        tags = ((map['tags'] ?? <String>[]) as List)
            .map<String>((dynamic e) => e.toString())
            .toList();

  /// Name or Title of the message
  final String title;

  /// Content of the message
  final String text;

  /// Time of the message
  ///
  /// Usually the DateTime from the creation of the message
  final DateTime time;

  /// The higher the worse
  final int level;

  /// 0: log, 1: info, 2: warning, 3: error
  final int type;

  /// Groups
  List<String> tags;

  /// Can provide stacktrace information when available
  StackTrace? stackTrace;

  /// toString with type-matching color
  String prettyString({bool stackTrace = false}) {
    final string = toString(stackTrace: stackTrace);
    switch (type) {
      case 0:
        return '\x1B[37m$string';
      case 1:
        return '\x1B[34m$string';
      case 2:
        return '\x1B[33m$string';
      case 3:
        return '\x1B[31m$string';
    }
    return '';
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

    if (includeStackTrace && stackTrace != null) {
      map['stackTrace'] = stackTrace.toString();
    }

    return map;
  }

  String _typeToString() {
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

    if (time) str.write('${this.time}');

    if (type) {
      if (str.isNotEmpty) str.write(' ');
      str.write(_typeToString());
    }

    if (title) {
      if (str.isNotEmpty) str.write(' ');
      str.write('${this.title}:');
    }

    if (level) {
      if (!title) str.write(' ');
      str.write('(${this.level})');
    }

    if (tags) {
      if (str.isNotEmpty) str.write(' ');
      str.write('[${this.tags.join(', ')}]');
    }

    if (text) {
      if (str.isNotEmpty) str.write(' => ');
      str.write(this.text);
    }

    if (stackTrace && this.stackTrace != null) {
      if (str.isNotEmpty) str.write('\n');
      str.write(this.stackTrace.toString());
    }

    return str.toString();
  }
}
