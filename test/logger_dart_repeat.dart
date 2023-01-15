import 'package:test/test.dart';

import 'logger_dart_main.dart' as logger_dart_main;

void main() {
  for (var i = 0; i < 128; i++) {
    group('Repeat ${i + 1} group', logger_dart_main.main);
  }
}
