import 'dart:async';

import 'dart:developer' as developer;

part 'messages.dart';

/// Handles Logs
class Logger {
  /// Gets reference to the Logger Object
  factory Logger() => _logger;

  Logger._internal() {
    logMessage(Message.warning(title: 'Init Com', log: false));
  }

  static final Logger _logger = Logger._internal();

  /// Message queue
  static final Map<int, Message> messages = {};

  static bool _activeLogging = true;

  final _controller = StreamController<Message>.broadcast();

  /// Stream of incoming Messages
  Stream<Message> get stream => _controller.stream;

  /// Disable the Logger
  static void disable() => _logger._active = false;

  /// Enable the Logger
  static void enable() => _logger._active = true;

  set _active(bool active) {
    if (active == _activeLogging) {
      Message.info(
        title: 'Logging state not changed',
        text: 'The logging state is already ${active ? 'enabled' : 'disabled'}',
        klasse: this,
        function: 'set._active',
      );
      return;
    }
    if (active) {
      Message.info(
        title: 'Enabled Logging',
        text: 'Set the logging state to enabled',
        klasse: this,
        function: 'set._active',
      );
    } else {
      Message.info(
        title: 'Disabled Logging',
        text: 'Set the logging state to disabled',
        klasse: this,
        function: 'set._active',
      );
    }
    _activeLogging = active;
  }

  /// Logs a Message
  static void log(Message message) => _logger.logMessage(message);

  /// Logs a Message
  void logMessage(
      Message message, {
        bool queue = true,
        bool notifyListeners = true,
        bool devLog = false,
        bool println = true,
      }) {
    if (!_activeLogging) return;
    if (queue) messages[message.time.millisecondsSinceEpoch] = message;
    if (notifyListeners) _controller.sink.add(message);
    if (println) print(message.prettyString(stackTrace: true));
    if (devLog) {
      developer.log(
        message.prettyString(stackTrace: true),
        time: message.time,
        level: message.level,
      );
    }
  }
}
