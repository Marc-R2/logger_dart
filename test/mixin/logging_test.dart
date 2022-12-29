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
  });
}

class LoggingMock with Logging {}
