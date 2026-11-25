part of 'models.dart';

@freezed
sealed class PostDto with _$PostDto {
  const factory({
    @Default(0) int id,
    @Default('') String title,
  }) = _PostDto;

  factory fromJson(Map<String, dynamic> json) => _$PostDtoFromJson(json);
}
