import 'package:freezed_annotation/freezed_annotation.dart';

part 'models.freezed.dart';
part 'models.g.dart';

@freezed
class Post with _$Post {
  const factory Post({
    @Default(0) int id,
    @JsonKey(name: 'title') @Default('') String name,
  }) = _Post;

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
}
