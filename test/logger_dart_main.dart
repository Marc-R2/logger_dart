import 'log_test.dart' as log_test;
import 'logger_test.dart' as logger_test;
import 'message_template_values_test.dart' as message_template_values_test;
import 'message_templates_test.dart' as message_templates_test;
import 'messages_test.dart' as messages_test;
import 'mixin/logging_test.dart' as logging_test;

void main() {
  log_test.main();
  logger_test.main();
  logging_test.main();
  messages_test.main();
  message_templates_test.main();
  message_template_values_test.main();
}
