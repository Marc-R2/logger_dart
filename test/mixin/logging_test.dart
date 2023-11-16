import 'dart:async';

import 'package:log_message/logger.dart';
import 'package:test/test.dart';

void main() {
  group('Logging Mixin', () {
    group('Message Types', () {
      test('log method creates a log message', () {
        final log = LoggingMock();
        final message = log.log.log(title: 'Test message');

        expect(message.title, equals('Test message'));
        expect(message.type, equals(MessageType.log));
      });

      test('info method creates an info message', () {
        final log = LoggingMock();
        final message = log.log.info(title: 'Test message');

        expect(message.title, equals('Test message'));
        expect(message.type, equals(MessageType.info));
      });

      test('warn method creates a warning message', () {
        final log = LoggingMock();
        final message = log.log.warn(title: 'Test message');

        expect(message.title, equals('Test message'));
        expect(message.type, equals(MessageType.warning));
      });

      test('error method creates an error message', () {
        final log = LoggingMock();
        final message = log.log.error(title: 'Test message');

        expect(message.title, equals('Test message'));
        expect(message.type, equals(MessageType.error));
      });

      // Trace
      test('trace method creates a trace message', () {
        final log = LoggingMock();
        final message = log.log.trace(title: 'Test message');

        expect(message.title, equals('Test message'));
        expect(message.type, equals(MessageType.trace));
      });

      // Exception
      test('exception method creates an exception message', () {
        final log = LoggingMock();
        final message = log.log.exception(title: 'Test message');

        expect(message.title, equals('Test message'));
        expect(message.type, equals(MessageType.error));
      });
    });

    group('log group', () {
      test('Test log method', () {
        final testClass = LoggingMock();
        testClass.log.log(title: 'Test title', message: 'Test message');
        final message = Logger.messages.values.last;
        expect(message.title, equals('Test title'));
        expect(message.text, equals('Test message'));
        expect(message.level, equals(0));
        expect(message.tags, equals(hasLength(0)));
        expect(message.sourceClass, equals('LoggingMock'));
        expect(message.templateValues, equals({}));
      });
    });

    group('functionLog group', () {
      test('Test functionLog method', () {
        final testClass = LoggingMock();
        testClass
            .functionLog('testFunction')
            .log(title: 'Test title', message: 'Test message');

        final message = Logger.messages.values.last;
        expect(message.title, equals('Test title'));
        expect(message.text, equals('Test message'));
        expect(message.level, equals(0));
        expect(message.tags, equals(hasLength(0)));
        expect(message.sourceClass, equals('LoggingMock'));
        expect(message.sourceFunction, equals('testFunction'));
        expect(message.templateValues, equals({}));
      });
    });

    group('classLog group', () {
      test('Test classLog method', () {
        final testClass = LoggingMock();
        testClass
            .classLog(Logger())
            .log(title: 'Test title', message: 'Test message');

        final message = Logger.messages.values.last;
        expect(message.title, equals('Test title'));
        expect(message.text, equals('Test message'));
        expect(message.level, equals(0));
        expect(message.tags, equals(hasLength(0)));
        expect(message.sourceClass, equals('Logger'));
        expect(message.templateValues, equals({}));
      });
    });

    group('functionStart group', () {
      test('functionStart returns new log with correct attributes', () {
        final logging = LoggingMock();
        final log = logging.functionStart('testFunction');

        expect(log.tags.contains('FunctionStart'), isTrue);
        expect(log.parent, isNull);
        expect(log.runtime, isNot(equals(Logging.currentSession)));
        // expect(log.logId, equals(0));
      });

      test('functionStart returns new log with correct parent log', () {
        final logging = LoggingMock();
        final parentLog = Log(function: 'parent', klasse: logging, session: '');
        final log = logging.functionStart('testFunction', parentLog);

        expect(log.parent, equals(parentLog));
        // expect(log.logId, equals(parentLog.logId + 1));
      });

      test(
        'functionStart returns new log with correct session from parent log',
        () {
          final logging = LoggingMock();
          final parentLog = Log(
            function: 'parent',
            klasse: logging,
            session: 'parentSession',
          );
          final log = logging.functionStart('testFunction', parentLog);

          expect(log.runtime, equals(parentLog.runtime));
        },
      );
    });

    group('static', () {
      group('minify group', () {
        test('minify returns correct value for zero', () {
          expect(Logging.minify(0), equals('0'));
        });

        test('minify returns correct value for positive integers', () {
          expect(Logging.minify(1), equals('1'));
          expect(Logging.minify(35), equals('z'));
          expect(Logging.minify(100), equals('2s'));
          expect(Logging.minify(1000), equals('rs'));
          expect(Logging.minify(123456), equals('2n9c'));
          expect(Logging.minify(999999), equals('lflr'));
        });

        test('minify returns correct value for negative integers', () {
          expect(Logging.minify(-1), equals('-1'));
          expect(Logging.minify(-35), equals('-z'));
          expect(Logging.minify(-100), equals('-2s'));
          expect(Logging.minify(-1000), equals('-rs'));
          expect(Logging.minify(-123456), equals('-2n9c'));
          expect(Logging.minify(-999999), equals('-lflr'));
        });
      });

      group('currentSession group', () {
        test('currentSession returns non-null string', () {
          expect(Logging.currentSession, isNotNull);
          expect(Logging.currentSession, isNotEmpty);
        });

        test('currentSession returns string with correct format', () {
          final pattern = RegExp(r'^[a-z0-9]+$');
          expect(Logging.currentSession, matches(pattern));
          expect(Logging.currentSession, hasLength(lessThan(4)));
        });

        group('currentSession returns different strings on multiple calls', () {
          Message.log(title: 'currentSession returns different strings');
          for (var i = 0; i < 64 * 2; i++) {
            test('currentSession $i', () {
              final session1 = Logging.currentSession;
              final session2 = Logging.currentSession;
              expect(session1, isNot(equals(session2)));
              expect(session1, hasLength(lessThan(4)));
              expect(session2, hasLength(lessThan(4)));
            });
          }
        });

        test(
            'currentSession returns non-null '
            'and non-empty string in separate zones', () async {
          final zone = Zone.current.fork();
          final session = zone.run(() => Logging.currentSession);
          expect(session, isNotNull);
          expect(session, isNotEmpty);
        });

        test('currentSession returns different strings for different times',
            () async {
          final session1 = Logging.currentSession;
          await Future<void>.delayed(const Duration(milliseconds: 10));
          final session2 = Logging.currentSession;
          expect(session1, isNot(equals(session2)));
        });
      });

      group('runtimeSession', () {
        test('runtimeSession returns a unique string', () {
          final session1 = Logging.runtimeSession;
          final session2 = Logging.runtimeSession;
          expect(session1, equals(session2));
        });

        test('runtimeSession returns string with correct format', () {
          final pattern = RegExp(r'^[a-z0-9]+$');
          expect(Logging.runtimeSession, matches(pattern));
        });

        test('runtimeSession returns non-null and non-empty string', () {
          final session = Logging.runtimeSession;
          expect(session, isNotNull);
          expect(session, isNotEmpty);
        });

        test('runtimeSession returns the same string in the same isolate', () {
          final session1 = Logging.runtimeSession;
          final session2 = Logging.runtimeSession;
          expect(session1, equals(session2));
        });

        test('runtimeSession returns the same string in different zones',
            () async {
          final session = Zone.current.fork().run(() => Logging.runtimeSession);
          expect(session, equals(Logging.runtimeSession));
        });

        test('runtimeSession returns a same string on different runs', () {
          final session1 = Logging.runtimeSession;
          final session2 = Logging.runtimeSession;
          expect(session1, equals(session2));
        });
      });
    });
  });
}

class LoggingMock with Logging {}
