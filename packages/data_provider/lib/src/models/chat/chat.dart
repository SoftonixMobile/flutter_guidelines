part of 'models.dart';

@freezed
sealed class Chat with _$Chat {
  const factory({
    @Default(0) int id,
    @Default('') String name,
  }) = _Chat;

  factory fromJson(Map<String, dynamic> json) => _$ChatFromJson(json);
}
