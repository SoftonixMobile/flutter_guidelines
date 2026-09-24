part of 'models.dart';

@freezed
sealed class AuthResponse with _$AuthResponse {
  const factory({
    required String accessToken,
    required String refreshToken,
  }) = _AuthResponse;

  factory fromJson(Map<String, dynamic> json) => _$AuthResponseFromJson(json);
}
