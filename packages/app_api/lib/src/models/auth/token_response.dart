part of 'models.dart';

@freezed
sealed class TokenResponse with _$TokenResponse {
  const factory({
    required String accessToken,
    required String refreshToken,
  }) = _TokenResponse;

  factory fromJson(Map<String, dynamic> json) => _$TokenResponseFromJson(json);
}
