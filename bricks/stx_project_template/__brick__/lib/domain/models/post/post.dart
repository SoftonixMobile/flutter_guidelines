import 'package:freezed_annotation/freezed_annotation.dart';

part 'post.freezed.dart';

@freezed
sealed class Post with _$Post {
  const factory({
    @Default(0) int id,
    @Default('') String name,
  }) = _Post;
}
