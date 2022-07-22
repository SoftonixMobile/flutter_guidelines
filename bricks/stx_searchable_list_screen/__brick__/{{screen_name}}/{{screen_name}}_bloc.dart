import 'package:injectable/injectable.dart';
import 'package:stx_bloc_base/stx_bloc_base.dart';

import 'models/models.dart';
import '{{screen_name}}_repository.dart';

@injectable
class {{#pascalCase}}{{screen_name}}{{/pascalCase}}Bloc
    extends NetworkSearchableListBloc<{{#pascalCase}}{{entity_name}}{{/pascalCase}}, NetworkSearchableListState<{{#pascalCase}}{{entity_name}}{{/pascalCase}}>> {
  {{#pascalCase}}{{screen_name}}{{/pascalCase}}Bloc(this.repository) : super(NetworkSearchableListState());

  final {{#pascalCase}}{{screen_name}}{{/pascalCase}}Repository repository;

  @override
  Future<List<{{#pascalCase}}{{entity_name}}{{/pascalCase}}>> onLoadDataAsync() {
    return repository.get{{#pascalCase}}{{entity_name}}{{/pascalCase}}s();
  }

  @override
  bool equals({{#pascalCase}}{{entity_name}}{{/pascalCase}} item1, {{#pascalCase}}{{entity_name}}{{/pascalCase}} item2) {
    return item1.id == item2.id;
  }

  @override
  NetworkSearchableListState<{{#pascalCase}}{{entity_name}}{{/pascalCase}}> onStateChanged(
      NetworkEventBase event, NetworkSearchableListState<{{#pascalCase}}{{entity_name}}{{/pascalCase}}> state) {
    final query = state.query;

    var visibleData = state.data;

    if (query != null && query.isNotEmpty) {
      visibleData =
          visibleData.where((item) => item.name.contains(query)).toList();
    }

    return state.copyWith(visibleData: visibleData);
  }
}
