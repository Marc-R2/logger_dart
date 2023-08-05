part of 'logger.dart';

enum MessageType {
  log('Log', '\x1B[37m'),
  info('Info', '\x1B[34m'),
  warning('Warning', '\x1B[33m'),
  error('Error', '\x1B[31m'),
  trace('Trace', '\x1B[35m');

  const MessageType(this.stringName, this.terminalColor);

  final String stringName;

  final String terminalColor;

  @override
  String toString() => '$name:';
}
