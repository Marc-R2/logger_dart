import 'package:log_message/logger.dart';
import 'package:test/test.dart';

void main() {
  group('Log inheritance', () {
    test('_', () {
      final dummy = DummyClass();
      final log0 = Log(session: 'session');
      {
        // Sample 1
        final log0_1 = dummy.functionStart('sample 1', log0);

        // Message 1
        final msg0_1_0 = log0_1.info(title: 'Message 1');

        // This is the first global message in context and therefore
        // should have [logId = 0] and no parent [parentLogId = null]
        expect(msg0_1_0.logId, 0);
        expect(msg0_1_0.parentLogId, null);
      }
      {
        // Sample 2
        final log0_2 = dummy.functionStart('sample 2', log0);

        // Message 2
        final msg0_2_0 = log0_2.info(title: 'Message 2');

        // This is the second global message in context and therefore
        // should have [logId = 1] and no parent [parentLogId = null]
        expect(msg0_2_0.logId, 1);
        expect(msg0_2_0.parentLogId, null);

        // Message 3
        final msg0_2_1 = log0_2.info(title: 'Message 3');

        // This is the third global message in context and therefore
        // should have [logId = 2] and the previous message as parent
        // [parentLogId = 1]
        expect(msg0_2_1.logId, 2);
        expect(msg0_2_1.parentLogId, 1);
      }
      // Message 4
      final msg0_1 = log0.info(title: 'Message 4');

      // This is the fourth global message in context and therefore
      // should have [logId = 3] and no parent [parentLogId = null]
      expect(msg0_1.logId, 3);
      expect(msg0_1.parentLogId, null);

      // Message 5
      final msg0_2 = log0.info(title: 'Message 5');

      // This is the fifth global message in context and therefore
      // should have [logId = 4] and the previous message as parent
      // [parentLogId = 3]
      expect(msg0_2.logId, 4);
      expect(msg0_2.parentLogId, 3);

      {
        // Sample 3
        final log0_3 = dummy.functionStart('sample 3', log0);

        // Message 6
        final msg0_3_0 = log0_3.info(title: 'Message 6');

        // This is the sixth global message in context and therefore
        // should have [logId = 5] and the previous message in parent
        // [parentLogId = 4]
        expect(msg0_3_0.logId, 5);
        expect(msg0_3_0.parentLogId, 4);

        // Message 7
        final msg0_3_1 = log0_3.info(title: 'Message 7');

        // This is the seventh global message in context and therefore
        // should have [logId = 6] and the previous message as parent
        // [parentLogId = 5]
        expect(msg0_3_1.logId, 6);
        expect(msg0_3_1.parentLogId, 5);
      }
    });
  });
}

class DummyClass with Logging {}
