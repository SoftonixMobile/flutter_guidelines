part of 'models.dart';

@freezed
sealed class UserProfile with _$UserProfile {
  const factory({
    @Default(0) int id,
    @Default('') String userName,
  }) = _UserProfile;

  factory fromJson(Map<String, dynamic> json) => _$UserProfileFromJson(json);
}
