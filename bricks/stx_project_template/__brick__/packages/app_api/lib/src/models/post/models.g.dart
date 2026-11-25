// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PostDto _$PostDtoFromJson(Map<String, dynamic> json) => _PostDto(
  id: (json['id'] as num?)?.toInt() ?? 0,
  title: json['title'] as String? ?? '',
);

Map<String, dynamic> _$PostDtoToJson(_PostDto instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
};
