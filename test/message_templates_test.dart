import 'package:log_message/logger.dart';
import 'package:test/test.dart';

void main() {
  group('MessageTemplate', () {
    test('Test log method', () {
      const template = MessageTemplate(tags: ['tag1', 'tag2']);
      final message =
          template.log(title: 'Test title', message: 'Test message');
      expect(message.title, equals('Test title'));
      expect(message.text, equals('Test message'));
      expect(message.level, equals(0));
      expect(message.tags, equals(contains('tag1')));
      expect(message.tags, equals(contains('tag2')));
      expect(message.tags, equals(hasLength(2)));
      expect(message.templateValues, equals({}));
    });

    test('Test child method', () {
      const parentTemplate = MessageTemplate(tags: ['tag1', 'tag2']);
      final childTemplate = parentTemplate.child(tags: ['tag3']);
      expect(childTemplate.tags, equals(['tag1', 'tag2', 'tag3']));
    });

    test('child() should inherit template values from parent', () {
      const parent = MessageTemplate(tags: ['parent']);
      final child = parent.child(tags: ['child']);

      expect(child.tags, ['parent', 'child']);
    });

    test('log() should create a log message with the template values', () {
      const template = MessageTemplate(
        tags: ['test'],
        klasse: 'TestClass',
        function: 'testFunction',
      );

      final message = template.log(title: 'Test message');

      expect(message.type, equals(MessageType.log));
      expect(message.title, equals('Test message'));

      expect(message.tags.length, equals(1));
      expect(message.tags, contains('test'));
      expect(message.sourceClass, equals('TestClass'));
      expect(message.sourceFunction, equals('testFunction'));
    });

    test('Test creating a message with a child template', () {
      const template = MessageTemplate(tags: ['Test']);
      final message = template.log(title: 'Test message', message: 'Test');
      expect(message.tags, contains('Test'));
    });

    test('Test creating a message with a child template and class', () {
      final template = MessageTemplate(klasse: Logger());
      final message = template.log(title: 'Test message', message: 'Test');
      expect(message.sourceClass, contains('Logger'));
    });

    group('klasse(Object klasse)', () {
      test('Test creating a message with klasse() method', () {
        const template = MessageTemplate();
        final message = template
            .klasse('Logger')
            .log(title: 'Test message', message: 'Test');
        expect(message.sourceClass, equals('Logger'));
      });

      test('Test creating a message with klasse() method and class', () {
        const template = MessageTemplate();
        final message = template
            .klasse(Logger())
            .log(title: 'Test message', message: 'Test');
        expect(message.sourceClass, equals('Logger'));
      });

      test('Test creating a message with a child template and class', () {
        final template = MessageTemplate(klasse: Logger());
        final message = template.log(title: 'Test message', message: 'Test');
        expect(message.sourceClass, equals('Logger'));
      });

      test('klasse() should override the parent template', () {
        final parent = MessageTemplate(klasse: Logger());
        final child = parent.klasse(Object());
        final message = child.log(title: 'Test message', message: 'Test');
        expect(message.sourceClass, equals('Object'));
      });
    });

    group('function(String function)', () {
      test('Test creating a message with function() method', () {
        const template = MessageTemplate();
        final message = template
            .function('testFunction')
            .log(title: 'Test message', message: 'Test');
        expect(message.sourceFunction, equals('testFunction'));
      });

      test('Test creating a message with function() method and class', () {
        const template = MessageTemplate();
        final message = template
            .function('testFunction')
            .klasse(Logger())
            .log(title: 'Test message', message: 'Test');
        expect(message.sourceFunction, equals('testFunction'));
        expect(message.sourceClass, equals('Logger'));
      });

      test('function() should override value of the parent template', () {
        const parent = MessageTemplate(function: 'parentFunction');
        final child = parent.function('childFunction');
        final message = child.log(title: 'Test message', message: 'Test');
        expect(message.sourceFunction, equals('childFunction'));
      });
    });

    group('logMessage - devLog', () {
      group('Logger.logMessage()', () {
        test('logMessage() sends message to developer if devLog is true', () {
          final message = Message.log(
            title: 'Test message',
            text: 'Test text',
            log: false,
          );
          Logger().logMessage(message, devLog: true);
        });
      });
    });
  });
}
