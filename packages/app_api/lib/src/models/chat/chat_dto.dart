part of 'models.dart';

@freezed
sealed class ChatDto with _$ChatDto {
  const factory({
    @Default(0) int id,
    @Default('') String name,
  }) = _ChatDto;

  factory fromJson(Map<String, dynamic> json) => _$ChatDtoFromJson(json);
}
