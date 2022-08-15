import 'package:logger/logger.dart';
import 'package:test/test.dart';

Future<void> main() async {
  group('Testing Message class util/message.dart', () {
    late Message log;
    late Message info;
    late Message warning;
    late Message error;

    setUp(() {
      log = Message.log(title: 'logName', text: 'logText', level: 5);
      info = Message.info(title: 'infoName', text: 'infoText', level: 9);
      warning =
          Message.warning(title: 'warningName', text: 'warningText', level: 2);
      error = Message.error(title: 'errorName', text: 'errorText', level: 4);
    });

    group('<fields>', () {
      group('log', () {
        test('log name', () => expect(log.title, 'logName'));
        test('log text', () => expect(log.text, 'logText'));
        test('log level', () => expect(log.level, 5));
        test('log type', () => expect(log.type, 0));
      });
      group('info', () {
        test('info name', () => expect(info.title, 'infoName'));
        test('info text', () => expect(info.text, 'infoText'));
        test('info level', () => expect(info.level, 9));
        test('info type', () => expect(info.type, 1));
      });
      group('warning', () {
        test('warning name', () => expect(warning.title, 'warningName'));
        test('warning text', () => expect(warning.text, 'warningText'));
        test('warning level', () => expect(warning.level, 2));
        test('warning type', () => expect(warning.type, 2));
      });
      group('error', () {
        test('error name', () => expect(error.title, 'errorName'));
        test('error text', () => expect(error.text, 'errorText'));
        test('error level', () => expect(error.level, 4));
        test('error type', () => expect(error.type, 3));
      });
    });
  });
}
