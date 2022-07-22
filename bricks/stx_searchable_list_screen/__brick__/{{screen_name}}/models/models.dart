import 'package:freezed_annotation/freezed_annotation.dart';

part 'models.freezed.dart';
part 'models.g.dart';

@freezed
class {{#pascalCase}}{{entity_name}}{{/pascalCase}} with _${{#pascalCase}}{{entity_name}}{{/pascalCase}} {
  const factory {{#pascalCase}}{{entity_name}}{{/pascalCase}}({
    @Default(0) int id,
    @Default('') String name,
  }) = _{{#pascalCase}}{{entity_name}}{{/pascalCase}};

  factory {{#pascalCase}}{{entity_name}}{{/pascalCase}}.fromJson(Map<String, dynamic> json) => _${{#pascalCase}}{{entity_name}}{{/pascalCase}}FromJson(json);
}
