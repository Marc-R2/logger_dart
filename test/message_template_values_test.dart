import 'package:log_message/logger.dart';
import 'package:test/test.dart';

Future<void> main() async {
  setUp(Logger.test);

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
              'TestMode: 2 Log: logName - John:(2)',
            );
            expect(
              message.toString(time: false),
              'Log: logName - John:(2)',
            );
            expect(
              message.toString(time: false, type: false),
              'logName - John:(2)',
            );
            expect(
              message.toString(time: false, type: false, level: false),
              'logName - John',
            );
            expect(
              message.toString(type: false, level: false, title: false),
              'TestMode: 2',
            );
          });

          test('templates.title.Log no template', () {
            final message = Message.log(
              title: 'logName',
              level: 3,
            );

            expect(
              message.toString(),
              'TestMode: 2 Log: logName:(3)',
            );
            expect(
              message.toString(time: false),
              'Log: logName:(3)',
            );
            expect(
              message.toString(time: false, type: false),
              'logName:(3)',
            );
            expect(
              message.toString(time: false, type: false, level: false),
              'logName',
            );
            expect(
              message.toString(time: false, level: false, title: false),
              'Log:',
            );
          });

          test('templates.title.Log no template value', () {
            final message = Message.log(
              title: 'logName - {name}',
              level: 4,
            );

            expect(
              message.toString(),
              'TestMode: 2 Log: logName - <name>:(4)',
            );
            expect(
              message.toString(time: false),
              'Log: logName - <name>:(4)',
            );
            expect(
              message.toString(time: false, type: false),
              'logName - <name>:(4)',
            );
            expect(
              message.toString(time: false, type: false, level: false),
              'logName - <name>',
            );
            expect(
              message.toString(time: false, type: false, title: false),
              '(4)',
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
              'TestMode: 2 Log: logName - John:(5)',
            );
            expect(
              message.toString(time: false),
              'Log: logName - John:(5)',
            );
            expect(
              message.toString(time: false, type: false),
              'logName - John:(5)',
            );
            expect(
              message.toString(time: false, type: false, level: false),
              'logName - John',
            );
            expect(
              message.toString(time: false, type: false, title: false),
              '(5)',
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
              'TestMode: 2 Log: logName:(5) => logText (John)',
            );
            expect(
              message.toString(time: false),
              'Log: logName:(5) => logText (John)',
            );
            expect(
              message.toString(time: false, type: false),
              'logName:(5) => logText (John)',
            );
            expect(
              message.toString(time: false, type: false, level: false),
              'logName => logText (John)',
            );
            expect(
              message.toString(time: false, type: false, title: false),
              '(5) => logText (John)',
            );
            expect(
              message.toString(type: false, title: false, level: false),
              'TestMode: 2 => logText (John)',
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
              'TestMode: 2 Log: logName:(5) => logText (<name>)',
            );
            expect(
              message.toString(time: false),
              'Log: logName:(5) => logText (<name>)',
            );
            expect(
              message.toString(time: false, type: false),
              'logName:(5) => logText (<name>)',
            );
            expect(
              message.toString(time: false, type: false, level: false),
              'logName => logText (<name>)',
            );
            expect(
              message.toString(time: false, type: false, title: false),
              '(5) => logText (<name>)',
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
              'TestMode: 2 Log: logName:(5) => logText (John, 30)',
            );
            expect(
              message.toString(time: false),
              'Log: logName:(5) => logText (John, 30)',
            );
            expect(
              message.toString(time: false, type: false),
              'logName:(5) => logText (John, 30)',
            );
            expect(
              message.toString(time: false, type: false, level: false),
              'logName => logText (John, 30)',
            );
            expect(
              message.toString(time: false, type: false, title: false),
              '(5) => logText (John, 30)',
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
              'TestMode: 2 Log: logName:(5) => logText (John)',
            );
            expect(
              message.toString(time: false),
              'Log: logName:(5) => logText (John)',
            );
            expect(
              message.toString(time: false, type: false),
              'logName:(5) => logText (John)',
            );
            expect(
              message.toString(time: false, type: false, level: false),
              'logName => logText (John)',
            );
            expect(
              message.toString(time: false, type: false, title: false),
              '(5) => logText (John)',
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
              'TestMode: 2 Info: infoName:(9) => infoText (John)',
            );
            expect(
              message.toString(time: false),
              'Info: infoName:(9) => infoText (John)',
            );
            expect(
              message.toString(time: false, type: false),
              'infoName:(9) => infoText (John)',
            );
            expect(
              message.toString(time: false, type: false, level: false),
              'infoName => infoText (John)',
            );
            expect(
              message.toString(time: false, type: false, title: false),
              '(9) => infoText (John)',
            );
            expect(
              message.toString(type: false, title: false, level: false),
              'TestMode: 2 => infoText (John)',
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
              'TestMode: 2 Info: infoName:(9) => infoText (<name>)',
            );
            expect(
              message.toString(time: false),
              'Info: infoName:(9) => infoText (<name>)',
            );
            expect(
              message.toString(time: false, type: false),
              'infoName:(9) => infoText (<name>)',
            );
            expect(
              message.toString(time: false, type: false, level: false),
              'infoName => infoText (<name>)',
            );
            expect(
              message.toString(time: false, type: false, title: false),
              '(9) => infoText (<name>)',
            );
            expect(
              message.toString(time: false, type: false, text: false),
              'infoName:(9)',
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
              'TestMode: 2 Info: infoName:(9) => infoText (John, 30)',
            );
            expect(
              message.toString(time: false),
              'Info: infoName:(9) => infoText (John, 30)',
            );
            expect(
              message.toString(time: false, type: false),
              'infoName:(9) => infoText (John, 30)',
            );
            expect(
              message.toString(time: false, type: false, level: false),
              'infoName => infoText (John, 30)',
            );
            expect(
              message.toString(time: false, type: false, title: false),
              '(9) => infoText (John, 30)',
            );
            expect(
              message.toString(time: false, type: false, text: false),
              'infoName:(9)',
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
              'TestMode: 2 Info: infoName:(9) => infoText (John)',
            );
            expect(
              message.toString(time: false),
              'Info: infoName:(9) => infoText (John)',
            );
            expect(
              message.toString(time: false, type: false),
              'infoName:(9) => infoText (John)',
            );
            expect(
              message.toString(time: false, type: false, level: false),
              'infoName => infoText (John)',
            );
            expect(
              message.toString(time: false, type: false, title: false),
              '(9) => infoText (John)',
            );
            expect(
              message.toString(time: false, type: false, text: false),
              'infoName:(9)',
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
              'TestMode: 2 Warning: warningName:(2) => warningText (John)',
            );
            expect(
              message.toString(time: false),
              'Warning: warningName:(2) => warningText (John)',
            );
            expect(
              message.toString(time: false, type: false),
              'warningName:(2) => warningText (John)',
            );
            expect(
              message.toString(time: false, type: false, level: false),
              'warningName => warningText (John)',
            );
            expect(
              message.toString(time: false, type: false, title: false),
              '(2) => warningText (John)',
            );
            expect(
              message.toString(type: false, title: false, level: false),
              'TestMode: 2 => warningText (John)',
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
              'TestMode: 2 Warning: warningName:(2) => warningText (<name>)',
            );
            expect(
              message.toString(time: false),
              'Warning: warningName:(2) => warningText (<name>)',
            );
            expect(
              message.toString(time: false, type: false),
              'warningName:(2) => warningText (<name>)',
            );
            expect(
              message.toString(time: false, type: false, level: false),
              'warningName => warningText (<name>)',
            );
            expect(
              message.toString(time: false, type: false, title: false),
              '(2) => warningText (<name>)',
            );
            expect(
              message.toString(time: false, type: false, text: false),
              'warningName:(2)',
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
              'TestMode: 2 Warning: warningName:(2) => warningText (John, 30)',
            );
            expect(
              message.toString(time: false),
              'Warning: warningName:(2) => warningText (John, 30)',
            );
            expect(
              message.toString(time: false, type: false),
              'warningName:(2) => warningText (John, 30)',
            );
            expect(
              message.toString(time: false, type: false, level: false),
              'warningName => warningText (John, 30)',
            );
            expect(
              message.toString(time: false, type: false, title: false),
              '(2) => warningText (John, 30)',
            );
            expect(
              message.toString(time: false, type: false, text: false),
              'warningName:(2)',
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
              'TestMode: 2 Warning: warningName:(2) => warningText (John)',
            );
            expect(
              message.toString(time: false),
              'Warning: warningName:(2) => warningText (John)',
            );
            expect(
              message.toString(time: false, type: false),
              'warningName:(2) => warningText (John)',
            );
            expect(
              message.toString(time: false, type: false, level: false),
              'warningName => warningText (John)',
            );
            expect(
              message.toString(time: false, type: false, title: false),
              '(2) => warningText (John)',
            );
            expect(
              message.toString(time: false, type: false, text: false),
              'warningName:(2)',
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
              'TestMode: 2 Error: errorName:(4) => errorText (John)',
            );
            expect(
              message.toString(time: false),
              'Error: errorName:(4) => errorText (John)',
            );
            expect(
              message.toString(time: false, type: false),
              'errorName:(4) => errorText (John)',
            );
            expect(
              message.toString(time: false, type: false, level: false),
              'errorName => errorText (John)',
            );
            expect(
              message.toString(time: false, type: false, title: false),
              '(4) => errorText (John)',
            );
            expect(
              message.toString(type: false, title: false, level: false),
              'TestMode: 2 => errorText (John)',
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
              'TestMode: 2 Error: errorName:(4) => errorText (<name>)',
            );
            expect(
              message.toString(time: false),
              'Error: errorName:(4) => errorText (<name>)',
            );
            expect(
              message.toString(time: false, type: false),
              'errorName:(4) => errorText (<name>)',
            );
            expect(
              message.toString(time: false, type: false, level: false),
              'errorName => errorText (<name>)',
            );
            expect(
              message.toString(time: false, type: false, title: false),
              '(4) => errorText (<name>)',
            );
            expect(
              message.toString(time: false, type: false, text: false),
              'errorName:(4)',
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
              'TestMode: 2 Error: errorName:(4) => errorText (John, 30)',
            );
            expect(
              message.toString(time: false),
              'Error: errorName:(4) => errorText (John, 30)',
            );
            expect(
              message.toString(time: false, type: false),
              'errorName:(4) => errorText (John, 30)',
            );
            expect(
              message.toString(time: false, type: false, level: false),
              'errorName => errorText (John, 30)',
            );
            expect(
              message.toString(time: false, type: false, title: false),
              '(4) => errorText (John, 30)',
            );
            expect(
              message.toString(time: false, type: false, text: false),
              'errorName:(4)',
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
              'TestMode: 2 Error: errorName:(4) => errorText (John)',
            );
            expect(
              message.toString(time: false),
              'Error: errorName:(4) => errorText (John)',
            );
            expect(
              message.toString(time: false, type: false),
              'errorName:(4) => errorText (John)',
            );
            expect(
              message.toString(time: false, type: false, level: false),
              'errorName => errorText (John)',
            );
            expect(
              message.toString(time: false, type: false, title: false),
              '(4) => errorText (John)',
            );
            expect(
              message.toString(time: false, type: false, text: false),
              'errorName:(4)',
            );
          });
        });
      });
    });
  });
}
