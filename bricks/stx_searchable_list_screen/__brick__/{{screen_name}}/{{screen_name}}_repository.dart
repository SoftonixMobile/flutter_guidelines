import 'package:injectable/injectable.dart';

import 'package:{{project_name}}/services/http/http_client.dart';

import 'models/models.dart';

@injectable
class {{#pascalCase}}{{screen_name}}{{/pascalCase}}Repository {
  {{#pascalCase}}{{screen_name}}{{/pascalCase}}Repository(this.httpClient);

  final HttpClient httpClient;

  Future<List<{{#pascalCase}}{{entity_name}}{{/pascalCase}}>> get{{#pascalCase}}{{entity_name}}{{/pascalCase}}s() async {
    await Future.delayed(const Duration(seconds: 2));

    return List.generate(
      10,
      (index) => {{#pascalCase}}{{entity_name}}{{/pascalCase}}(id: index, name: '{{#pascalCase}}{{entity_name}}{{/pascalCase}} $index'),
    );
  }
}
