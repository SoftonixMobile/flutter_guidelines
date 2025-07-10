// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AuthEvent {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is AuthEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'AuthEvent()';
  }
}

/// @nodoc
class $AuthEventCopyWith<$Res> {
  $AuthEventCopyWith(AuthEvent _, $Res Function(AuthEvent) __);
}

/// @nodoc

class _AuthenticationStatusChanged implements AuthEvent {
  const _AuthenticationStatusChanged(this.status);

  final AuthStatus status;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AuthenticationStatusChangedCopyWith<_AuthenticationStatusChanged>
  get copyWith =>
      __$AuthenticationStatusChangedCopyWithImpl<_AuthenticationStatusChanged>(
        this,
        _$identity,
      );

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AuthenticationStatusChanged &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status);

  @override
  String toString() {
    return 'AuthEvent.authenticationStatusChanged(status: $status)';
  }
}

/// @nodoc
abstract mixin class _$AuthenticationStatusChangedCopyWith<$Res>
    implements $AuthEventCopyWith<$Res> {
  factory _$AuthenticationStatusChangedCopyWith(
    _AuthenticationStatusChanged value,
    $Res Function(_AuthenticationStatusChanged) _then,
  ) = __$AuthenticationStatusChangedCopyWithImpl;
  @useResult
  $Res call({AuthStatus status});
}

/// @nodoc
class __$AuthenticationStatusChangedCopyWithImpl<$Res>
    implements _$AuthenticationStatusChangedCopyWith<$Res> {
  __$AuthenticationStatusChangedCopyWithImpl(this._self, this._then);

  final _AuthenticationStatusChanged _self;
  final $Res Function(_AuthenticationStatusChanged) _then;

  /// Create a copy of AuthEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({Object? status = null}) {
    return _then(
      _AuthenticationStatusChanged(
        null == status
            ? _self.status
            : status // ignore: cast_nullable_to_non_nullable
                  as AuthStatus,
      ),
    );
  }
}

/// @nodoc

class _SignOut implements AuthEvent {
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
    return 'AuthEvent.signOut()';
  }
}

/// @nodoc
mixin _$AuthState {
  AuthStatus get status;
  UserProfile get userProfile;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AuthStateCopyWith<AuthState> get copyWith =>
      _$AuthStateCopyWithImpl<AuthState>(this as AuthState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AuthState &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.userProfile, userProfile) ||
                other.userProfile == userProfile));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status, userProfile);

  @override
  String toString() {
    return 'AuthState(status: $status, userProfile: $userProfile)';
  }
}

/// @nodoc
abstract mixin class $AuthStateCopyWith<$Res> {
  factory $AuthStateCopyWith(AuthState value, $Res Function(AuthState) _then) =
      _$AuthStateCopyWithImpl;
  @useResult
  $Res call({AuthStatus status, UserProfile userProfile});

  $UserProfileCopyWith<$Res> get userProfile;
}

/// @nodoc
class _$AuthStateCopyWithImpl<$Res> implements $AuthStateCopyWith<$Res> {
  _$AuthStateCopyWithImpl(this._self, this._then);

  final AuthState _self;
  final $Res Function(AuthState) _then;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? status = null, Object? userProfile = null}) {
    return _then(
      _self.copyWith(
        status: null == status
            ? _self.status
            : status // ignore: cast_nullable_to_non_nullable
                  as AuthStatus,
        userProfile: null == userProfile
            ? _self.userProfile
            : userProfile // ignore: cast_nullable_to_non_nullable
                  as UserProfile,
      ),
    );
  }

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserProfileCopyWith<$Res> get userProfile {
    return $UserProfileCopyWith<$Res>(_self.userProfile, (value) {
      return _then(_self.copyWith(userProfile: value));
    });
  }
}

/// @nodoc

class _AuthState implements AuthState {
  const _AuthState({
    this.status = AuthStatus.initial,
    this.userProfile = const UserProfile(),
  });

  @override
  @JsonKey()
  final AuthStatus status;
  @override
  @JsonKey()
  final UserProfile userProfile;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AuthStateCopyWith<_AuthState> get copyWith =>
      __$AuthStateCopyWithImpl<_AuthState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AuthState &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.userProfile, userProfile) ||
                other.userProfile == userProfile));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status, userProfile);

  @override
  String toString() {
    return 'AuthState(status: $status, userProfile: $userProfile)';
  }
}

/// @nodoc
abstract mixin class _$AuthStateCopyWith<$Res>
    implements $AuthStateCopyWith<$Res> {
  factory _$AuthStateCopyWith(
    _AuthState value,
    $Res Function(_AuthState) _then,
  ) = __$AuthStateCopyWithImpl;
  @override
  @useResult
  $Res call({AuthStatus status, UserProfile userProfile});

  @override
  $UserProfileCopyWith<$Res> get userProfile;
}

/// @nodoc
class __$AuthStateCopyWithImpl<$Res> implements _$AuthStateCopyWith<$Res> {
  __$AuthStateCopyWithImpl(this._self, this._then);

  final _AuthState _self;
  final $Res Function(_AuthState) _then;

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? status = null, Object? userProfile = null}) {
    return _then(
      _AuthState(
        status: null == status
            ? _self.status
            : status // ignore: cast_nullable_to_non_nullable
                  as AuthStatus,
        userProfile: null == userProfile
            ? _self.userProfile
            : userProfile // ignore: cast_nullable_to_non_nullable
                  as UserProfile,
      ),
    );
  }

  /// Create a copy of AuthState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UserProfileCopyWith<$Res> get userProfile {
    return $UserProfileCopyWith<$Res>(_self.userProfile, (value) {
      return _then(_self.copyWith(userProfile: value));
    });
  }
}
