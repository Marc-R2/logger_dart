import 'package:log_message/logger.dart';
import 'package:test/test.dart';

void main() {
  group('Logging mixin', () {
    test('log method creates a log message', () {
      final log = LoggingMock();
      final message = log.log.log(title: 'Test message');

      expect(message.title, equals('Test message'));
      expect(message.type, equals(0));
    });

    test('info method creates an info message', () {
      final log = LoggingMock();
      final message = log.log.info(title: 'Test message');

      expect(message.title, equals('Test message'));
      expect(message.type, equals(1));
    });

    test('warn method creates a warning message', () {
      final log = LoggingMock();
      final message = log.log.warn(title: 'Test message');

      expect(message.title, equals('Test message'));
      expect(message.type, equals(2));
    });

    test('error method creates an error message', () {
      final log = LoggingMock();
      final message = log.log.error(title: 'Test message');

      expect(message.title, equals('Test message'));
      expect(message.type, equals(3));
    });

    // Trace
    test('trace method creates a trace message', () {
      final log = LoggingMock();
      final message = log.log.trace(title: 'Test message');

      expect(message.title, equals('Test message'));
      expect(message.type, equals(9));
    });

    // Exception
    test('exception method creates an exception message', () {
      final log = LoggingMock();
      final message = log.log.exception(title: 'Test message');

      expect(message.title, equals('Test message'));
      expect(message.type, equals(3));
    });
  });

  group('Logging Mixin', () {
    test('Test log method', () {
      final testClass = LoggingMock();
      testClass.log.log(title: 'Test title', message: 'Test message');
      final message = Logger.messages.values.last;
      expect(message.title, equals('Test title'));
      expect(message.text, equals('Test message'));
      expect(message.level, equals(0));
      expect(message.tags, equals(hasLength(2)));
      expect(message.tags, equals(contains('class:LoggingMock')));
      expect(message.templateValues, equals({}));
    });

    test('Test functionLog method', () {
      final testClass = LoggingMock();
      testClass
          .functionLog('testFunction')
          .log(title: 'Test title', message: 'Test message');

      final message = Logger.messages.values.last;
      expect(message.title, equals('Test title'));
      expect(message.text, equals('Test message'));
      expect(message.level, equals(0));
      expect(message.tags, equals(hasLength(3)));
      expect(message.tags, equals(contains('class:LoggingMock')));
      expect(message.tags, equals(contains('func:testFunction')));
      expect(message.templateValues, equals({}));
    });

    test('Test classLog method', () {
      final testClass = LoggingMock();
      testClass
          .classLog(Logger())
          .log(title: 'Test title', message: 'Test message');

      final message = Logger.messages.values.last;
      expect(message.title, equals('Test title'));
      expect(message.text, equals('Test message'));
      expect(message.level, equals(0));
      expect(message.tags, equals(hasLength(2)));
      expect(message.tags, equals(contains('class:Logger')));
      expect(message.templateValues, equals({}));
    });
  });
}

class LoggingMock with Logging {}
