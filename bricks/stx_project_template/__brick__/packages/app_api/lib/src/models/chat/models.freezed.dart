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
mixin _$ChatDto {
  int get id;
  String get name;

  /// Create a copy of ChatDto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ChatDtoCopyWith<ChatDto> get copyWith =>
      _$ChatDtoCopyWithImpl<ChatDto>(this as ChatDto, _$identity);

  /// Serializes this ChatDto to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    final _this = this as ChatDto;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ChatDto &&
            (identical(other.id, _this.id) || other.id == _this.id) &&
            (identical(other.name, _this.name) || other.name == _this.name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    final _this = this as ChatDto;
    return Object.hash(runtimeType, _this.id, _this.name);
  }

  @override
  String toString() {
    final _this = this as ChatDto;
    return 'ChatDto(id: ${_this.id}, name: ${_this.name})';
  }
}

/// @nodoc
abstract mixin class $ChatDtoCopyWith<$Res> {
  factory $ChatDtoCopyWith(ChatDto value, $Res Function(ChatDto) _then) =
      _$ChatDtoCopyWithImpl;
  @useResult
  $Res call({int id, String name});
}

/// @nodoc
class _$ChatDtoCopyWithImpl<$Res> implements $ChatDtoCopyWith<$Res> {
  _$ChatDtoCopyWithImpl(this._self, this._then);

  final ChatDto _self;
  final $Res Function(ChatDto) _then;

  /// Create a copy of ChatDto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? id = null, Object? name = null}) {
    return _then(
      ChatDto(
        id: null == id
            ? _self.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _self.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _ChatDto implements ChatDto {
  const _ChatDto({this.id = 0, this.name = ''});
  factory _ChatDto.fromJson(Map<String, dynamic> json) =>
      _$ChatDtoFromJson(json);

  @override
  @JsonKey()
  final int id;
  @override
  @JsonKey()
  final String name;

  /// Create a copy of ChatDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ChatDtoCopyWith<_ChatDto> get copyWith =>
      __$ChatDtoCopyWithImpl<_ChatDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$ChatDtoToJson(this);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ChatDto &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    return Object.hash(runtimeType, id, name);
  }

  @override
  String toString() {
    return 'ChatDto(id: $id, name: $name)';
  }
}

/// @nodoc
abstract mixin class _$ChatDtoCopyWith<$Res> implements $ChatDtoCopyWith<$Res> {
  factory _$ChatDtoCopyWith(_ChatDto value, $Res Function(_ChatDto) _then) =
      __$ChatDtoCopyWithImpl;
  @override
  @useResult
  $Res call({int id, String name});
}

/// @nodoc
class __$ChatDtoCopyWithImpl<$Res> implements _$ChatDtoCopyWith<$Res> {
  __$ChatDtoCopyWithImpl(this._self, this._then);

  final _ChatDto _self;
  final $Res Function(_ChatDto) _then;

  /// Create a copy of ChatDto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? id = null, Object? name = null}) {
    return _then(
      _ChatDto(
        id: null == id
            ? _self.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        name: null == name
            ? _self.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}
