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
      session: context?.sessionId ?? currentSession,
      runtime: context?.runtimeId ?? runtimeSession,
    );
  }

  static LogRuntime? _session;

  /// Get the current session id
  ///
  /// This is unique to each runtime
  static LogRuntime get runtimeSession {
    if (_session != null) return _session!;

    final now = DateTime.now();
    final minSinceEpoch = now.millisecondsSinceEpoch ~/ 6000;
    final id = minify(minSinceEpoch + now.second + now.millisecond);
    return _session = LogRuntime(id);
  }

  static int _sessionCounter = 0;

  /// Get the current session id
  ///
  /// This is based on the current time
  static LogSession get currentSession {
    _sessionCounter++;
    if (_sessionCounter > 46655) resetRuntime();
    return LogSession(minify(_sessionCounter));
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

class LogRuntime {
  const LogRuntime(this.runtimeId);

  final String runtimeId;

  @override
  String toString() => runtimeId;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LogRuntime &&
          runtimeType == other.runtimeType &&
          runtimeId == other.runtimeId;

  @override
  int get hashCode => runtimeId.hashCode;
}

class LogSession {
  const LogSession(this.sessionId);

  final String sessionId;

  @override
  String toString() => sessionId;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LogSession &&
          runtimeType == other.runtimeType &&
          sessionId == other.sessionId;

  @override
  int get hashCode => sessionId.hashCode;
}
