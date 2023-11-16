import 'package:log_message/logger.dart';
import 'package:test/test.dart';

void main() {
  group('Log', () {
    test('Test log method', () {
      final log = Log(session: '123');
      final message = log.log(title: 'Test title', message: 'Test message');
      expect(message.title, equals('Test title'));
      expect(message.text, equals('Test message'));
      expect(message.level, equals(0));
      expect(message.runtimeId, equals('123'));
      expect(message.logId, equals(0));
      expect(message.templateValues, equals({}));
    });

    test('Test child method', () {
      final log = Log(session: 'abc');
      final childLog = log.child(tags: ['tag3']);
      expect(childLog.runtimeId, equals('abc'));
      expect(childLog.tags, equals(contains('tag3')));
      expect(childLog.tags, equals(hasLength(1)));
    });

    test('child() should inherit template values from parent', () {
      final log = Log(session: 'xyz');
      final childLog = log.child(tags: ['child']);

      expect(childLog.tags, hasLength(1));
      expect(childLog.tags, contains('child'));
    });

    test('log() should create a log message with the template values', () {
      final log = Log(
        tags: ['test'],
        klasse: 'TestClass',
        function: 'testFunction',
        session: '123',
      );

      final message = log.log(title: 'Test message');

      expect(message.type, equals(MessageType.log));
      expect(message.title, equals('Test message'));

      expect(message.tags.length, equals(1));
      expect(message.tags, contains('test'));
      expect(message.sourceClass, equals('TestClass'));
      expect(message.sourceFunction, equals('testFunction'));
      expect(message.runtimeId, equals('123'));
      expect(message.logId, equals(0));
    });

    test('Test creating a message with a child template', () {
      final log = Log(tags: ['Test'], session: '123');
      final message = log.log(title: 'Test message', message: 'Test');
      expect(message.tags, contains('Test'));
    });

    test('Test creating a message with a child template and class', () {
      final log = Log(klasse: 'Log', session: '123');
      final message = log.log(title: 'Test message', message: 'Test');
      expect(message.sourceClass, equals('Log'));
    });

    group('finish group', () {
      test('with no delay', () async {
        final log = Log(session: '123');

        final res = log.finish();
        expect(res, isNull);
      });

      test('with not enough delay', () async {
        final log = Log(session: '123');

        await Future<void>.delayed(const Duration(milliseconds: 50));

        final res = log.finish(threshold: const Duration(milliseconds: 100));
        expect(res, isNull);
      });

      test('with enough delay', () async {
        final log = Log(session: '123');

        await Future<void>.delayed(const Duration(milliseconds: 50));

        final res = log.finish(threshold: const Duration(milliseconds: 10));
        expect(res, isNotNull);

        expect(res!.tags, contains('duration'));
        expect(res.tags, contains(startsWith('ex_mc:5')));
        expect(res.text, contains('ms'));
        expect(res.text, contains('{ms}'));
        expect(res.templateValues['ms'], isNotNull);
        expect(res.templateValues['ms'], startsWith('5'));
        expect(res.templateValues['ms'], hasLength(2));
      });
    });

    group('finish with return group', () {
      group('include result', () {
        test('with no delay', () async {
          final log = Log(session: '123');

          final res = log.finishWithReturn('1234', includeResult: true);
          expect(res, '1234');
        });

        test('with not enough delay', () async {
          final log = Log(session: '123');

          await Future<void>.delayed(const Duration(milliseconds: 50));

          final res = log.finishWithReturn(
            1234,
            threshold: const Duration(milliseconds: 100),
            includeResult: true,
          );
          expect(res, 1234);
        });

        test('with enough delay', () async {
          final log = Log(session: '123');

          await Future<void>.delayed(const Duration(milliseconds: 50));

          final res = log.finishWithReturn(
            true,
            threshold: const Duration(milliseconds: 10),
            includeResult: true,
          );
          expect(res, isNotNull);

          expect(res, isTrue);
        });
      });

      group('exclude result', () {
        test('with no delay', () async {
          final log = Log(session: '123');

          final res = log.finishWithReturn('1234');
          expect(res, '1234');
        });

        test('with not enough delay', () async {
          final log = Log(session: '123');

          await Future<void>.delayed(const Duration(milliseconds: 50));

          final res = log.finishWithReturn(
            1234,
            threshold: const Duration(milliseconds: 100),
          );
          expect(res, 1234);
        });

        test('with enough delay', () async {
          final log = Log(session: '123');

          await Future<void>.delayed(const Duration(milliseconds: 50));

          final res = log.finishWithReturn(
            true,
            threshold: const Duration(milliseconds: 10),
          );
          expect(res, isNotNull);

          expect(res, isTrue);
        });
      });
    });

    group('parenting', () {
      test('child() should inherit template values from parent', () {
        final mock = LoggingMock();
        final log1 = mock.functionStart('testFunc1');
        final log2 = mock.functionStart('testFunc2', log1);

        // expect(log1.logId, equals(0));
        expect(log1.tags, contains('FunctionStart'));
        // expect(log2.logId, equals(1));
        expect(log2.tags, contains('FunctionStart'));

        final msg = log2.warn(title: 'Test message', message: 'Test');

        expect(msg.tags, contains('FunctionStart'));
        expect(msg.sourceFunction, equals('testFunc2'));
        expect(msg.sourceClass, equals('LoggingMock'));
      });
    });

    group('Log tests', () {
      test('Log session should be inherited from parent if not defined', () {
        final parent = Log(session: 'parent_session');
        final child = Log(parent: parent);
        expect(child.runtime, equals('parent_session'));
      });

      test('Log tags should contain session and id', () {
        final log = Log(session: 'test_session');
        expect(log.runtime, equals('test_session'));
        // expect(log.logId, equals(0));
      });

      test('Log tags should not contain null session', () {
        final log1 = Log(session: 'parent_session');
        final log2 = Log(parent: log1);
        // expect(log1.logId, equals(0));
        expect(log1.runtime, equals('parent_session'));
        // expect(log2.logId, equals(1));
        expect(log2.runtime, equals('parent_session'));
      });
    });
  });
}

class LoggingMock with Logging {}
