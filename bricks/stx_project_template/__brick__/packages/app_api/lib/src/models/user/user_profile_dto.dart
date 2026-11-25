part of 'models.dart';

@freezed
sealed class UserProfileDto with _$UserProfileDto {
  const factory({
    @Default(0) int id,
    @Default('') String userName,
  }) = _UserProfileDto;

  factory fromJson(Map<String, dynamic> json) => _$UserProfileDtoFromJson(json);
}
