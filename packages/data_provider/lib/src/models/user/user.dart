part of 'models.dart';

@freezed
sealed class UserProfile with _$UserProfile {
  const factory UserProfile({@Default(0) int id, String? userName}) =
      _UserProfile;

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);
}
