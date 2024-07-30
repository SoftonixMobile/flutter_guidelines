// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'colors_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AppColorsData {
  Color get primary => throw _privateConstructorUsedError;
  Color get add => throw _privateConstructorUsedError;
  Color get grey => throw _privateConstructorUsedError;
  Color get black => throw _privateConstructorUsedError;
  Color get white => throw _privateConstructorUsedError;

  /// Create a copy of AppColorsData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AppColorsDataCopyWith<AppColorsData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppColorsDataCopyWith<$Res> {
  factory $AppColorsDataCopyWith(
          AppColorsData value, $Res Function(AppColorsData) then) =
      _$AppColorsDataCopyWithImpl<$Res, AppColorsData>;
  @useResult
  $Res call({Color primary, Color add, Color grey, Color black, Color white});
}

/// @nodoc
class _$AppColorsDataCopyWithImpl<$Res, $Val extends AppColorsData>
    implements $AppColorsDataCopyWith<$Res> {
  _$AppColorsDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AppColorsData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? primary = null,
    Object? add = null,
    Object? grey = null,
    Object? black = null,
    Object? white = null,
  }) {
    return _then(_value.copyWith(
      primary: null == primary
          ? _value.primary
          : primary // ignore: cast_nullable_to_non_nullable
              as Color,
      add: null == add
          ? _value.add
          : add // ignore: cast_nullable_to_non_nullable
              as Color,
      grey: null == grey
          ? _value.grey
          : grey // ignore: cast_nullable_to_non_nullable
              as Color,
      black: null == black
          ? _value.black
          : black // ignore: cast_nullable_to_non_nullable
              as Color,
      white: null == white
          ? _value.white
          : white // ignore: cast_nullable_to_non_nullable
              as Color,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppColorsDataImplCopyWith<$Res>
    implements $AppColorsDataCopyWith<$Res> {
  factory _$$AppColorsDataImplCopyWith(
          _$AppColorsDataImpl value, $Res Function(_$AppColorsDataImpl) then) =
      __$$AppColorsDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Color primary, Color add, Color grey, Color black, Color white});
}

/// @nodoc
class __$$AppColorsDataImplCopyWithImpl<$Res>
    extends _$AppColorsDataCopyWithImpl<$Res, _$AppColorsDataImpl>
    implements _$$AppColorsDataImplCopyWith<$Res> {
  __$$AppColorsDataImplCopyWithImpl(
      _$AppColorsDataImpl _value, $Res Function(_$AppColorsDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of AppColorsData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? primary = null,
    Object? add = null,
    Object? grey = null,
    Object? black = null,
    Object? white = null,
  }) {
    return _then(_$AppColorsDataImpl(
      primary: null == primary
          ? _value.primary
          : primary // ignore: cast_nullable_to_non_nullable
              as Color,
      add: null == add
          ? _value.add
          : add // ignore: cast_nullable_to_non_nullable
              as Color,
      grey: null == grey
          ? _value.grey
          : grey // ignore: cast_nullable_to_non_nullable
              as Color,
      black: null == black
          ? _value.black
          : black // ignore: cast_nullable_to_non_nullable
              as Color,
      white: null == white
          ? _value.white
          : white // ignore: cast_nullable_to_non_nullable
              as Color,
    ));
  }
}

/// @nodoc

class _$AppColorsDataImpl implements _AppColorsData {
  const _$AppColorsDataImpl(
      {required this.primary,
      required this.add,
      required this.grey,
      required this.black,
      required this.white});

  @override
  final Color primary;
  @override
  final Color add;
  @override
  final Color grey;
  @override
  final Color black;
  @override
  final Color white;

  @override
  String toString() {
    return 'AppColorsData(primary: $primary, add: $add, grey: $grey, black: $black, white: $white)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppColorsDataImpl &&
            (identical(other.primary, primary) || other.primary == primary) &&
            (identical(other.add, add) || other.add == add) &&
            (identical(other.grey, grey) || other.grey == grey) &&
            (identical(other.black, black) || other.black == black) &&
            (identical(other.white, white) || other.white == white));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, primary, add, grey, black, white);

  /// Create a copy of AppColorsData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AppColorsDataImplCopyWith<_$AppColorsDataImpl> get copyWith =>
      __$$AppColorsDataImplCopyWithImpl<_$AppColorsDataImpl>(this, _$identity);
}

abstract class _AppColorsData implements AppColorsData {
  const factory _AppColorsData(
      {required final Color primary,
      required final Color add,
      required final Color grey,
      required final Color black,
      required final Color white}) = _$AppColorsDataImpl;

  @override
  Color get primary;
  @override
  Color get add;
  @override
  Color get grey;
  @override
  Color get black;
  @override
  Color get white;

  /// Create a copy of AppColorsData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AppColorsDataImplCopyWith<_$AppColorsDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
