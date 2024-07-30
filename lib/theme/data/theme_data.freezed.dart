// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'theme_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AppThemeData {
  AppColorsData get colors => throw _privateConstructorUsedError;
  AppTypographyData get typography => throw _privateConstructorUsedError;

  /// Create a copy of AppThemeData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppThemeDataCopyWith<AppThemeData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppThemeDataCopyWith<$Res> {
  factory $AppThemeDataCopyWith(
          AppThemeData value, $Res Function(AppThemeData) then) =
      _$AppThemeDataCopyWithImpl<$Res, AppThemeData>;
  @useResult
  $Res call({AppColorsData colors, AppTypographyData typography});

  $AppColorsDataCopyWith<$Res> get colors;
  $AppTypographyDataCopyWith<$Res> get typography;
}

/// @nodoc
class _$AppThemeDataCopyWithImpl<$Res, $Val extends AppThemeData>
    implements $AppThemeDataCopyWith<$Res> {
  _$AppThemeDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppThemeData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? colors = null,
    Object? typography = null,
  }) {
    return _then(_value.copyWith(
      colors: null == colors
          ? _value.colors
          : colors // ignore: cast_nullable_to_non_nullable
              as AppColorsData,
      typography: null == typography
          ? _value.typography
          : typography // ignore: cast_nullable_to_non_nullable
              as AppTypographyData,
    ) as $Val);
  }

  /// Create a copy of AppThemeData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AppColorsDataCopyWith<$Res> get colors {
    return $AppColorsDataCopyWith<$Res>(_value.colors, (value) {
      return _then(_value.copyWith(colors: value) as $Val);
    });
  }

  /// Create a copy of AppThemeData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AppTypographyDataCopyWith<$Res> get typography {
    return $AppTypographyDataCopyWith<$Res>(_value.typography, (value) {
      return _then(_value.copyWith(typography: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AppThemeDataImplCopyWith<$Res>
    implements $AppThemeDataCopyWith<$Res> {
  factory _$$AppThemeDataImplCopyWith(
          _$AppThemeDataImpl value, $Res Function(_$AppThemeDataImpl) then) =
      __$$AppThemeDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AppColorsData colors, AppTypographyData typography});

  @override
  $AppColorsDataCopyWith<$Res> get colors;
  @override
  $AppTypographyDataCopyWith<$Res> get typography;
}

/// @nodoc
class __$$AppThemeDataImplCopyWithImpl<$Res>
    extends _$AppThemeDataCopyWithImpl<$Res, _$AppThemeDataImpl>
    implements _$$AppThemeDataImplCopyWith<$Res> {
  __$$AppThemeDataImplCopyWithImpl(
      _$AppThemeDataImpl _value, $Res Function(_$AppThemeDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of AppThemeData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? colors = null,
    Object? typography = null,
  }) {
    return _then(_$AppThemeDataImpl(
      colors: null == colors
          ? _value.colors
          : colors // ignore: cast_nullable_to_non_nullable
              as AppColorsData,
      typography: null == typography
          ? _value.typography
          : typography // ignore: cast_nullable_to_non_nullable
              as AppTypographyData,
    ));
  }
}

/// @nodoc

class _$AppThemeDataImpl implements _AppThemeData {
  const _$AppThemeDataImpl({required this.colors, required this.typography});

  @override
  final AppColorsData colors;
  @override
  final AppTypographyData typography;

  @override
  String toString() {
    return 'AppThemeData(colors: $colors, typography: $typography)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppThemeDataImpl &&
            (identical(other.colors, colors) || other.colors == colors) &&
            (identical(other.typography, typography) ||
                other.typography == typography));
  }

  @override
  int get hashCode => Object.hash(runtimeType, colors, typography);

  /// Create a copy of AppThemeData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppThemeDataImplCopyWith<_$AppThemeDataImpl> get copyWith =>
      __$$AppThemeDataImplCopyWithImpl<_$AppThemeDataImpl>(this, _$identity);
}

abstract class _AppThemeData implements AppThemeData {
  const factory _AppThemeData(
      {required final AppColorsData colors,
      required final AppTypographyData typography}) = _$AppThemeDataImpl;

  @override
  AppColorsData get colors;
  @override
  AppTypographyData get typography;

  /// Create a copy of AppThemeData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppThemeDataImplCopyWith<_$AppThemeDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
