import 'package:freezed_annotation/freezed_annotation.dart';

part 'post.freezed.dart';
part 'post.g.dart';

@freezed
sealed class Post with _$Post {
  const factory({
    @Default(0) int id,
    @JsonKey(name: 'title') @Default('') String name,
  }) = _Post;

  factory fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
}
