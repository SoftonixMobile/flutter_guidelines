// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'auth_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AuthEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AuthenticationStatus status)
        authenticationStatusChanged,
    required TResult Function() signOut,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(AuthenticationStatus status)? authenticationStatusChanged,
    TResult Function()? signOut,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AuthenticationStatus status)? authenticationStatusChanged,
    TResult Function()? signOut,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AuthenticationStatusChanged value)
        authenticationStatusChanged,
    required TResult Function(_SignOut value) signOut,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_AuthenticationStatusChanged value)?
        authenticationStatusChanged,
    TResult Function(_SignOut value)? signOut,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AuthenticationStatusChanged value)?
        authenticationStatusChanged,
    TResult Function(_SignOut value)? signOut,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthEventCopyWith<$Res> {
  factory $AuthEventCopyWith(AuthEvent value, $Res Function(AuthEvent) then) =
      _$AuthEventCopyWithImpl<$Res>;
}

/// @nodoc
class _$AuthEventCopyWithImpl<$Res> implements $AuthEventCopyWith<$Res> {
  _$AuthEventCopyWithImpl(this._value, this._then);

  final AuthEvent _value;
  // ignore: unused_field
  final $Res Function(AuthEvent) _then;
}

/// @nodoc
abstract class _$$_AuthenticationStatusChangedCopyWith<$Res> {
  factory _$$_AuthenticationStatusChangedCopyWith(
          _$_AuthenticationStatusChanged value,
          $Res Function(_$_AuthenticationStatusChanged) then) =
      __$$_AuthenticationStatusChangedCopyWithImpl<$Res>;
  $Res call({AuthenticationStatus status});
}

/// @nodoc
class __$$_AuthenticationStatusChangedCopyWithImpl<$Res>
    extends _$AuthEventCopyWithImpl<$Res>
    implements _$$_AuthenticationStatusChangedCopyWith<$Res> {
  __$$_AuthenticationStatusChangedCopyWithImpl(
      _$_AuthenticationStatusChanged _value,
      $Res Function(_$_AuthenticationStatusChanged) _then)
      : super(_value, (v) => _then(v as _$_AuthenticationStatusChanged));

  @override
  _$_AuthenticationStatusChanged get _value =>
      super._value as _$_AuthenticationStatusChanged;

  @override
  $Res call({
    Object? status = freezed,
  }) {
    return _then(_$_AuthenticationStatusChanged(
      status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as AuthenticationStatus,
    ));
  }
}

/// @nodoc

class _$_AuthenticationStatusChanged implements _AuthenticationStatusChanged {
  const _$_AuthenticationStatusChanged(this.status);

  @override
  final AuthenticationStatus status;

  @override
  String toString() {
    return 'AuthEvent.authenticationStatusChanged(status: $status)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AuthenticationStatusChanged &&
            const DeepCollectionEquality().equals(other.status, status));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(status));

  @JsonKey(ignore: true)
  @override
  _$$_AuthenticationStatusChangedCopyWith<_$_AuthenticationStatusChanged>
      get copyWith => __$$_AuthenticationStatusChangedCopyWithImpl<
          _$_AuthenticationStatusChanged>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AuthenticationStatus status)
        authenticationStatusChanged,
    required TResult Function() signOut,
  }) {
    return authenticationStatusChanged(status);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(AuthenticationStatus status)? authenticationStatusChanged,
    TResult Function()? signOut,
  }) {
    return authenticationStatusChanged?.call(status);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AuthenticationStatus status)? authenticationStatusChanged,
    TResult Function()? signOut,
    required TResult orElse(),
  }) {
    if (authenticationStatusChanged != null) {
      return authenticationStatusChanged(status);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AuthenticationStatusChanged value)
        authenticationStatusChanged,
    required TResult Function(_SignOut value) signOut,
  }) {
    return authenticationStatusChanged(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_AuthenticationStatusChanged value)?
        authenticationStatusChanged,
    TResult Function(_SignOut value)? signOut,
  }) {
    return authenticationStatusChanged?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AuthenticationStatusChanged value)?
        authenticationStatusChanged,
    TResult Function(_SignOut value)? signOut,
    required TResult orElse(),
  }) {
    if (authenticationStatusChanged != null) {
      return authenticationStatusChanged(this);
    }
    return orElse();
  }
}

abstract class _AuthenticationStatusChanged implements AuthEvent {
  const factory _AuthenticationStatusChanged(
      final AuthenticationStatus status) = _$_AuthenticationStatusChanged;

  AuthenticationStatus get status;
  @JsonKey(ignore: true)
  _$$_AuthenticationStatusChangedCopyWith<_$_AuthenticationStatusChanged>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$_SignOutCopyWith<$Res> {
  factory _$$_SignOutCopyWith(
          _$_SignOut value, $Res Function(_$_SignOut) then) =
      __$$_SignOutCopyWithImpl<$Res>;
}

/// @nodoc
class __$$_SignOutCopyWithImpl<$Res> extends _$AuthEventCopyWithImpl<$Res>
    implements _$$_SignOutCopyWith<$Res> {
  __$$_SignOutCopyWithImpl(_$_SignOut _value, $Res Function(_$_SignOut) _then)
      : super(_value, (v) => _then(v as _$_SignOut));

  @override
  _$_SignOut get _value => super._value as _$_SignOut;
}

/// @nodoc

class _$_SignOut implements _SignOut {
  const _$_SignOut();

  @override
  String toString() {
    return 'AuthEvent.signOut()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$_SignOut);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(AuthenticationStatus status)
        authenticationStatusChanged,
    required TResult Function() signOut,
  }) {
    return signOut();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(AuthenticationStatus status)? authenticationStatusChanged,
    TResult Function()? signOut,
  }) {
    return signOut?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(AuthenticationStatus status)? authenticationStatusChanged,
    TResult Function()? signOut,
    required TResult orElse(),
  }) {
    if (signOut != null) {
      return signOut();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_AuthenticationStatusChanged value)
        authenticationStatusChanged,
    required TResult Function(_SignOut value) signOut,
  }) {
    return signOut(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_AuthenticationStatusChanged value)?
        authenticationStatusChanged,
    TResult Function(_SignOut value)? signOut,
  }) {
    return signOut?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_AuthenticationStatusChanged value)?
        authenticationStatusChanged,
    TResult Function(_SignOut value)? signOut,
    required TResult orElse(),
  }) {
    if (signOut != null) {
      return signOut(this);
    }
    return orElse();
  }
}

abstract class _SignOut implements AuthEvent {
  const factory _SignOut() = _$_SignOut;
}

/// @nodoc
mixin _$AuthState {
  AuthenticationStatus get status => throw _privateConstructorUsedError;
  UserProfile get userProfile => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AuthStateCopyWith<AuthState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthStateCopyWith<$Res> {
  factory $AuthStateCopyWith(AuthState value, $Res Function(AuthState) then) =
      _$AuthStateCopyWithImpl<$Res>;
  $Res call({AuthenticationStatus status, UserProfile userProfile});

  $UserProfileCopyWith<$Res> get userProfile;
}

/// @nodoc
class _$AuthStateCopyWithImpl<$Res> implements $AuthStateCopyWith<$Res> {
  _$AuthStateCopyWithImpl(this._value, this._then);

  final AuthState _value;
  // ignore: unused_field
  final $Res Function(AuthState) _then;

  @override
  $Res call({
    Object? status = freezed,
    Object? userProfile = freezed,
  }) {
    return _then(_value.copyWith(
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as AuthenticationStatus,
      userProfile: userProfile == freezed
          ? _value.userProfile
          : userProfile // ignore: cast_nullable_to_non_nullable
              as UserProfile,
    ));
  }

  @override
  $UserProfileCopyWith<$Res> get userProfile {
    return $UserProfileCopyWith<$Res>(_value.userProfile, (value) {
      return _then(_value.copyWith(userProfile: value));
    });
  }
}

/// @nodoc
abstract class _$$_AuthStateCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory _$$_AuthStateCopyWith(
          _$_AuthState value, $Res Function(_$_AuthState) then) =
      __$$_AuthStateCopyWithImpl<$Res>;
  @override
  $Res call({AuthenticationStatus status, UserProfile userProfile});

  @override
  $UserProfileCopyWith<$Res> get userProfile;
}

/// @nodoc
class __$$_AuthStateCopyWithImpl<$Res> extends _$AuthStateCopyWithImpl<$Res>
    implements _$$_AuthStateCopyWith<$Res> {
  __$$_AuthStateCopyWithImpl(
      _$_AuthState _value, $Res Function(_$_AuthState) _then)
      : super(_value, (v) => _then(v as _$_AuthState));

  @override
  _$_AuthState get _value => super._value as _$_AuthState;

  @override
  $Res call({
    Object? status = freezed,
    Object? userProfile = freezed,
  }) {
    return _then(_$_AuthState(
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as AuthenticationStatus,
      userProfile: userProfile == freezed
          ? _value.userProfile
          : userProfile // ignore: cast_nullable_to_non_nullable
              as UserProfile,
    ));
  }
}

/// @nodoc

class _$_AuthState implements _AuthState {
  const _$_AuthState(
      {this.status = AuthenticationStatus.initial,
      this.userProfile = const UserProfile()});

  @override
  @JsonKey()
  final AuthenticationStatus status;
  @override
  @JsonKey()
  final UserProfile userProfile;

  @override
  String toString() {
    return 'AuthState(status: $status, userProfile: $userProfile)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AuthState &&
            const DeepCollectionEquality().equals(other.status, status) &&
            const DeepCollectionEquality()
                .equals(other.userProfile, userProfile));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(status),
      const DeepCollectionEquality().hash(userProfile));

  @JsonKey(ignore: true)
  @override
  _$$_AuthStateCopyWith<_$_AuthState> get copyWith =>
      __$$_AuthStateCopyWithImpl<_$_AuthState>(this, _$identity);
}

abstract class _AuthState implements AuthState {
  const factory _AuthState(
      {final AuthenticationStatus status,
      final UserProfile userProfile}) = _$_AuthState;

  @override
  AuthenticationStatus get status;
  @override
  UserProfile get userProfile;
  @override
  @JsonKey(ignore: true)
  _$$_AuthStateCopyWith<_$_AuthState> get copyWith =>
      throw _privateConstructorUsedError;
}
