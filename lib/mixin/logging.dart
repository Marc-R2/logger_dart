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
    return Log(
      parent: context,
      function: function,
      klasse: this,
      tags: ['FunctionStart'],
      session: context?.session ?? currentSession,
    );
  }

  static String? _session;

  /// Get the current session id
  ///
  /// This is unique to each runtime
  static String get runtimeSession {
    if (_session != null) return _session!;

    final now = DateTime.now();
    final minSinceEpoch = now.millisecondsSinceEpoch ~/ 6000;
    return _session = minify(minSinceEpoch + now.second + now.millisecond);
  }

  static int _sessionCounter = 0;

  /// Get the current session id
  ///
  /// This is based on the current time
  static String get currentSession {
    _sessionCounter++;
    if (_sessionCounter > 46655) resetRuntime();
    return minify(_sessionCounter);
  }

  /// Minify the given [id] to a string
  static String minify(int id) => id.toRadixString(36);

  /// Reset the [runtimeSession]
  ///
  /// This will create a new [runtimeSession] id and
  /// reset the [currentSession] counter
  static Message resetRuntime() {
    final oldRuntime = runtimeSession;
    _session = null;
    _sessionCounter = 0;
    final newRuntime = runtimeSession;

    return Message.info(
      title: 'Reset Runtime',
      tags: ['o_r:$oldRuntime', 'n_r:$newRuntime'],
    );
  }
}
