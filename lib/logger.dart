import 'dart:async';

import 'dart:developer' as developer;

part 'mixin/logging.dart';

part 'messages.dart';

part 'message_templates.dart';

/// Handles Logs
class Logger {
  /// Gets reference to the Logger Object
  factory Logger() => _logger;

  Logger._internal() {
    logMessage(Message.warning(title: 'Init Logger', log: false));
  }

  static final Logger _logger = Logger._internal();

  /// Message queue
  static final Map<int, Message> messages = {};

  static bool _activeLogging = true;

  final _controller = StreamController<Message>.broadcast();

  late final _logIt = MessageTemplate(klasse: this);

  /// Stream of incoming Messages
  Stream<Message> get stream => _controller.stream;

  /// Returns a stream of messages filtered by the given [test].
  Stream<Message> where(bool Function(Message event) test) =>
      stream.where(test);

  /// Disable the Logger
  static void disable() => _logger._active = false;

  /// Enable the Logger
  static void enable() => _logger._active = true;

  set _active(bool active) {
    final log = _logIt.child(function: 'set._active');

    if (active == _activeLogging) {
      log.info(
        title: 'Logging state not changed',
        message: 'The logging state is already {active}',
        values: {'active': active ? 'enabled' : 'disabled'},
      );
      return;
    }
    if (active) {
      log.info(
        title: 'Enabled Logging',
        message: 'Set the logging state to enabled',
      );
    } else {
      log.info(
        title: 'Disabled Logging',
        message: 'Set the logging state to disabled',
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
