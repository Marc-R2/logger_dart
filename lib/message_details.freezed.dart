// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message_details.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MessageBase _$MessageBaseFromJson(Map<String, dynamic> json) {
  return _MessageBase.fromJson(json);
}

/// @nodoc
mixin _$MessageBase {
  MessageType get type => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get sourceFunction => throw _privateConstructorUsedError;
  String? get sourceClass => throw _privateConstructorUsedError;
  String? get text => throw _privateConstructorUsedError;
  int? get level => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MessageBaseCopyWith<MessageBase> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageBaseCopyWith<$Res> {
  factory $MessageBaseCopyWith(
          MessageBase value, $Res Function(MessageBase) then) =
      _$MessageBaseCopyWithImpl<$Res, MessageBase>;
  @useResult
  $Res call(
      {MessageType type,
      String title,
      String? sourceFunction,
      String? sourceClass,
      String? text,
      int? level});
}

/// @nodoc
class _$MessageBaseCopyWithImpl<$Res, $Val extends MessageBase>
    implements $MessageBaseCopyWith<$Res> {
  _$MessageBaseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? title = null,
    Object? sourceFunction = freezed,
    Object? sourceClass = freezed,
    Object? text = freezed,
    Object? level = freezed,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as MessageType,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      sourceFunction: freezed == sourceFunction
          ? _value.sourceFunction
          : sourceFunction // ignore: cast_nullable_to_non_nullable
              as String?,
      sourceClass: freezed == sourceClass
          ? _value.sourceClass
          : sourceClass // ignore: cast_nullable_to_non_nullable
              as String?,
      text: freezed == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
      level: freezed == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MessageBaseCopyWith<$Res>
    implements $MessageBaseCopyWith<$Res> {
  factory _$$_MessageBaseCopyWith(
          _$_MessageBase value, $Res Function(_$_MessageBase) then) =
      __$$_MessageBaseCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {MessageType type,
      String title,
      String? sourceFunction,
      String? sourceClass,
      String? text,
      int? level});
}

/// @nodoc
class __$$_MessageBaseCopyWithImpl<$Res>
    extends _$MessageBaseCopyWithImpl<$Res, _$_MessageBase>
    implements _$$_MessageBaseCopyWith<$Res> {
  __$$_MessageBaseCopyWithImpl(
      _$_MessageBase _value, $Res Function(_$_MessageBase) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? title = null,
    Object? sourceFunction = freezed,
    Object? sourceClass = freezed,
    Object? text = freezed,
    Object? level = freezed,
  }) {
    return _then(_$_MessageBase(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as MessageType,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      sourceFunction: freezed == sourceFunction
          ? _value.sourceFunction
          : sourceFunction // ignore: cast_nullable_to_non_nullable
              as String?,
      sourceClass: freezed == sourceClass
          ? _value.sourceClass
          : sourceClass // ignore: cast_nullable_to_non_nullable
              as String?,
      text: freezed == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String?,
      level: freezed == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class _$_MessageBase extends _MessageBase {
  const _$_MessageBase(
      {required this.type,
      required this.title,
      this.sourceFunction,
      this.sourceClass,
      this.text,
      this.level})
      : super._();

  factory _$_MessageBase.fromJson(Map<String, dynamic> json) =>
      _$$_MessageBaseFromJson(json);

  @override
  final MessageType type;
  @override
  final String title;
  @override
  final String? sourceFunction;
  @override
  final String? sourceClass;
  @override
  final String? text;
  @override
  final int? level;

  @override
  String toString() {
    return 'MessageBase(type: $type, title: $title, sourceFunction: $sourceFunction, sourceClass: $sourceClass, text: $text, level: $level)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MessageBase &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.sourceFunction, sourceFunction) ||
                other.sourceFunction == sourceFunction) &&
            (identical(other.sourceClass, sourceClass) ||
                other.sourceClass == sourceClass) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.level, level) || other.level == level));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, type, title, sourceFunction, sourceClass, text, level);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MessageBaseCopyWith<_$_MessageBase> get copyWith =>
      __$$_MessageBaseCopyWithImpl<_$_MessageBase>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MessageBaseToJson(
      this,
    );
  }
}

abstract class _MessageBase extends MessageBase {
  const factory _MessageBase(
      {required final MessageType type,
      required final String title,
      final String? sourceFunction,
      final String? sourceClass,
      final String? text,
      final int? level}) = _$_MessageBase;
  const _MessageBase._() : super._();

  factory _MessageBase.fromJson(Map<String, dynamic> json) =
      _$_MessageBase.fromJson;

  @override
  MessageType get type;
  @override
  String get title;
  @override
  String? get sourceFunction;
  @override
  String? get sourceClass;
  @override
  String? get text;
  @override
  int? get level;
  @override
  @JsonKey(ignore: true)
  _$$_MessageBaseCopyWith<_$_MessageBase> get copyWith =>
      throw _privateConstructorUsedError;
}

MessageDetails _$MessageDetailsFromJson(Map<String, dynamic> json) {
  return _MessageDetails.fromJson(json);
}

/// @nodoc
mixin _$MessageDetails {
  DateTime get time => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;
  Map<String, String> get templateValues => throw _privateConstructorUsedError;
  String get runtimeSession => throw _privateConstructorUsedError;
  int? get logId => throw _privateConstructorUsedError;
  int? get parentLogId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MessageDetailsCopyWith<MessageDetails> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageDetailsCopyWith<$Res> {
  factory $MessageDetailsCopyWith(
          MessageDetails value, $Res Function(MessageDetails) then) =
      _$MessageDetailsCopyWithImpl<$Res, MessageDetails>;
  @useResult
  $Res call(
      {DateTime time,
      List<String> tags,
      Map<String, String> templateValues,
      String runtimeSession,
      int? logId,
      int? parentLogId});
}

/// @nodoc
class _$MessageDetailsCopyWithImpl<$Res, $Val extends MessageDetails>
    implements $MessageDetailsCopyWith<$Res> {
  _$MessageDetailsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? time = null,
    Object? tags = null,
    Object? templateValues = null,
    Object? runtimeSession = null,
    Object? logId = freezed,
    Object? parentLogId = freezed,
  }) {
    return _then(_value.copyWith(
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      templateValues: null == templateValues
          ? _value.templateValues
          : templateValues // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      runtimeSession: null == runtimeSession
          ? _value.runtimeSession
          : runtimeSession // ignore: cast_nullable_to_non_nullable
              as String,
      logId: freezed == logId
          ? _value.logId
          : logId // ignore: cast_nullable_to_non_nullable
              as int?,
      parentLogId: freezed == parentLogId
          ? _value.parentLogId
          : parentLogId // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MessageDetailsCopyWith<$Res>
    implements $MessageDetailsCopyWith<$Res> {
  factory _$$_MessageDetailsCopyWith(
          _$_MessageDetails value, $Res Function(_$_MessageDetails) then) =
      __$$_MessageDetailsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime time,
      List<String> tags,
      Map<String, String> templateValues,
      String runtimeSession,
      int? logId,
      int? parentLogId});
}

/// @nodoc
class __$$_MessageDetailsCopyWithImpl<$Res>
    extends _$MessageDetailsCopyWithImpl<$Res, _$_MessageDetails>
    implements _$$_MessageDetailsCopyWith<$Res> {
  __$$_MessageDetailsCopyWithImpl(
      _$_MessageDetails _value, $Res Function(_$_MessageDetails) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? time = null,
    Object? tags = null,
    Object? templateValues = null,
    Object? runtimeSession = null,
    Object? logId = freezed,
    Object? parentLogId = freezed,
  }) {
    return _then(_$_MessageDetails(
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as DateTime,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      templateValues: null == templateValues
          ? _value._templateValues
          : templateValues // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      runtimeSession: null == runtimeSession
          ? _value.runtimeSession
          : runtimeSession // ignore: cast_nullable_to_non_nullable
              as String,
      logId: freezed == logId
          ? _value.logId
          : logId // ignore: cast_nullable_to_non_nullable
              as int?,
      parentLogId: freezed == parentLogId
          ? _value.parentLogId
          : parentLogId // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class _$_MessageDetails extends _MessageDetails {
  const _$_MessageDetails(
      {required this.time,
      required final List<String> tags,
      required final Map<String, String> templateValues,
      required this.runtimeSession,
      this.logId,
      this.parentLogId})
      : _tags = tags,
        _templateValues = templateValues,
        super._();

  factory _$_MessageDetails.fromJson(Map<String, dynamic> json) =>
      _$$_MessageDetailsFromJson(json);

  @override
  final DateTime time;
  final List<String> _tags;
  @override
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  final Map<String, String> _templateValues;
  @override
  Map<String, String> get templateValues {
    if (_templateValues is EqualUnmodifiableMapView) return _templateValues;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_templateValues);
  }

  @override
  final String runtimeSession;
  @override
  final int? logId;
  @override
  final int? parentLogId;

  @override
  String toString() {
    return 'MessageDetails(time: $time, tags: $tags, templateValues: $templateValues, runtimeSession: $runtimeSession, logId: $logId, parentLogId: $parentLogId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MessageDetails &&
            (identical(other.time, time) || other.time == time) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            const DeepCollectionEquality()
                .equals(other._templateValues, _templateValues) &&
            (identical(other.runtimeSession, runtimeSession) ||
                other.runtimeSession == runtimeSession) &&
            (identical(other.logId, logId) || other.logId == logId) &&
            (identical(other.parentLogId, parentLogId) ||
                other.parentLogId == parentLogId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      time,
      const DeepCollectionEquality().hash(_tags),
      const DeepCollectionEquality().hash(_templateValues),
      runtimeSession,
      logId,
      parentLogId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MessageDetailsCopyWith<_$_MessageDetails> get copyWith =>
      __$$_MessageDetailsCopyWithImpl<_$_MessageDetails>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MessageDetailsToJson(
      this,
    );
  }
}

abstract class _MessageDetails extends MessageDetails {
  const factory _MessageDetails(
      {required final DateTime time,
      required final List<String> tags,
      required final Map<String, String> templateValues,
      required final String runtimeSession,
      final int? logId,
      final int? parentLogId}) = _$_MessageDetails;
  const _MessageDetails._() : super._();

  factory _MessageDetails.fromJson(Map<String, dynamic> json) =
      _$_MessageDetails.fromJson;

  @override
  DateTime get time;
  @override
  List<String> get tags;
  @override
  Map<String, String> get templateValues;
  @override
  String get runtimeSession;
  @override
  int? get logId;
  @override
  int? get parentLogId;
  @override
  @JsonKey(ignore: true)
  _$$_MessageDetailsCopyWith<_$_MessageDetails> get copyWith =>
      throw _privateConstructorUsedError;
}
