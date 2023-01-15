part of '../logger.dart';

/// Allow any class to easily log messages
mixin Logging {
  /// Log a message
  late final log = MessageTemplate(klasse: this);

  /// Create a child template with the given [function]
  MessageTemplate functionLog(String function) => log.function(function);

  /// Create a child template with the given [className]
  MessageTemplate classLog(Object className) => log.klasse(className);
}
