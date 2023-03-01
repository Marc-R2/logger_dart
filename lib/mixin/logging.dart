part of '../logger.dart';

/// Allow any class to easily log messages
mixin Logging {
  /// Log a message
  late final log = MessageTemplate(klasse: this);

  /// Create a child template with the given [function]
  MessageTemplate functionLog(String function) => log.function(function);

  /// Create a child template with the given [className]
  MessageTemplate classLog(Object className) => log.klasse(className);

  /// Create a Log with the given [function] and [context]
  /// at the start of the function
  Log functionStart(String function, [Log? context]) {
    final newLog = Log(
      parent: context,
      function: function,
      id: context != null ? context.id + 1 : 0,
      klasse: this,
      tags: ['FunctionStart'],
      session: context?.session ?? currentSession,
    );

    return newLog;
  }

  static String? _session;

  /// Get the current session id
  ///
  /// This is unique to each runtime
  static String get runtimeSession {
    if (_session != null) return _session!;

    final now = DateTime.now();
    final minSinceEpoch = now.millisecondsSinceEpoch ~/ 60000;
    return _session = minify(minSinceEpoch * 10 + now.second + now.millisecond);
  }

  /// Get the current session id
  ///
  /// This is based on the current time
  static String get currentSession {
    final now = DateTime.now();
    return minify(now.millisecond * 100 + now.microsecond);
  }

  /// Minify the given [id] to a string
  static String minify(int id) => id.toRadixString(36);
}
