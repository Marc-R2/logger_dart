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

  /// Enable testMode for Logger and reset testModeCounter to 0
  static void test() {
    Logger();
    _testModeCounter = 0;
    _testMode = true;
    Message.warning(title: 'Enter Testmode');
  }

  static final Logger _logger = Logger._internal();

  /// Message queue
  static final Map<int, Message> messages = {};

  static bool _activeLogging = true;

  static bool _testMode = false;

  /// Whether testMode is active
  static bool get testMode => _testMode;

  static int _testModeCounter = 0;

  /// Counter for testMode
  static int get testModeCounter {
    if (!testMode) return 0;
    return _testModeCounter += 1;
  }

  static final _controller = StreamController<Message>.broadcast();

  late final _logIt = MessageTemplate(klasse: this);

  /// Stream of incoming Messages
  static Stream<Message> get stream => _controller.stream;

  /// Returns a stream of messages filtered by the given [test].
  static Stream<Message> where(bool Function(Message event) test) =>
      stream.where(test);

  /// Disable the Logger
  static void disable({bool logIt = true}) =>
      _logger.setActive(active: false, logIt: logIt);

  /// Enable the Logger
  static void enable({bool logIt = true}) =>
      _logger.setActive(active: true, logIt: logIt);

  void setActive({required bool active, bool logIt = true}) {
    final log = _logIt.child(function: 'setActive');

    if (logIt) {
      log.info(
        title: '{mode} Logging',
        message: 'Set the logging state to {state}',
        values: {
          'mode': active ? 'Enable' : 'Disable',
          'state': active ? 'active' : 'inactive',
        },
      );
    }

    _activeLogging = active;
  }

  /// Whether the Logger is active
  static bool get isLoggingEnabled => _activeLogging;

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
