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
mixin _$TokenResponse {
  String get accessToken;
  String get refreshToken;

  /// Create a copy of TokenResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $TokenResponseCopyWith<TokenResponse> get copyWith =>
      _$TokenResponseCopyWithImpl<TokenResponse>(
        this as TokenResponse,
        _$identity,
      );

  /// Serializes this TokenResponse to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    final _this = this as TokenResponse;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TokenResponse &&
            (identical(other.accessToken, _this.accessToken) ||
                other.accessToken == _this.accessToken) &&
            (identical(other.refreshToken, _this.refreshToken) ||
                other.refreshToken == _this.refreshToken));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    final _this = this as TokenResponse;
    return Object.hash(runtimeType, _this.accessToken, _this.refreshToken);
  }

  @override
  String toString() {
    final _this = this as TokenResponse;
    return 'TokenResponse(accessToken: ${_this.accessToken}, refreshToken: ${_this.refreshToken})';
  }
}

/// @nodoc
abstract mixin class $TokenResponseCopyWith<$Res> {
  factory $TokenResponseCopyWith(
    TokenResponse value,
    $Res Function(TokenResponse) _then,
  ) = _$TokenResponseCopyWithImpl;
  @useResult
  $Res call({String accessToken, String refreshToken});
}

/// @nodoc
class _$TokenResponseCopyWithImpl<$Res>
    implements $TokenResponseCopyWith<$Res> {
  _$TokenResponseCopyWithImpl(this._self, this._then);

  final TokenResponse _self;
  final $Res Function(TokenResponse) _then;

  /// Create a copy of TokenResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? accessToken = null, Object? refreshToken = null}) {
    return _then(
      TokenResponse(
        accessToken: null == accessToken
            ? _self.accessToken
            : accessToken // ignore: cast_nullable_to_non_nullable
                  as String,
        refreshToken: null == refreshToken
            ? _self.refreshToken
            : refreshToken // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _TokenResponse implements TokenResponse {
  const _TokenResponse({required this.accessToken, required this.refreshToken});
  factory _TokenResponse.fromJson(Map<String, dynamic> json) =>
      _$TokenResponseFromJson(json);

  @override
  final String accessToken;
  @override
  final String refreshToken;

  /// Create a copy of TokenResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$TokenResponseCopyWith<_TokenResponse> get copyWith =>
      __$TokenResponseCopyWithImpl<_TokenResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$TokenResponseToJson(this);
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _TokenResponse &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken) &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode {
    return Object.hash(runtimeType, accessToken, refreshToken);
  }

  @override
  String toString() {
    return 'TokenResponse(accessToken: $accessToken, refreshToken: $refreshToken)';
  }
}

/// @nodoc
abstract mixin class _$TokenResponseCopyWith<$Res>
    implements $TokenResponseCopyWith<$Res> {
  factory _$TokenResponseCopyWith(
    _TokenResponse value,
    $Res Function(_TokenResponse) _then,
  ) = __$TokenResponseCopyWithImpl;
  @override
  @useResult
  $Res call({String accessToken, String refreshToken});
}

/// @nodoc
class __$TokenResponseCopyWithImpl<$Res>
    implements _$TokenResponseCopyWith<$Res> {
  __$TokenResponseCopyWithImpl(this._self, this._then);

  final _TokenResponse _self;
  final $Res Function(_TokenResponse) _then;

  /// Create a copy of TokenResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({Object? accessToken = null, Object? refreshToken = null}) {
    return _then(
      _TokenResponse(
        accessToken: null == accessToken
            ? _self.accessToken
            : accessToken // ignore: cast_nullable_to_non_nullable
                  as String,
        refreshToken: null == refreshToken
            ? _self.refreshToken
            : refreshToken // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}
