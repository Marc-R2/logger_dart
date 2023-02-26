import 'package:log_message/logger.dart';
import 'package:test/test.dart';

Future<void> main() async {
  setUp(Logger.test);
  final tags = '[runtime:${Logging.runtimeSession}]';

  group('Testing Message class util/message.dart - Templates', () {
    group('templates', () {
      group('templates in titles', () {
        group('templates.title.Log', () {
          test('templates.title.Log normal', () {
            final message = Message.log(
              title: 'logName - {name}',
              level: 2,
              templateValues: {'name': 'John'},
            );

            expect(
              message.toString(),
              'TestMode: 2 Log: logName - John:(2) $tags',
            );
            expect(
              message.toString(time: false),
              'Log: logName - John:(2) $tags',
            );
            expect(
              message.toString(time: false, type: false),
              'logName - John:(2) $tags',
            );
            expect(
              message.toString(time: false, type: false, level: false),
              'logName - John: $tags',
            );
            expect(
              message.toString(type: false, level: false, title: false),
              'TestMode: 2 $tags',
            );
          });

          test('templates.title.Log no template', () {
            final message = Message.log(
              title: 'logName',
              level: 3,
            );

            expect(
              message.toString(),
              'TestMode: 2 Log: logName:(3) $tags',
            );
            expect(
              message.toString(time: false),
              'Log: logName:(3) $tags',
            );
            expect(
              message.toString(time: false, type: false),
              'logName:(3) $tags',
            );
            expect(
              message.toString(time: false, type: false, level: false),
              'logName: $tags',
            );
            expect(
              message.toString(time: false, level: false, title: false),
              'Log: $tags',
            );
          });

          test('templates.title.Log no template value', () {
            final message = Message.log(
              title: 'logName - {name}',
              level: 4,
            );

            expect(
              message.toString(),
              'TestMode: 2 Log: logName - <name>:(4) $tags',
            );
            expect(
              message.toString(time: false),
              'Log: logName - <name>:(4) $tags',
            );
            expect(
              message.toString(time: false, type: false),
              'logName - <name>:(4) $tags',
            );
            expect(
              message.toString(time: false, type: false, level: false),
              'logName - <name>: $tags',
            );
            expect(
              message.toString(time: false, type: false, title: false),
              '(4) $tags',
            );
          });

          test('templates.title.Log nested', () {
            final message = Message.log(
              title: 'logName - {na{dyn}}',
              level: 5,
              templateValues: {'name': 'John', 'dyn': 'me'},
            );

            expect(
              message.toString(),
              'TestMode: 2 Log: logName - John:(5) $tags',
            );
            expect(
              message.toString(time: false),
              'Log: logName - John:(5) $tags',
            );
            expect(
              message.toString(time: false, type: false),
              'logName - John:(5) $tags',
            );
            expect(
              message.toString(time: false, type: false, level: false),
              'logName - John: $tags',
            );
            expect(
              message.toString(time: false, type: false, title: false),
              '(5) $tags',
            );
          });
        });
      });

      group('templates in texts', () {
        group('templates.text.Log', () {
          test('templates.text.Log normal', () {
            final message = Message.log(
              title: 'logName',
              text: 'logText ({name})',
              level: 5,
              templateValues: {'name': 'John'},
            );

            expect(
              message.toString(),
              'TestMode: 2 Log: logName:(5) $tags => logText (John)',
            );
            expect(
              message.toString(time: false),
              'Log: logName:(5) $tags => logText (John)',
            );
            expect(
              message.toString(time: false, type: false),
              'logName:(5) $tags => logText (John)',
            );
            expect(
              message.toString(time: false, type: false, level: false),
              'logName: $tags => logText (John)',
            );
            expect(
              message.toString(time: false, type: false, title: false),
              '(5) $tags => logText (John)',
            );
            expect(
              message.toString(type: false, title: false, level: false),
              'TestMode: 2 $tags => logText (John)',
            );
          });

          test('templates.text.Log missing key', () {
            final message = Message.log(
              title: 'logName',
              text: 'logText ({name})',
              level: 5,
            );

            expect(
              message.toString(),
              'TestMode: 2 Log: logName:(5) $tags => logText (<name>)',
            );
            expect(
              message.toString(time: false),
              'Log: logName:(5) $tags => logText (<name>)',
            );
            expect(
              message.toString(time: false, type: false),
              'logName:(5) $tags => logText (<name>)',
            );
            expect(
              message.toString(time: false, type: false, level: false),
              'logName: $tags => logText (<name>)',
            );
            expect(
              message.toString(time: false, type: false, title: false),
              '(5) $tags => logText (<name>)',
            );
          });

          test('templates.text.Log multiple keys', () {
            final message = Message.log(
              title: 'logName',
              text: 'logText ({name}, {age})',
              level: 5,
              templateValues: {'name': 'John', 'age': '30'},
            );

            expect(
              message.toString(),
              'TestMode: 2 Log: logName:(5) $tags => logText (John, 30)',
            );
            expect(
              message.toString(time: false),
              'Log: logName:(5) $tags => logText (John, 30)',
            );
            expect(
              message.toString(time: false, type: false),
              'logName:(5) $tags => logText (John, 30)',
            );
            expect(
              message.toString(time: false, type: false, level: false),
              'logName: $tags => logText (John, 30)',
            );
            expect(
              message.toString(time: false, type: false, title: false),
              '(5) $tags => logText (John, 30)',
            );
          });

          test('templates.text.Log too many keys', () {
            final message = Message.log(
              title: 'logName',
              text: 'logText ({name})',
              level: 5,
              templateValues: {'name': 'John', 'age': '30'},
            );

            expect(
              message.toString(),
              'TestMode: 2 Log: logName:(5) $tags => logText (John)',
            );
            expect(
              message.toString(time: false),
              'Log: logName:(5) $tags => logText (John)',
            );
            expect(
              message.toString(time: false, type: false),
              'logName:(5) $tags => logText (John)',
            );
            expect(
              message.toString(time: false, type: false, level: false),
              'logName: $tags => logText (John)',
            );
            expect(
              message.toString(time: false, type: false, title: false),
              '(5) $tags => logText (John)',
            );
          });

          test('templates.text.Log empty key', () {
            final message = Message.log(
              title: 'logName',
              text: 'logText ({})',
              level: 5,
              templateValues: {'': 'John'},
            );

            expect(
              message.toString(),
              'TestMode: 2 Log: logName:(5) $tags => logText ({})',
            );
            expect(
              message.toString(time: false),
              'Log: logName:(5) $tags => logText ({})',
            );
            expect(
              message.toString(time: false, type: false),
              'logName:(5) $tags => logText ({})',
            );
            expect(
              message.toString(time: false, type: false, level: false),
              'logName: $tags => logText ({})',
            );
            expect(
              message.toString(time: false, type: false, title: false),
              '(5) $tags => logText ({})',
            );
            expect(
              message.toString(type: false, title: false, level: false),
              'TestMode: 2 $tags => logText ({})',
            );
          });
        });

        group('templates.text.Info', () {
          test('templates.text.Info normal', () {
            final message = Message.info(
              title: 'infoName',
              text: 'infoText ({name})',
              level: 9,
              templateValues: {'name': 'John'},
            );

            expect(
              message.toString(),
              'TestMode: 2 Info: infoName:(9) $tags => infoText (John)',
            );
            expect(
              message.toString(time: false),
              'Info: infoName:(9) $tags => infoText (John)',
            );
            expect(
              message.toString(time: false, type: false),
              'infoName:(9) $tags => infoText (John)',
            );
            expect(
              message.toString(time: false, type: false, level: false),
              'infoName: $tags => infoText (John)',
            );
            expect(
              message.toString(time: false, type: false, title: false),
              '(9) $tags => infoText (John)',
            );
            expect(
              message.toString(type: false, title: false, level: false),
              'TestMode: 2 $tags => infoText (John)',
            );
          });

          test('templates.text.Info missing key', () {
            final message = Message.info(
              title: 'infoName',
              text: 'infoText ({name})',
              level: 9,
            );

            expect(
              message.toString(),
              'TestMode: 2 Info: infoName:(9) $tags => infoText (<name>)',
            );
            expect(
              message.toString(time: false),
              'Info: infoName:(9) $tags => infoText (<name>)',
            );
            expect(
              message.toString(time: false, type: false),
              'infoName:(9) $tags => infoText (<name>)',
            );
            expect(
              message.toString(time: false, type: false, level: false),
              'infoName: $tags => infoText (<name>)',
            );
            expect(
              message.toString(time: false, type: false, title: false),
              '(9) $tags => infoText (<name>)',
            );
            expect(
              message.toString(time: false, type: false, text: false),
              'infoName:(9) $tags',
            );
          });

          test('templates.text.Info multiple keys', () {
            final message = Message.info(
              title: 'infoName',
              text: 'infoText ({name}, {age})',
              level: 9,
              templateValues: {'name': 'John', 'age': '30'},
            );

            expect(
              message.toString(),
              'TestMode: 2 Info: infoName:(9) $tags => infoText (John, 30)',
            );
            expect(
              message.toString(time: false),
              'Info: infoName:(9) $tags => infoText (John, 30)',
            );
            expect(
              message.toString(time: false, type: false),
              'infoName:(9) $tags => infoText (John, 30)',
            );
            expect(
              message.toString(time: false, type: false, level: false),
              'infoName: $tags => infoText (John, 30)',
            );
            expect(
              message.toString(time: false, type: false, title: false),
              '(9) $tags => infoText (John, 30)',
            );
            expect(
              message.toString(time: false, type: false, text: false),
              'infoName:(9) $tags',
            );
          });

          test('templates.text.Info too many keys', () {
            final message = Message.info(
              title: 'infoName',
              text: 'infoText ({name})',
              level: 9,
              templateValues: {'name': 'John', 'age': '30'},
            );

            expect(
              message.toString(),
              'TestMode: 2 Info: infoName:(9) $tags => infoText (John)',
            );
            expect(
              message.toString(time: false),
              'Info: infoName:(9) $tags => infoText (John)',
            );
            expect(
              message.toString(time: false, type: false),
              'infoName:(9) $tags => infoText (John)',
            );
            expect(
              message.toString(time: false, type: false, level: false),
              'infoName: $tags => infoText (John)',
            );
            expect(
              message.toString(time: false, type: false, title: false),
              '(9) $tags => infoText (John)',
            );
            expect(
              message.toString(time: false, type: false, text: false),
              'infoName:(9) $tags',
            );
          });
        });

        group('templates.text.Warning', () {
          test('templates.text.Warning normal', () {
            final message = Message.warning(
              title: 'warningName',
              text: 'warningText ({name})',
              level: 2,
              templateValues: {'name': 'John'},
            );

            expect(
              message.toString(),
              'TestMode: 2 Warning: warningName:(2) $tags => warningText (John)',
            );
            expect(
              message.toString(time: false),
              'Warning: warningName:(2) $tags => warningText (John)',
            );
            expect(
              message.toString(time: false, type: false),
              'warningName:(2) $tags => warningText (John)',
            );
            expect(
              message.toString(time: false, type: false, level: false),
              'warningName: $tags => warningText (John)',
            );
            expect(
              message.toString(time: false, type: false, title: false),
              '(2) $tags => warningText (John)',
            );
            expect(
              message.toString(type: false, title: false, level: false),
              'TestMode: 2 $tags => warningText (John)',
            );
          });

          test('templates.text.Warning missing key', () {
            final message = Message.warning(
              title: 'warningName',
              text: 'warningText ({name})',
              level: 2,
            );

            expect(
              message.toString(),
              'TestMode: 2 Warning: warningName:(2) $tags => warningText (<name>)',
            );
            expect(
              message.toString(time: false),
              'Warning: warningName:(2) $tags => warningText (<name>)',
            );
            expect(
              message.toString(time: false, type: false),
              'warningName:(2) $tags => warningText (<name>)',
            );
            expect(
              message.toString(time: false, type: false, level: false),
              'warningName: $tags => warningText (<name>)',
            );
            expect(
              message.toString(time: false, type: false, title: false),
              '(2) $tags => warningText (<name>)',
            );
            expect(
              message.toString(time: false, type: false, text: false),
              'warningName:(2) $tags',
            );
          });

          test('templates.text.Warning multiple keys', () {
            final message = Message.warning(
              title: 'warningName',
              text: 'warningText ({name}, {age})',
              level: 2,
              templateValues: {'name': 'John', 'age': '30'},
            );

            expect(
              message.toString(),
              'TestMode: 2 Warning: warningName:(2) $tags => warningText (John, 30)',
            );
            expect(
              message.toString(time: false),
              'Warning: warningName:(2) $tags => warningText (John, 30)',
            );
            expect(
              message.toString(time: false, type: false),
              'warningName:(2) $tags => warningText (John, 30)',
            );
            expect(
              message.toString(time: false, type: false, level: false),
              'warningName: $tags => warningText (John, 30)',
            );
            expect(
              message.toString(time: false, type: false, title: false),
              '(2) $tags => warningText (John, 30)',
            );
            expect(
              message.toString(time: false, type: false, text: false),
              'warningName:(2) $tags',
            );
          });

          test('templates.text.Warning too many keys', () {
            final message = Message.warning(
              title: 'warningName',
              text: 'warningText ({name})',
              level: 2,
              templateValues: {'name': 'John', 'age': '30'},
            );

            expect(
              message.toString(),
              'TestMode: 2 Warning: warningName:(2) $tags => warningText (John)',
            );
            expect(
              message.toString(time: false),
              'Warning: warningName:(2) $tags => warningText (John)',
            );
            expect(
              message.toString(time: false, type: false),
              'warningName:(2) $tags => warningText (John)',
            );
            expect(
              message.toString(time: false, type: false, level: false),
              'warningName: $tags => warningText (John)',
            );
            expect(
              message.toString(time: false, type: false, title: false),
              '(2) $tags => warningText (John)',
            );
            expect(
              message.toString(time: false, type: false, text: false),
              'warningName:(2) $tags',
            );
          });
        });

        group('templates.text.Error', () {
          test('templates.text.Error normal', () {
            final message = Message.error(
              title: 'errorName',
              text: 'errorText ({name})',
              level: 4,
              templateValues: {'name': 'John'},
            );

            expect(
              message.toString(),
              'TestMode: 2 Error: errorName:(4) $tags => errorText (John)',
            );
            expect(
              message.toString(time: false),
              'Error: errorName:(4) $tags => errorText (John)',
            );
            expect(
              message.toString(time: false, type: false),
              'errorName:(4) $tags => errorText (John)',
            );
            expect(
              message.toString(time: false, type: false, level: false),
              'errorName: $tags => errorText (John)',
            );
            expect(
              message.toString(time: false, type: false, title: false),
              '(4) $tags => errorText (John)',
            );
            expect(
              message.toString(type: false, title: false, level: false),
              'TestMode: 2 $tags => errorText (John)',
            );
          });

          test('templates.text.Error missing key', () {
            final message = Message.error(
              title: 'errorName',
              text: 'errorText ({name})',
              level: 4,
            );

            expect(
              message.toString(),
              'TestMode: 2 Error: errorName:(4) $tags => errorText (<name>)',
            );
            expect(
              message.toString(time: false),
              'Error: errorName:(4) $tags => errorText (<name>)',
            );
            expect(
              message.toString(time: false, type: false),
              'errorName:(4) $tags => errorText (<name>)',
            );
            expect(
              message.toString(time: false, type: false, level: false),
              'errorName: $tags => errorText (<name>)',
            );
            expect(
              message.toString(time: false, type: false, title: false),
              '(4) $tags => errorText (<name>)',
            );
            expect(
              message.toString(time: false, type: false, text: false),
              'errorName:(4) $tags',
            );
          });

          test('templates.text.Error multiple keys', () {
            final message = Message.error(
              title: 'errorName',
              text: 'errorText ({name}, {age})',
              level: 4,
              templateValues: {'name': 'John', 'age': '30'},
            );

            expect(
              message.toString(),
              'TestMode: 2 Error: errorName:(4) $tags => errorText (John, 30)',
            );
            expect(
              message.toString(time: false),
              'Error: errorName:(4) $tags => errorText (John, 30)',
            );
            expect(
              message.toString(time: false, type: false),
              'errorName:(4) $tags => errorText (John, 30)',
            );
            expect(
              message.toString(time: false, type: false, level: false),
              'errorName: $tags => errorText (John, 30)',
            );
            expect(
              message.toString(time: false, type: false, title: false),
              '(4) $tags => errorText (John, 30)',
            );
            expect(
              message.toString(time: false, type: false, text: false),
              'errorName:(4) $tags',
            );
          });

          test('templates.text.Error too many keys', () {
            final message = Message.error(
              title: 'errorName',
              text: 'errorText ({name})',
              level: 4,
              templateValues: {'name': 'John', 'age': '30'},
            );

            expect(
              message.toString(),
              'TestMode: 2 Error: errorName:(4) $tags => errorText (John)',
            );
            expect(
              message.toString(time: false),
              'Error: errorName:(4) $tags => errorText (John)',
            );
            expect(
              message.toString(time: false, type: false),
              'errorName:(4) $tags => errorText (John)',
            );
            expect(
              message.toString(time: false, type: false, level: false),
              'errorName: $tags => errorText (John)',
            );
            expect(
              message.toString(time: false, type: false, title: false),
              '(4) $tags => errorText (John)',
            );
            expect(
              message.toString(time: false, type: false, text: false),
              'errorName:(4) $tags',
            );
          });
        });
      });
    });
  });
}
