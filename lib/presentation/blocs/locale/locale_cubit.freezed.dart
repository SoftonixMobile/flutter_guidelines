// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'locale_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LocaleState {
  AppLocale get current;
  List<AppLocale> get available;

  /// Create a copy of LocaleState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LocaleStateCopyWith<LocaleState> get copyWith =>
      _$LocaleStateCopyWithImpl<LocaleState>(this as LocaleState, _$identity);

  @override
  bool operator ==(Object other) {
    final _this = this as LocaleState;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LocaleState &&
            (identical(other.current, _this.current) ||
                other.current == _this.current) &&
            const DeepCollectionEquality().equals(
              other.available,
              _this.available,
            ));
  }

  @override
  int get hashCode {
    final _this = this as LocaleState;
    return Object.hash(
      runtimeType,
      _this.current,
      const DeepCollectionEquality().hash(_this.available),
    );
  }

  @override
  String toString() {
    final _this = this as LocaleState;
    return 'LocaleState(current: ${_this.current}, available: ${_this.available})';
  }
}

/// @nodoc
abstract mixin class $LocaleStateCopyWith<$Res> {
  factory $LocaleStateCopyWith(
    LocaleState value,
    $Res Function(LocaleState) _then,
  ) = _$LocaleStateCopyWithImpl;
  @useResult
  $Res call({AppLocale current, List<AppLocale> available});
}

/// @nodoc
class _$LocaleStateCopyWithImpl<$Res> implements $LocaleStateCopyWith<$Res> {
  _$LocaleStateCopyWithImpl(this._self, this._then);

  final LocaleState _self;
  final $Res Function(LocaleState) _then;

  /// Create a copy of LocaleState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? current = null, Object? available = null}) {
    return _then(
      LocaleState(
        current: null == current
            ? _self.current
            : current // ignore: cast_nullable_to_non_nullable
                  as AppLocale,
        available: null == available
            ? _self.available
            : available // ignore: cast_nullable_to_non_nullable
                  as List<AppLocale>,
      ),
    );
  }
}

/// @nodoc

class _LocaleState implements LocaleState {
  const _LocaleState({
    required this.current,
    List<AppLocale> available = AppLocale.values,
  }) : _available = available;

  @override
  final AppLocale current;
  final List<AppLocale> _available;
  @override
  @JsonKey()
  List<AppLocale> get available {
    if (_available is EqualUnmodifiableListView) return _available;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_available);
  }

  /// Create a copy of LocaleState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LocaleStateCopyWith<_LocaleState> get copyWith =>
      __$LocaleStateCopyWithImpl<_LocaleState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LocaleState &&
            (identical(other.current, current) || other.current == current) &&
            const DeepCollectionEquality().equals(other.available, _available));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType,
      current,
      const DeepCollectionEquality().hash(_available),
    );
  }

  @override
  String toString() {
    return 'LocaleState(current: $current, available: $available)';
  }
}

/// @nodoc
abstract mixin class _$LocaleStateCopyWith<$Res>
    implements $LocaleStateCopyWith<$Res> {
  factory _$LocaleStateCopyWith(
    _LocaleState value,
    $Res Function(_LocaleState) _then,
  ) = __$LocaleStateCopyWithImpl;
  @override
  @useResult
  $Res call({AppLocale current, List<AppLocale> available});
}

/// @nodoc
class __$LocaleStateCopyWithImpl<$Res> implements _$LocaleStateCopyWith<$Res> {
  __$LocaleStateCopyWithImpl(this._self, this._then);

  final _LocaleState _self;
  final $Res Function(_LocaleState) _then;

  /// Create a copy of LocaleState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? current = null, Object? available = null}) {
    return _then(
      _LocaleState(
        current: null == current
            ? _self.current
            : current // ignore: cast_nullable_to_non_nullable
                  as AppLocale,
        available: null == available
            ? _self._available
            : available // ignore: cast_nullable_to_non_nullable
                  as List<AppLocale>,
      ),
    );
  }
}
