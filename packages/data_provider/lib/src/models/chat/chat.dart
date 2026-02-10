part of 'models.dart';

@freezed
sealed class Chat with _$Chat {
  const factory Chat({
    @Default(0) int id,
    @Default('') String name,
  }) = _Chat;

  factory Chat.fromJson(Map<String, dynamic> json) => _$ChatFromJson(json);
}
