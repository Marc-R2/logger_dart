import 'package:log_message/logger.dart';
import 'package:test/test.dart';

Future<void> main() async {
  group('Testing Message class util/message.dart - Fields', () {
    setUp(Logger.test);
    final startTime = DateTime.now();
    final stMC = startTime.microsecondsSinceEpoch;

    group('removeCurlyBrackets', () {
      test('char', () {
        expect(Message.removeCurlyBrackets(''), '');
        expect(Message.removeCurlyBrackets('a'), 'a');
        expect(Message.removeCurlyBrackets('b'), 'b');
        expect(Message.removeCurlyBrackets('{'), '');
        expect(Message.removeCurlyBrackets('}'), '');
      });

      test('word', () {
        expect(Message.removeCurlyBrackets('word'), 'word');
        expect(Message.removeCurlyBrackets('{word'), 'word');
        expect(Message.removeCurlyBrackets('word}'), 'word');
        expect(Message.removeCurlyBrackets('{word}'), 'word');
        expect(Message.removeCurlyBrackets('wo{rd'), 'word');
        expect(Message.removeCurlyBrackets('wo}rd'), 'word');
        expect(Message.removeCurlyBrackets('wo{rd}'), 'word');
        expect(Message.removeCurlyBrackets('{wo}rd'), 'word');
        expect(Message.removeCurlyBrackets('{wo}rd{'), 'word');
        expect(Message.removeCurlyBrackets('{wo}rd}'), 'word');
        expect(Message.removeCurlyBrackets('{wo}{rd}'), 'word');
      });

      test('sentence', () {
        expect(
          Message.removeCurlyBrackets('This is a {test} with {curly} brackets'),
          'This is a test with curly brackets',
        );
      });
    });

    group('<fields>', () {
      late Message log;
      late Message info;
      late Message warning;
      late Message error;
      late Message trace;

      setUp(() {
        log = Message.log(
          title: 'logName',
          text: 'logText',
          level: 5,
        );

        info = Message.info(
          title: 'infoName',
          text: 'infoText',
          level: 9,
        );

        warning = Message.warning(
          title: 'warningName',
          text: 'warningText',
          level: 2,
        );

        error = Message.error(
          title: 'errorName',
          text: 'errorText',
          level: 4,
        );

        trace = Message.trace(
          title: 'traceName',
          text: 'traceText',
          level: 1,
        );
      });

      group('log', () {
        test('log name', () => expect(log.title, 'logName'));
        test('log text', () => expect(log.text, 'logText'));
        test('log level', () => expect(log.level, 5));
        test('log type', () => expect(log.type, 0));
        test('log time', () => expect(log.timeMC, greaterThan(stMC)));
        test('log test', () => expect(log.testModeCount, 2));
      });
      group('info', () {
        test('info name', () => expect(info.title, 'infoName'));
        test('info text', () => expect(info.text, 'infoText'));
        test('info level', () => expect(info.level, 9));
        test('info type', () => expect(info.type, 1));
        test('info time', () => expect(info.timeMC, greaterThan(stMC)));
        test('info test', () => expect(info.testModeCount, 3));
      });
      group('warning', () {
        test('warning name', () => expect(warning.title, 'warningName'));
        test('warning text', () => expect(warning.text, 'warningText'));
        test('warning level', () => expect(warning.level, 2));
        test('warning type', () => expect(warning.type, 2));
        test('warning time', () => expect(warning.timeMC, greaterThan(stMC)));
        test('warning test', () => expect(warning.testModeCount, 4));
      });
      group('error', () {
        test('error name', () => expect(error.title, 'errorName'));
        test('error text', () => expect(error.text, 'errorText'));
        test('error level', () => expect(error.level, 4));
        test('error type', () => expect(error.type, 3));
        test('error time', () => expect(error.timeMC, greaterThan(stMC)));
        test('error test', () => expect(error.testModeCount, 5));
      });
      group('trace', () {
        test('trace name', () => expect(trace.title, 'traceName'));
        test('trace text', () => expect(trace.text, 'traceText'));
        test('trace level', () => expect(trace.level, 1));
        test('trace type', () => expect(trace.type, 9));
        test('trace time', () => expect(trace.timeMC, greaterThan(stMC)));
        test('trace test', () => expect(trace.testModeCount, 6));
      });
    });

    group('fromMap', () {
      test('fromMap creates a valid message from a valid map', () {
        final testMap = <String, dynamic>{
          'title': 'Test Title',
          'text': 'Test Text',
          'time': 563536000000,
          'level': 2,
          'type': 3,
          'templates': {'key': 'value'},
          'tags': ['tag1', 'tag2']
        };
        final message = Message.fromMap(testMap);
        expect(message.title, 'Test Title');
        expect(message.text, 'Test Text');
        expect(message.time, DateTime.fromMillisecondsSinceEpoch(563536000000));
        expect(message.level, 2);
        expect(message.type, 3);
        expect(message.templateValues, {'key': 'value'});
        expect(message.tags, ['tag1', 'tag2']);
      });

      test('fromMap when an invalid(empty) map is passed', () {
        final testMap = <dynamic, dynamic>{};
        final message = Message.fromMap(testMap);
        expect(message.title, 'Error');
        expect(message.text, '');
        expect(message.time, isNot(null));
        expect(message.level, 0);
        expect(message.type, 0);
        expect(message.templateValues, isEmpty);
        expect(message.tags, isEmpty);
      });

      test('fromMap error message when invalid data types are passed', () {
        final testMap = <dynamic, dynamic>{
          'title': 'Test Title',
          'text': 'Test Text',
          'time': 'invalid time',
          'level': 'invalid level',
          'type': 'invalid type',
          'templates': 'invalid templates',
          'tags': 'invalid tags'
        };
        try {
          Message.fromMap(testMap);
          fail('Expected exception to be thrown');
        } catch (e) {
          expect(e, isA<TypeError>());
        }
      });
    });

    group('toMap', () {
      final message = Message.log(
        title: 'Test Title',
        text: 'Test Text',
        level: 2,
        tags: ['tag1', 'tag2'],
      );

      test('toMap and fromMap with no data loss', () {
        final map = message.toMap();
        final messageFromMap = Message.fromMap(map);
        expect(messageFromMap.title, message.title);
        expect(messageFromMap.text, message.text);
        expect(messageFromMap.timeMS, message.timeMS);
        expect(messageFromMap.level, message.level);
        expect(messageFromMap.type, message.type);
        expect(messageFromMap.templateValues, message.templateValues);
        expect(messageFromMap.tags, message.tags);
      });

      test('toMap returns a map with all required fields', () {
        final map = message.toMap();
        expect(map.containsKey('title'), true);
        expect(map.containsKey('text'), true);
        expect(map.containsKey('time'), true);
        expect(map.containsKey('level'), true);
        expect(map.containsKey('type'), true);
        expect(map.containsKey('templates'), true);
        expect(map.containsKey('tags'), true);
      });

      test('toMap returns a map with all fields in the correct data type', () {
        final map = message.toMap();
        expect(map['title'], isA<String>());
        expect(map['text'], isA<String>());
        expect(map['time'], isA<int>());
        expect(map['level'], isA<int>());
        expect(map['type'], isA<int>());
        expect(map['templates'], isA<Map>());
        expect(map['tags'], isA<List>());
      });
    });

    group('stackTrace', () {
      final stackTrace = StackTrace.fromString('Stack Trace');

      test('StackTrace is added to message correctly', () {
        final message = Message.error(
          title: 'Test Title',
          text: 'Test Text',
          level: 2,
          stackTrace: stackTrace,
        );
        expect(message.stackTrace, stackTrace);
      });

      test('StackTrace is saved and loaded correctly in map', () {
        final message = Message.error(
          title: 'Test Title',
          text: 'Test Text',
          level: 2,
          stackTrace: stackTrace,
        );
        final map = message.toMap();
        expect(map['stackTrace'], isNull);
        final messageFromMap = Message.fromMap(map);
        expect(messageFromMap.stackTrace, isNull);
      });

      test('Message is created with stack trace without any issues', () {
        final message = Message.error(
          title: 'Test Title',
          text: 'Test Text',
          level: 2,
          stackTrace: stackTrace,
        );
        expect(message.title, 'Test Title');
        expect(message.text, 'Test Text');
        expect(message.level, 2);
        expect(message.stackTrace, stackTrace);
      });

      test('StackTrace is not present in map if not passed', () {
        final message = Message.error(
          title: 'Test Title',
          text: 'Test Text',
          level: 2,
        );
        final map = message.toMap();
        expect(map.containsKey('stackTrace'), false);
      });
    });

    group('klasse', () {
      test('Class is added to tags correctly', () {
        final message = Message.error(
          title: 'Test Title',
          text: 'Test Text',
          level: 2,
          klasse: 'Message',
        );
        expect(message.tags, contains('class:Message'));
      });

      test('Class is saved and loaded correctly in map', () {
        final message = Message.error(
          title: 'Test Title',
          text: 'Test Text',
          level: 2,
          klasse: Logger(),
        );
        final map = message.toMap();
        expect(map['tags'], contains('class:Logger'));
        final messageFromMap = Message.fromMap(map);
        expect(messageFromMap.tags, contains('class:Logger'));
      });

      test('Class is not added to tags if not passed', () {
        final message = Message.error(
          title: 'Test Title',
          text: 'Test Text',
          level: 2,
        );
        expect(message.tags, isNot(contains('class:Any')));
      });

      test('Class is not present in map if not passed', () {
        final message = Message.error(
          title: 'Test Title',
          text: 'Test Text',
          level: 2,
        );
        final map = message.toMap();
        expect(map.containsKey('tags'), true);
        expect(map['tags'], isNot(contains('class:MyClass')));
      });
    });

    group('function', () {
      test('Class is added to tags correctly', () {
        final message = Message.error(
          title: 'Test Title',
          text: 'Test Text',
          level: 2,
          function: 'my_function',
        );
        expect(message.tags, contains('func:my_function'));
      });

      test('Class is saved and loaded correctly in map', () {
        final message = Message.error(
          title: 'Test Title',
          text: 'Test Text',
          level: 2,
          function: 'my_function',
        );
        final map = message.toMap();
        expect(map['tags'], contains('func:my_function'));
        final messageFromMap = Message.fromMap(map);
        expect(messageFromMap.tags, contains('func:my_function'));
      });

      test('Class is not added to tags if not passed', () {
        final message = Message.error(
          title: 'Test Title',
          text: 'Test Text',
          level: 2,
        );
        expect(message.tags, isNot(contains('func:my_function')));
      });

      test('Class is not present in map if not passed', () {
        final message = Message.error(
          title: 'Test Title',
          text: 'Test Text',
          level: 2,
        );
        final map = message.toMap();
        expect(map.containsKey('tags'), true);
        expect(map['tags'], isNot(contains('func:my_function')));
      });
    });
  });
}
