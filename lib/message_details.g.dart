// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MessageBase _$$_MessageBaseFromJson(Map<String, dynamic> json) =>
    _$_MessageBase(
      type: $enumDecode(_$MessageTypeEnumMap, json['type']),
      title: json['title'] as String,
      sourceFunction: json['sourceFunction'] as String?,
      sourceClass: json['sourceClass'] as String?,
      text: json['text'] as String?,
      level: json['level'] as int?,
    );

Map<String, dynamic> _$$_MessageBaseToJson(_$_MessageBase instance) {
  final val = <String, dynamic>{
    'type': _$MessageTypeEnumMap[instance.type]!,
    'title': instance.title,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('sourceFunction', instance.sourceFunction);
  writeNotNull('sourceClass', instance.sourceClass);
  writeNotNull('text', instance.text);
  writeNotNull('level', instance.level);
  return val;
}

const _$MessageTypeEnumMap = {
  MessageType.log: 'log',
  MessageType.info: 'info',
  MessageType.warning: 'warning',
  MessageType.error: 'error',
  MessageType.trace: 'trace',
};

_$_MessageDetails _$$_MessageDetailsFromJson(Map<String, dynamic> json) =>
    _$_MessageDetails(
      time: DateTime.parse(json['time'] as String),
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      templateValues: Map<String, String>.from(json['templateValues'] as Map),
      runtimeSession: json['runtimeSession'] as String,
      logId: json['logId'] as int?,
      parentLogId: json['parentLogId'] as int?,
    );

Map<String, dynamic> _$$_MessageDetailsToJson(_$_MessageDetails instance) {
  final val = <String, dynamic>{
    'time': instance.time.toIso8601String(),
    'tags': instance.tags,
    'templateValues': instance.templateValues,
    'runtimeSession': instance.runtimeSession,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('logId', instance.logId);
  writeNotNull('parentLogId', instance.parentLogId);
  return val;
}
