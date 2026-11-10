// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserProfileDto {
  int get id;
  String get userName;

  /// Create a copy of UserProfileDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UserProfileDtoCopyWith<UserProfileDto> get copyWith =>
      _$UserProfileDtoCopyWithImpl<UserProfileDto>(
        this as UserProfileDto,
        _$identity,
      );

  /// Serializes this UserProfileDto to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    final _this = this as UserProfileDto;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UserProfileDto &&
            (identical(other.id, _this.id) || other.id == _this.id) &&
            (identical(other.userName, _this.userName) ||
                other.userName == _this.userName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    final _this = this as UserProfileDto;
    return Object.hash(runtimeType, _this.id, _this.userName);
  }

  @override
  String toString() {
    final _this = this as UserProfileDto;
    return 'UserProfileDto(id: ${_this.id}, userName: ${_this.userName})';
  }
}

/// @nodoc
abstract mixin class $UserProfileDtoCopyWith<$Res> {
  factory $UserProfileDtoCopyWith(
    UserProfileDto value,
    $Res Function(UserProfileDto) _then,
  ) = _$UserProfileDtoCopyWithImpl;
  @useResult
  $Res call({int id, String userName});
}

/// @nodoc
class _$UserProfileDtoCopyWithImpl<$Res>
    implements $UserProfileDtoCopyWith<$Res> {
  _$UserProfileDtoCopyWithImpl(this._self, this._then);

  final UserProfileDto _self;
  final $Res Function(UserProfileDto) _then;

  /// Create a copy of UserProfileDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? userName = null}) {
    return _then(
      UserProfileDto(
        id: null == id
            ? _self.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        userName: null == userName
            ? _self.userName
            : userName // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _UserProfileDto implements UserProfileDto {
  const _UserProfileDto({this.id = 0, this.userName = ''});
  factory _UserProfileDto.fromJson(Map<String, dynamic> json) =>
      _$UserProfileDtoFromJson(json);

  @override
  @JsonKey()
  final int id;
  @override
  @JsonKey()
  final String userName;

  /// Create a copy of UserProfileDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UserProfileDtoCopyWith<_UserProfileDto> get copyWith =>
      __$UserProfileDtoCopyWithImpl<_UserProfileDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UserProfileDtoToJson(this);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UserProfileDto &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userName, userName) ||
                other.userName == userName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    return Object.hash(runtimeType, id, userName);
  }

  @override
  String toString() {
    return 'UserProfileDto(id: $id, userName: $userName)';
  }
}

/// @nodoc
abstract mixin class _$UserProfileDtoCopyWith<$Res>
    implements $UserProfileDtoCopyWith<$Res> {
  factory _$UserProfileDtoCopyWith(
    _UserProfileDto value,
    $Res Function(_UserProfileDto) _then,
  ) = __$UserProfileDtoCopyWithImpl;
  @override
  @useResult
  $Res call({int id, String userName});
}

/// @nodoc
class __$UserProfileDtoCopyWithImpl<$Res>
    implements _$UserProfileDtoCopyWith<$Res> {
  __$UserProfileDtoCopyWithImpl(this._self, this._then);

  final _UserProfileDto _self;
  final $Res Function(_UserProfileDto) _then;

  /// Create a copy of UserProfileDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? id = null, Object? userName = null}) {
    return _then(
      _UserProfileDto(
        id: null == id
            ? _self.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        userName: null == userName
            ? _self.userName
            : userName // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}
