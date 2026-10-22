// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SessionEvent {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is SessionEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'SessionEvent()';
  }
}

/// @nodoc
class $SessionEventCopyWith<$Res> {
  $SessionEventCopyWith(SessionEvent _, $Res Function(SessionEvent) __);
}

/// @nodoc

class _Subscribe implements SessionEvent {
  const _Subscribe();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _Subscribe);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'SessionEvent.subscribe()';
  }
}

/// @nodoc

class _SignOut implements SessionEvent {
  const _SignOut();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _SignOut);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'SessionEvent.signOut()';
  }
}

/// @nodoc
mixin _$SessionState {
  AuthStatus get authStatus;

  /// Create a copy of SessionState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SessionStateCopyWith<SessionState> get copyWith =>
      _$SessionStateCopyWithImpl<SessionState>(
        this as SessionState,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    final _this = this as SessionState;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SessionState &&
            (identical(other.authStatus, _this.authStatus) ||
                other.authStatus == _this.authStatus));
  }

  @override
  int get hashCode {
    final _this = this as SessionState;
    return Object.hash(runtimeType, _this.authStatus);
  }

  @override
  String toString() {
    final _this = this as SessionState;
    return 'SessionState(authStatus: ${_this.authStatus})';
  }
}

/// @nodoc
abstract mixin class $SessionStateCopyWith<$Res> {
  factory $SessionStateCopyWith(
    SessionState value,
    $Res Function(SessionState) _then,
  ) = _$SessionStateCopyWithImpl;
  @useResult
  $Res call({AuthStatus authStatus});
}

/// @nodoc
class _$SessionStateCopyWithImpl<$Res> implements $SessionStateCopyWith<$Res> {
  _$SessionStateCopyWithImpl(this._self, this._then);

  final SessionState _self;
  final $Res Function(SessionState) _then;

  /// Create a copy of SessionState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? authStatus = null}) {
    return _then(
      SessionState(
        authStatus: null == authStatus
            ? _self.authStatus
            : authStatus // ignore: cast_nullable_to_non_nullable
                  as AuthStatus,
      ),
    );
  }
}

/// @nodoc

class _SessionState implements SessionState {
  const _SessionState({this.authStatus = AuthStatus.initial});

  @override
  @JsonKey()
  final AuthStatus authStatus;

  /// Create a copy of SessionState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SessionStateCopyWith<_SessionState> get copyWith =>
      __$SessionStateCopyWithImpl<_SessionState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SessionState &&
            (identical(other.authStatus, authStatus) ||
                other.authStatus == authStatus));
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, authStatus);
  }

  @override
  String toString() {
    return 'SessionState(authStatus: $authStatus)';
  }
}

/// @nodoc
abstract mixin class _$SessionStateCopyWith<$Res>
    implements $SessionStateCopyWith<$Res> {
  factory _$SessionStateCopyWith(
    _SessionState value,
    $Res Function(_SessionState) _then,
  ) = __$SessionStateCopyWithImpl;
  @override
  @useResult
  $Res call({AuthStatus authStatus});
}

/// @nodoc
class __$SessionStateCopyWithImpl<$Res>
    implements _$SessionStateCopyWith<$Res> {
  __$SessionStateCopyWithImpl(this._self, this._then);

  final _SessionState _self;
  final $Res Function(_SessionState) _then;

  /// Create a copy of SessionState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? authStatus = null}) {
    return _then(
      _SessionState(
        authStatus: null == authStatus
            ? _self.authStatus
            : authStatus // ignore: cast_nullable_to_non_nullable
                  as AuthStatus,
      ),
    );
  }
}
