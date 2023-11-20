import 'package:log_message/logger.dart';
import 'package:test/test.dart';

void main() {
  group('Log inheritance', () {
    test('_', () {
      final dummy = DummyClass();
      const runtime = LogRuntime('runtime');
      const session = LogSession('session');
      final log0 = Log(runtime: runtime, session: session);

      expect(log0.runtimeId, runtime);
      expect(log0.sessionId, session);
      expect(log0.parent, null);

      expect(log0.messagesInContext, hasLength(0));
      expect(log0.messagesAll, hasLength(0));
      expect(log0.messagesAbove, hasLength(0));
      expect(log0.messagesInContextAndAbove, hasLength(0));
      expect(log0.messagesBelow, hasLength(0));
      expect(log0.messagesInContextAndBelow, hasLength(0));

      {
        // Sample 1
        final log0_1 = dummy.functionStart('sample 1', log0);

        expect(log0_1.runtimeId, runtime);
        expect(log0_1.sessionId, session);
        expect(log0_1.parent, log0);
        expect(log0_1.messagesInContextAndAbove, hasLength(0));

        // Message 1
        final msg0_1_0 = log0_1.info(title: 'Message 1');

        // This is the first global message in context and therefore
        // should have [logId = 0] and no parent [parentLogId = null]
        expect(msg0_1_0.logId, 0);
        expect(msg0_1_0.parentLogId, null);
        expect(msg0_1_0.runtimeId, runtime);
        expect(msg0_1_0.sessionId, session);

        expect(log0_1.messagesInContext, hasLength(1));
        expect(log0_1.messagesInContext, equals([msg0_1_0]));
        expect(log0_1.messagesAll, hasLength(1));
        expect(log0_1.messagesAll, equals([msg0_1_0]));
        expect(log0_1.messagesAbove, hasLength(0));
        expect(log0_1.messagesInContextAndAbove, hasLength(1));
        expect(log0_1.messagesInContextAndAbove, equals([msg0_1_0]));
        expect(log0_1.messagesBelow, hasLength(0));
        expect(log0_1.messagesInContextAndBelow, hasLength(1));
        expect(log0_1.messagesInContextAndBelow, equals([msg0_1_0]));
      }
      {
        // Sample 2
        final log0_2 = dummy.functionStart('sample 2', log0);

        expect(log0_2.runtimeId, runtime);
        expect(log0_2.sessionId, session);
        expect(log0_2.parent, log0);

        // Message 2
        final msg0_2_0 = log0_2.info(title: 'Message 2');

        // This is the second global message in context and therefore
        // should have [logId = 1] and no parent [parentLogId = null]
        expect(msg0_2_0.logId, 1);
        expect(msg0_2_0.parentLogId, null);
        expect(msg0_2_0.runtimeId, runtime);
        expect(msg0_2_0.sessionId, session);

        expect(log0_2.messagesInContext, hasLength(1));
        expect(log0_2.messagesInContext, equals([msg0_2_0]));
        expect(log0_2.messagesAll, hasLength(1));
        expect(log0_2.messagesAll, equals([msg0_2_0]));
        expect(log0_2.messagesAbove, hasLength(0));
        expect(log0_2.messagesInContextAndAbove, hasLength(1));
        expect(log0_2.messagesInContextAndAbove, equals([msg0_2_0]));
        expect(log0_2.messagesBelow, hasLength(0));
        expect(log0_2.messagesInContextAndBelow, hasLength(1));
        expect(log0_2.messagesInContextAndBelow, equals([msg0_2_0]));

        // Message 3
        final msg0_2_1 = log0_2.info(title: 'Message 3');

        // This is the third global message in context and therefore
        // should have [logId = 2] and the previous message as parent
        // [parentLogId = 1]
        expect(msg0_2_1.logId, 2);
        expect(msg0_2_1.parentLogId, 1);
        expect(msg0_2_1.runtimeId, runtime);
        expect(msg0_2_1.sessionId, session);

        expect(log0_2.messagesInContext, hasLength(2));
        expect(log0_2.messagesInContext, equals([msg0_2_0, msg0_2_1]));
        expect(log0_2.messagesAll, hasLength(2));
        expect(log0_2.messagesAll, equals([msg0_2_0, msg0_2_1]));
        expect(log0_2.messagesAbove, hasLength(0));
        expect(log0_2.messagesInContextAndAbove, hasLength(2));
        expect(log0_2.messagesInContextAndAbove, equals([msg0_2_0, msg0_2_1]));
        expect(log0_2.messagesBelow, hasLength(0));
        expect(log0_2.messagesInContextAndBelow, hasLength(2));
        expect(log0_2.messagesInContextAndBelow, equals([msg0_2_0, msg0_2_1]));
      }
      // Message 4
      final msg0_1 = log0.info(title: 'Message 4');

      // This is the fourth global message in context and therefore
      // should have [logId = 3] and no parent [parentLogId = null]
      expect(msg0_1.logId, 3);
      expect(msg0_1.parentLogId, null);
      expect(msg0_1.runtimeId, runtime);
      expect(msg0_1.sessionId, session);

      expect(log0.messagesInContext, hasLength(1));
      expect(log0.messagesInContext, equals([msg0_1]));
      expect(log0.messagesAll, hasLength(4));
      expect(log0.messagesAbove, hasLength(0));
      expect(log0.messagesInContextAndAbove, hasLength(1));
      expect(log0.messagesInContextAndAbove, equals([msg0_1]));
      expect(log0.messagesBelow, hasLength(3));
      expect(log0.messagesInContextAndBelow, hasLength(4));

      // Message 5
      final msg0_2 = log0.info(title: 'Message 5');

      // This is the fifth global message in context and therefore
      // should have [logId = 4] and the previous message as parent
      // [parentLogId = 3]
      expect(msg0_2.logId, 4);
      expect(msg0_2.parentLogId, 3);
      expect(msg0_2.runtimeId, runtime);
      expect(msg0_2.sessionId, session);

      expect(log0.messagesAbove, hasLength(0));
      expect(log0.messagesInContextAndAbove, hasLength(2));
      expect(log0.messagesInContextAndAbove, equals([msg0_1, msg0_2]));
      expect(log0.messagesBelow, hasLength(3));
      expect(log0.messagesInContextAndBelow, hasLength(5));

      {
        // Sample 3
        final log0_3 = log0.functionStartStatic('sample 3');

        expect(log0_3.runtimeId, runtime);
        expect(log0_3.sessionId, session);
        expect(log0_3.parent, log0);

        // Message 6
        final msg0_3_0 = log0_3.info(title: 'Message 6');

        // Static function should not have a class (by default)
        expect(msg0_3_0.sourceClass, isNull);

        // This is the sixth global message in context and therefore
        // should have [logId = 5] and the previous message in parent
        // [parentLogId = 4]
        expect(msg0_3_0.logId, 5);
        expect(msg0_3_0.parentLogId, 4);
        expect(msg0_3_0.runtimeId, runtime);
        expect(msg0_3_0.sessionId, session);

        expect(log0_3.messagesAbove, hasLength(2));
        expect(log0_3.messagesAbove, equals([msg0_1, msg0_2]));
        expect(log0_3.messagesInContextAndAbove, hasLength(3));
        expect(
          log0_3.messagesInContextAndAbove,
          equals([msg0_1, msg0_2, msg0_3_0]),
        );
        expect(log0_3.messagesBelow, hasLength(0));
        expect(log0_3.messagesInContextAndBelow, hasLength(1));
        expect(log0_3.messagesInContextAndBelow, equals([msg0_3_0]));

        // Message 7
        final msg0_3_1 = log0_3.info(title: 'Message 7');

        // This is the seventh global message in context and therefore
        // should have [logId = 6] and the previous message as parent
        // [parentLogId = 5]
        expect(msg0_3_1.logId, 6);
        expect(msg0_3_1.parentLogId, 5);
        expect(msg0_3_1.runtimeId, runtime);
        expect(msg0_3_1.sessionId, session);

        expect(log0_3.messagesAbove, hasLength(2));
        expect(log0_3.messagesAbove, equals([msg0_1, msg0_2]));
        expect(log0_3.messagesInContextAndAbove, hasLength(4));
        expect(
          log0_3.messagesInContextAndAbove,
          equals([msg0_1, msg0_2, msg0_3_0, msg0_3_1]),
        );
        expect(log0_3.messagesBelow, hasLength(0));
        expect(log0_3.messagesInContextAndBelow, hasLength(2));
        expect(log0_3.messagesInContextAndBelow, equals([msg0_3_0, msg0_3_1]));
      }

      expect(log0.messagesInContext, hasLength(2));
      expect(log0.messagesInContext, equals([msg0_1, msg0_2]));
      expect(log0.messagesAll, hasLength(7));
      expect(log0.messagesAbove, hasLength(0));
      expect(log0.messagesInContextAndAbove, hasLength(2));
      expect(log0.messagesInContextAndAbove, equals([msg0_1, msg0_2]));
      expect(log0.messagesBelow, hasLength(5));
      expect(log0.messagesInContextAndBelow, hasLength(7));
    });

    test('Working on null Log', () {
      const Log? nullLog = null;
      final log = nullLog.functionStartStatic('ABC');

      final msg = log.info(title: 'Test');

      expect(msg.logId, 0);
      expect(msg.parentLogId, isNull);
      expect(msg.sourceClass, isNull);
      expect(msg.sourceFunction, 'ABC');

      expect(log.messagesInContext, hasLength(1));
      expect(log.messagesInContext, equals([msg]));
      expect(log.messagesAll, hasLength(1));
      expect(log.messagesAll, equals([msg]));
      expect(log.messagesAbove, hasLength(0));
      expect(log.messagesInContextAndAbove, hasLength(1));
      expect(log.messagesInContextAndAbove, equals([msg]));
      expect(log.messagesBelow, hasLength(0));
      expect(log.messagesInContextAndBelow, hasLength(1));
      expect(log.messagesInContextAndBelow, equals([msg]));
    });
  });
}

class DummyClass with Logging {}
