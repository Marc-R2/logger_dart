import 'dart:core';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:log_message/logger.dart';

part 'message_details.freezed.dart';

part 'message_details.g.dart';

class MessageStorage {
  const MessageStorage({
    required this.base,
    required this.details,
  });

  factory MessageStorage.fromJson(Map<String, dynamic> json) {
    return MessageStorage(
      base: MessageBase.fromJson(json),
      details: MessageDetails.fromJson(json),
    );
  }

  factory MessageStorage.fromMessage(Message message) {
    final base = MessageBase(
      messageCode: message.messageCode,
      type: message.type,
      title: message.title,
      sourceFunction: message.sourceFunction,
      sourceClass: message.sourceClass,
      text: message.text,
      level: message.level,
    );

    final details = MessageDetails(
      messageCode: base.messageCode,
      time: message.time,
      tags: message.tags,
      templateValues: message.templateValues,
      runtimeSession: message.runtimeSession,
      logId: message.logId,
      parentLogId: message.parentLogId,
    );

    return MessageStorage(base: base, details: details);
  }

  final MessageBase base;

  final MessageDetails details;

  Message toMessage() => Message(
        type: base.type,
        title: base.title,
        sourceFunction: base.sourceFunction,
        sourceClass: base.sourceClass,
        text: base.text ?? '',
        level: base.level ?? 0,
        time: details.time,
        tags: details.tags,
        templateValues: details.templateValues,
        runtimeSession: details.runtimeSession,
        logId: details.logId,
        parentLogId: details.parentLogId,
      );

  Map<String, dynamic> toJson() => {
        ...base.toJson(),
        ...details.toJson(),
      };
}

/// Store the constant parts of a message.
@freezed
class MessageBase with _$MessageBase {
  ///
  @JsonSerializable(explicitToJson: true, includeIfNull: false)
  const factory MessageBase({
    required String messageCode,
    required MessageType type,
    required String title,
    String? sourceFunction,
    String? sourceClass,
    String? text,
    int? level,
  }) = _MessageBase;

  factory MessageBase.fromJson(Map<String, dynamic> json) =>
      _$MessageBaseFromJson(json);

  const MessageBase._();
}

/// Store the interchangeable parts of a message.
@freezed
class MessageDetails with _$MessageDetails {
  ///
  @JsonSerializable(explicitToJson: true, includeIfNull: false)
  const factory MessageDetails({
    required String messageCode,
    required DateTime time,
    required List<String> tags,
    required Map<String, String> templateValues,
    required String runtimeSession,
    @Default(0) int logId,
    int? parentLogId,
  }) = _MessageDetails;

  factory MessageDetails.fromJson(Map<String, dynamic> json) =>
      _$MessageDetailsFromJson(json);

  const MessageDetails._();
}
