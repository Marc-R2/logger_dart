import 'package:log_message/logger.dart';
import 'package:test/test.dart';

Future<void> main() async {
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
              message.toString(time: false),
              'Log: logName - John:(2)',
            );
            expect(
              message.toString(time: false, type: false, level: false),
              'logName - John',
            );
          });

          test('templates.title.Log no template', () {
            final message = Message.log(
              title: 'logName',
              level: 2,
            );

            expect(
              message.toString(time: false),
              'Log: logName:(2)',
            );
            expect(
              message.toString(time: false, type: false, level: false),
              'logName',
            );
          });

          test('templates.title.Log no template value', () {
            final message = Message.log(
              title: 'logName - {name}',
              level: 2,
            );

            expect(
              message.toString(time: false),
              'Log: logName - <name>:(2)',
            );
            expect(
              message.toString(time: false, type: false, level: false),
              'logName - <name>',
            );
          });

          test('templates.title.Log nested', () {
            final message = Message.log(
              title: 'logName - {na{dyn}}',
              level: 2,
              templateValues: {'name': 'John', 'dyn': 'me'},
            );

            expect(
              message.toString(time: false),
              'Log: logName - John:(2)',
            );
            expect(
              message.toString(time: false, type: false, level: false),
              'logName - John',
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
              message.toString(time: false),
              'Log: logName:(5) => logText (John)',
            );
          });

          test('templates.text.Log missing key', () {
            final message = Message.log(
              title: 'logName',
              text: 'logText ({name})',
              level: 5,
            );

            expect(
              message.toString(time: false),
              'Log: logName:(5) => logText (<name>)',
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
              message.toString(time: false),
              'Log: logName:(5) => logText (John, 30)',
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
              message.toString(time: false),
              'Log: logName:(5) => logText (John)',
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
              message.toString(time: false),
              'Info: infoName:(9) => infoText (John)',
            );
          });

          test('templates.text.Info missing key', () {
            final message = Message.info(
              title: 'infoName',
              text: 'infoText ({name})',
              level: 9,
            );

            expect(
              message.toString(time: false),
              'Info: infoName:(9) => infoText (<name>)',
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
              message.toString(time: false),
              'Info: infoName:(9) => infoText (John, 30)',
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
              message.toString(time: false),
              'Info: infoName:(9) => infoText (John)',
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
              message.toString(time: false),
              'Warning: warningName:(2) => warningText (John)',
            );
          });

          test('templates.text.Warning missing key', () {
            final message = Message.warning(
              title: 'warningName',
              text: 'warningText ({name})',
              level: 2,
            );

            expect(
              message.toString(time: false),
              'Warning: warningName:(2) => warningText (<name>)',
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
              message.toString(time: false),
              'Warning: warningName:(2) => warningText (John, 30)',
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
              message.toString(time: false),
              'Warning: warningName:(2) => warningText (John)',
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
              message.toString(time: false),
              'Error: errorName:(4) => errorText (John)',
            );
          });

          test('templates.text.Error missing key', () {
            final message = Message.error(
              title: 'errorName',
              text: 'errorText ({name})',
              level: 4,
            );

            expect(
              message.toString(time: false),
              'Error: errorName:(4) => errorText (<name>)',
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
              message.toString(time: false),
              'Error: errorName:(4) => errorText (John, 30)',
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
              message.toString(time: false),
              'Error: errorName:(4) => errorText (John)',
            );
          });
        });
      });
    });
  });
}
