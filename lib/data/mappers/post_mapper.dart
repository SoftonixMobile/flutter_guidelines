import 'package:app_api/models.dart';

import 'package:flutter_guidelines/domain/models/index.dart';

extension PostDtoMapper on PostDto {
  Post toDomain() => Post(id: id, name: title);
}

extension PostMapper on Post {
  PostDto toDto() => PostDto(id: id, title: name);
}
