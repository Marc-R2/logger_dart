import 'package:clock/clock.dart';
import 'package:log_message/logger.dart';
import 'package:test/test.dart';

void main() {
  group('Logger', () {
    test('testMode', () {
      Logger.test();
      expect(Logger.testMode, isTrue);
      expect(Logger.testModeCounter, 2);
      expect(Logger.testModeCounter, 3);
      expect(Logger.testModeCounter, 4);
      expect(Logger.testModeCounter, 5);
      expect(Logger.testModeCounter, 6);
    });

    test('logStream', () {
      final stream = Logger.stream;
      expect(stream, isA<Stream<Message>>());
    });

    test('logStreamWhere', () {
      final stream = Logger.where((event) => event.title == 'test');
      expect(stream, isA<Stream<Message>>());
    });

    test('logStreamWhereListen', () {
      final stream = Logger.where((event) => event.title == 'test');
      expect(stream, isA<Stream<Message>>());
      stream.listen((event) {
        expect(event.title, 'test');
      });
      Logger.log(Message.log(title: 'test'));
    });

    test('log method should add message to messages map', () {
      final message = Message.log(title: 'Test message', log: false);
      Logger.log(message);
      final logMessage = Logger.messages[message.time.millisecondsSinceEpoch];
      expect(logMessage?.title, message.title);
    });

    test('test logging state', () {
      Logger.disable();
      expect(Logger.isLoggingEnabled, equals(false));
      Logger.enable();
      expect(Logger.isLoggingEnabled, equals(true));
    });

    test('log method should notify listeners', () {
      final now = DateTime.now();
      withClock(Clock.fixed(now), () {
        final logMessage = Logger.stream.listen((message) {
          expect(message, equals(Logger.messages[now.millisecondsSinceEpoch]));
        });
        Logger.log(Message.log(title: 'Test message', log: false));
        logMessage.cancel();
      });
    });

    test('log method should not add message when logging is disabled', () {
      Logger.disable();
      Logger.log(Message.log(title: 'Not logged msg.', log: false));
      expect(Logger.messages.values, isNot(contains('Not logged msg.')));
      Logger.enable();
    });

    test('Test setting setActive variable with active = false', () {
      Logger.enable();
      Logger.disable();
      expect(Logger.isLoggingEnabled, equals(false));

      // Get newest message (by time) from messages map key
      final message = Logger.messages.values
          .reduce((curr, next) => curr.time.isAfter(next.time) ? curr : next);

      expect(message.title, equals('{mode} Logging'));
      expect(message.text, equals('Set the logging state to {state}'));

      expect(message.titleString, equals('Disable Logging'));
      expect(message.textString, equals('Set the logging state to inactive'));
    });

    test('Test setting setActive variable with active = true', () {
      Logger.enable();
      Logger.enable();
      expect(Logger.isLoggingEnabled, equals(true));

      final message = Logger.messages.values
          .reduce((curr, next) => curr.time.isAfter(next.time) ? curr : next);

      expect(message.title, equals('{mode} Logging'));
      expect(message.text, equals('Set the logging state to {state}'));

      expect(message.titleString, equals('Enable Logging'));
      expect(message.textString, equals('Set the logging state to active'));
    });

    test('Test Logger.enable() with logIt = false', () {
      Logger.enable();
      Message.info(title: 'Test message');
      Logger.disable(logIt: false);
      expect(Logger.isLoggingEnabled, equals(false));

      // Get newest message (by time) from messages map key
      final message = Logger.messages.values
          .reduce((curr, next) => curr.time.isAfter(next.time) ? curr : next);

      expect(message.titleString, isNot(equals('Disable Logging')));
      expect(message.titleString, equals('Test message'));
    });

    test('Test setting setActive variable with active = true', () {
      Logger.enable();
      Message.info(title: 'Test message');
      Logger.enable(logIt: false);
      expect(Logger.isLoggingEnabled, equals(true));

      final message = Logger.messages.values
          .reduce((curr, next) => curr.time.isAfter(next.time) ? curr : next);

      expect(message.titleString, isNot(equals('Enable Logging')));
      expect(message.titleString, equals('Test message'));
    });
  });
}
