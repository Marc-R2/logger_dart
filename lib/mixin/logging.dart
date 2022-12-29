part of '../logger.dart';

/// Allow any class to easily log messages
mixin Logging {
  /// Log a message
  late final log = MessageTemplate(klasse: this);
}
