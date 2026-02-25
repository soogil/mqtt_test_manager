// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mqtt_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MqttState {
  MqttConnectionStatus get connectionStatus =>
      throw _privateConstructorUsedError;
  List<MqttLogEntry> get messages => throw _privateConstructorUsedError;
  List<String> get subscribedTopics => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  /// Create a copy of MqttState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MqttStateCopyWith<MqttState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MqttStateCopyWith<$Res> {
  factory $MqttStateCopyWith(MqttState value, $Res Function(MqttState) then) =
      _$MqttStateCopyWithImpl<$Res, MqttState>;
  @useResult
  $Res call(
      {MqttConnectionStatus connectionStatus,
      List<MqttLogEntry> messages,
      List<String> subscribedTopics,
      String? errorMessage});
}

/// @nodoc
class _$MqttStateCopyWithImpl<$Res, $Val extends MqttState>
    implements $MqttStateCopyWith<$Res> {
  _$MqttStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MqttState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? connectionStatus = null,
    Object? messages = null,
    Object? subscribedTopics = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_value.copyWith(
      connectionStatus: null == connectionStatus
          ? _value.connectionStatus
          : connectionStatus // ignore: cast_nullable_to_non_nullable
              as MqttConnectionStatus,
      messages: null == messages
          ? _value.messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<MqttLogEntry>,
      subscribedTopics: null == subscribedTopics
          ? _value.subscribedTopics
          : subscribedTopics // ignore: cast_nullable_to_non_nullable
              as List<String>,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MqttStateImplCopyWith<$Res>
    implements $MqttStateCopyWith<$Res> {
  factory _$$MqttStateImplCopyWith(
          _$MqttStateImpl value, $Res Function(_$MqttStateImpl) then) =
      __$$MqttStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {MqttConnectionStatus connectionStatus,
      List<MqttLogEntry> messages,
      List<String> subscribedTopics,
      String? errorMessage});
}

/// @nodoc
class __$$MqttStateImplCopyWithImpl<$Res>
    extends _$MqttStateCopyWithImpl<$Res, _$MqttStateImpl>
    implements _$$MqttStateImplCopyWith<$Res> {
  __$$MqttStateImplCopyWithImpl(
      _$MqttStateImpl _value, $Res Function(_$MqttStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of MqttState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? connectionStatus = null,
    Object? messages = null,
    Object? subscribedTopics = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_$MqttStateImpl(
      connectionStatus: null == connectionStatus
          ? _value.connectionStatus
          : connectionStatus // ignore: cast_nullable_to_non_nullable
              as MqttConnectionStatus,
      messages: null == messages
          ? _value._messages
          : messages // ignore: cast_nullable_to_non_nullable
              as List<MqttLogEntry>,
      subscribedTopics: null == subscribedTopics
          ? _value._subscribedTopics
          : subscribedTopics // ignore: cast_nullable_to_non_nullable
              as List<String>,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$MqttStateImpl implements _MqttState {
  const _$MqttStateImpl(
      {this.connectionStatus = MqttConnectionStatus.disconnected,
      final List<MqttLogEntry> messages = const [],
      final List<String> subscribedTopics = const [],
      this.errorMessage})
      : _messages = messages,
        _subscribedTopics = subscribedTopics;

  @override
  @JsonKey()
  final MqttConnectionStatus connectionStatus;
  final List<MqttLogEntry> _messages;
  @override
  @JsonKey()
  List<MqttLogEntry> get messages {
    if (_messages is EqualUnmodifiableListView) return _messages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_messages);
  }

  final List<String> _subscribedTopics;
  @override
  @JsonKey()
  List<String> get subscribedTopics {
    if (_subscribedTopics is EqualUnmodifiableListView)
      return _subscribedTopics;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_subscribedTopics);
  }

  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'MqttState(connectionStatus: $connectionStatus, messages: $messages, subscribedTopics: $subscribedTopics, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MqttStateImpl &&
            (identical(other.connectionStatus, connectionStatus) ||
                other.connectionStatus == connectionStatus) &&
            const DeepCollectionEquality().equals(other._messages, _messages) &&
            const DeepCollectionEquality()
                .equals(other._subscribedTopics, _subscribedTopics) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      connectionStatus,
      const DeepCollectionEquality().hash(_messages),
      const DeepCollectionEquality().hash(_subscribedTopics),
      errorMessage);

  /// Create a copy of MqttState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MqttStateImplCopyWith<_$MqttStateImpl> get copyWith =>
      __$$MqttStateImplCopyWithImpl<_$MqttStateImpl>(this, _$identity);
}

abstract class _MqttState implements MqttState {
  const factory _MqttState(
      {final MqttConnectionStatus connectionStatus,
      final List<MqttLogEntry> messages,
      final List<String> subscribedTopics,
      final String? errorMessage}) = _$MqttStateImpl;

  @override
  MqttConnectionStatus get connectionStatus;
  @override
  List<MqttLogEntry> get messages;
  @override
  List<String> get subscribedTopics;
  @override
  String? get errorMessage;

  /// Create a copy of MqttState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MqttStateImplCopyWith<_$MqttStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$MqttLogEntry {
  String get topic => throw _privateConstructorUsedError;
  String get payload => throw _privateConstructorUsedError;
  DateTime get timestamp => throw _privateConstructorUsedError;

  /// Create a copy of MqttLogEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MqttLogEntryCopyWith<MqttLogEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MqttLogEntryCopyWith<$Res> {
  factory $MqttLogEntryCopyWith(
          MqttLogEntry value, $Res Function(MqttLogEntry) then) =
      _$MqttLogEntryCopyWithImpl<$Res, MqttLogEntry>;
  @useResult
  $Res call({String topic, String payload, DateTime timestamp});
}

/// @nodoc
class _$MqttLogEntryCopyWithImpl<$Res, $Val extends MqttLogEntry>
    implements $MqttLogEntryCopyWith<$Res> {
  _$MqttLogEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MqttLogEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? topic = null,
    Object? payload = null,
    Object? timestamp = null,
  }) {
    return _then(_value.copyWith(
      topic: null == topic
          ? _value.topic
          : topic // ignore: cast_nullable_to_non_nullable
              as String,
      payload: null == payload
          ? _value.payload
          : payload // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MqttLogEntryImplCopyWith<$Res>
    implements $MqttLogEntryCopyWith<$Res> {
  factory _$$MqttLogEntryImplCopyWith(
          _$MqttLogEntryImpl value, $Res Function(_$MqttLogEntryImpl) then) =
      __$$MqttLogEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String topic, String payload, DateTime timestamp});
}

/// @nodoc
class __$$MqttLogEntryImplCopyWithImpl<$Res>
    extends _$MqttLogEntryCopyWithImpl<$Res, _$MqttLogEntryImpl>
    implements _$$MqttLogEntryImplCopyWith<$Res> {
  __$$MqttLogEntryImplCopyWithImpl(
      _$MqttLogEntryImpl _value, $Res Function(_$MqttLogEntryImpl) _then)
      : super(_value, _then);

  /// Create a copy of MqttLogEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? topic = null,
    Object? payload = null,
    Object? timestamp = null,
  }) {
    return _then(_$MqttLogEntryImpl(
      topic: null == topic
          ? _value.topic
          : topic // ignore: cast_nullable_to_non_nullable
              as String,
      payload: null == payload
          ? _value.payload
          : payload // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$MqttLogEntryImpl implements _MqttLogEntry {
  const _$MqttLogEntryImpl(
      {required this.topic, required this.payload, required this.timestamp});

  @override
  final String topic;
  @override
  final String payload;
  @override
  final DateTime timestamp;

  @override
  String toString() {
    return 'MqttLogEntry(topic: $topic, payload: $payload, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MqttLogEntryImpl &&
            (identical(other.topic, topic) || other.topic == topic) &&
            (identical(other.payload, payload) || other.payload == payload) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @override
  int get hashCode => Object.hash(runtimeType, topic, payload, timestamp);

  /// Create a copy of MqttLogEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MqttLogEntryImplCopyWith<_$MqttLogEntryImpl> get copyWith =>
      __$$MqttLogEntryImplCopyWithImpl<_$MqttLogEntryImpl>(this, _$identity);
}

abstract class _MqttLogEntry implements MqttLogEntry {
  const factory _MqttLogEntry(
      {required final String topic,
      required final String payload,
      required final DateTime timestamp}) = _$MqttLogEntryImpl;

  @override
  String get topic;
  @override
  String get payload;
  @override
  DateTime get timestamp;

  /// Create a copy of MqttLogEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MqttLogEntryImplCopyWith<_$MqttLogEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
