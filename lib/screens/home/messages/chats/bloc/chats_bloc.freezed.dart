// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chats_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ChatsEvent {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is ChatsEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ChatsEvent()';
  }
}

/// @nodoc
class $ChatsEventCopyWith<$Res> {
  $ChatsEventCopyWith(ChatsEvent _, $Res Function(ChatsEvent) __);
}

/// @nodoc

class _Load implements ChatsEvent {
  const _Load();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _Load);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'ChatsEvent.load()';
  }
}

/// @nodoc
mixin _$ChatsState {
  NetworkStatus get status;
  List<Chat> get chats;
  String? get errorMessage;

  /// Create a copy of ChatsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ChatsStateCopyWith<ChatsState> get copyWith =>
      _$ChatsStateCopyWithImpl<ChatsState>(this as ChatsState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ChatsState &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other.chats, chats) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    status,
    const DeepCollectionEquality().hash(chats),
    errorMessage,
  );

  @override
  String toString() {
    return 'ChatsState(status: $status, chats: $chats, errorMessage: $errorMessage)';
  }
}

/// @nodoc
abstract mixin class $ChatsStateCopyWith<$Res> {
  factory $ChatsStateCopyWith(
    ChatsState value,
    $Res Function(ChatsState) _then,
  ) = _$ChatsStateCopyWithImpl;
  @useResult
  $Res call({NetworkStatus status, List<Chat> chats, String? errorMessage});
}

/// @nodoc
class _$ChatsStateCopyWithImpl<$Res> implements $ChatsStateCopyWith<$Res> {
  _$ChatsStateCopyWithImpl(this._self, this._then);

  final ChatsState _self;
  final $Res Function(ChatsState) _then;

  /// Create a copy of ChatsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? chats = null,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _self.copyWith(
        status: null == status
            ? _self.status
            : status // ignore: cast_nullable_to_non_nullable
                  as NetworkStatus,
        chats: null == chats
            ? _self.chats
            : chats // ignore: cast_nullable_to_non_nullable
                  as List<Chat>,
        errorMessage: freezed == errorMessage
            ? _self.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _ChatsState implements ChatsState {
  const _ChatsState({
    this.status = NetworkStatus.loading,
    final List<Chat> chats = const [],
    this.errorMessage,
  }) : _chats = chats;

  @override
  @JsonKey()
  final NetworkStatus status;
  final List<Chat> _chats;
  @override
  @JsonKey()
  List<Chat> get chats {
    if (_chats is EqualUnmodifiableListView) return _chats;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_chats);
  }

  @override
  final String? errorMessage;

  /// Create a copy of ChatsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ChatsStateCopyWith<_ChatsState> get copyWith =>
      __$ChatsStateCopyWithImpl<_ChatsState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ChatsState &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._chats, _chats) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    status,
    const DeepCollectionEquality().hash(_chats),
    errorMessage,
  );

  @override
  String toString() {
    return 'ChatsState(status: $status, chats: $chats, errorMessage: $errorMessage)';
  }
}

/// @nodoc
abstract mixin class _$ChatsStateCopyWith<$Res>
    implements $ChatsStateCopyWith<$Res> {
  factory _$ChatsStateCopyWith(
    _ChatsState value,
    $Res Function(_ChatsState) _then,
  ) = __$ChatsStateCopyWithImpl;
  @override
  @useResult
  $Res call({NetworkStatus status, List<Chat> chats, String? errorMessage});
}

/// @nodoc
class __$ChatsStateCopyWithImpl<$Res> implements _$ChatsStateCopyWith<$Res> {
  __$ChatsStateCopyWithImpl(this._self, this._then);

  final _ChatsState _self;
  final $Res Function(_ChatsState) _then;

  /// Create a copy of ChatsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? status = null,
    Object? chats = null,
    Object? errorMessage = freezed,
  }) {
    return _then(
      _ChatsState(
        status: null == status
            ? _self.status
            : status // ignore: cast_nullable_to_non_nullable
                  as NetworkStatus,
        chats: null == chats
            ? _self._chats
            : chats // ignore: cast_nullable_to_non_nullable
                  as List<Chat>,
        errorMessage: freezed == errorMessage
            ? _self.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}
