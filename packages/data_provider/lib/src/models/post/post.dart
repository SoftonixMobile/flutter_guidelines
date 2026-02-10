part of 'models.dart';

@freezed
sealed class Post with _$Post {
  const factory Post({
    @Default(0) int id,
    @JsonKey(name: 'title') @Default('') String name,
  }) = _Post;

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
}
