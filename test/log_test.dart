import 'package:log_message/logger.dart';
import 'package:test/test.dart';

void main() {
  group('Log', () {
    test('Test log method', () {
      const log = Log(session: '123');
      final message = log.log(title: 'Test title', message: 'Test message');
      expect(message.title, equals('Test title'));
      expect(message.text, equals('Test message'));
      expect(message.level, equals(0));
      expect(message.tags, equals(contains('session:123')));
      expect(message.tags, equals(contains('id:0')));
      expect(message.tags, equals(hasLength(3)));
      expect(message.templateValues, equals({}));
    });

    test('Test child method', () {
      const log = Log(session: 'abc');
      final childLog = log.child(tags: ['tag3']);
      expect(childLog.tags, equals(contains('session:abc')));
      expect(childLog.tags, equals(contains('id:0')));
      expect(childLog.tags, equals(contains('tag3')));
      expect(childLog.tags, equals(hasLength(3)));
    });

    test('child() should inherit template values from parent', () {
      const log = Log(session: 'xyz');
      final childLog = log.child(tags: ['child']);

      expect(childLog.tags, hasLength(3));
      expect(childLog.tags, contains('session:xyz'));
      expect(childLog.tags, contains('id:0'));
      expect(childLog.tags, contains('child'));
    });

    test('log() should create a log message with the template values', () {
      const log = Log(
        tags: ['test'],
        klasse: 'TestClass',
        function: 'testFunction',
        session: '123',
      );

      final message = log.log(title: 'Test message');

      expect(message.type, equals(0));
      expect(message.title, equals('Test message'));

      expect(message.tags.length, equals(6));
      expect(message.tags, contains('test'));
      expect(message.tags, contains('class:TestClass'));
      expect(message.tags, contains('func:testFunction'));
      expect(message.tags, contains('session:123'));
      expect(message.tags, contains('id:0'));
    });

    test('Test creating a message with a child template', () {
      const log = Log(tags: ['Test'], session: '123');
      final message = log.log(title: 'Test message', message: 'Test');
      expect(message.tags, contains('Test'));
    });

    test('Test creating a message with a child template and class', () {
      const log = Log(klasse: 'Log', session: '123');
      final message = log.log(title: 'Test message', message: 'Test');
      expect(message.tags, contains('class:Log'));
    });

    group('parenting', () {
      test('child() should inherit template values from parent', () {
        final mock = LoggingMock();
        final log1 = mock.functionStart('testFunc1');
        final log2 = mock.functionStart('testFunc2', log1);

        expect(log1.tags, contains('id:0'));
        expect(log1.tags, contains('FunctionStart'));
        expect(log2.tags, contains('id:1'));
        expect(log2.tags, contains('FunctionStart'));

        final msg = log2.warn(title: 'Test message', message: 'Test');

        expect(msg.tags, contains('FunctionStart'));
        expect(msg.tags, contains('func:testFunc2'));
        expect(msg.tags, contains('class:LoggingMock'));
      });
    });

    group('Log tests', () {
      test('Creating a log with valid id and session should not throw an error',
          () {
        expect(() => const Log(id: 1, session: '123'), returnsNormally);
      });

      test('Creating a log with negative id should throw an error', () {
        expect(() => Log(id: -1), throwsA(isA<AssertionError>()));
      });

      test('Creating a log without session and parent should throw an error',
          () {
        expect(() => Log(id: 1), throwsA(isA<AssertionError>()));
      });

      test('Log session should be inherited from parent if not defined', () {
        const parent = Log(id: 1, session: 'parent_session');
        const child = Log(id: 2, parent: parent);
        expect(child.session, equals('parent_session'));
      });

      test('Log tags should contain session and id', () {
        const log = Log(id: 1, session: 'test_session');
        expect(log.tags, containsAll(['session:test_session', 'id:1']));
      });

      test('Log tags should not contain null session', () {
        const log = Log(id: 1, parent: Log(id: 2, session: 'parent_session'));
        expect(log.tags, isNot(contains('session:null')));
        expect(log.tags, contains('session:parent_session'));
      });
    });
  });
}

class LoggingMock with Logging {}
