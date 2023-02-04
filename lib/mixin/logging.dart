part of '../logger.dart';

/// Allow any class to easily log messages
mixin Logging {
  /// Log a message
  late final log = MessageTemplate(klasse: this);

  /// Create a child template with the given [function]
  MessageTemplate functionLog(String function) => log.function(function);

  /// Create a child template with the given [className]
  MessageTemplate classLog(Object className) => log.klasse(className);

  Log functionStart(String function, [Log? context]) {
    final newLog = Log(
      parent: context,
      function: function,
      klasse: this,
      tags: ['FunctionStart'],
    );

    return newLog;
  }
}

class Log extends MessageTemplate {
  const Log({
    this.id = 0,
    this.parent,
    super.function,
    super.klasse,
    super.tags,
  })  : assert(id >= 0, 'Log id must be greater than or equal to 0'),
        assert(
          parent == null || parent == id - 1,
          'Log id must be one greater than parent id',
        );

  final int id;

  final Log? parent;
}
