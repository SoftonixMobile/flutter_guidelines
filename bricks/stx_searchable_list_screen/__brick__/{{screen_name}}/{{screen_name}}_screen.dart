import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'models/models.dart';
import '{{screen_name}}_bloc.dart';

export 'pages/index.dart';

class {{#pascalCase}}{{screen_name}}{{/pascalCase}}Screen extends StatelessWidget implements AutoRouteWrapper {
  const {{#pascalCase}}{{screen_name}}{{/pascalCase}}Screen({Key? key}) : super(key: key);

  @override
  Widget wrappedRoute(BuildContext context) {
    context.read<{{#pascalCase}}{{screen_name}}{{/pascalCase}}Bloc>().load();

    return this;
  }

  @override
  Widget build(BuildContext context) {
    final {{#camelCase}}{{screen_name}}{{/camelCase}}Bloc = context.read<{{#pascalCase}}{{screen_name}}{{/pascalCase}}Bloc>();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: {{#camelCase}}{{screen_name}}{{/camelCase}}Bloc.search,
          ),
        ),
        Expanded(
          child: BlocBuilder<{{#pascalCase}}{{screen_name}}{{/pascalCase}}Bloc, NetworkSearchableListState<{{#pascalCase}}{{entity_name}}{{/pascalCase}}>>(
            builder: (context, state) {
              switch (state.status) {
                case NetworkStatus.initial:
                case NetworkStatus.loading:
                  return const Center(child: CircularProgressIndicator());
                case NetworkStatus.success:
                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: state.visibleData.length,
                    itemBuilder: (context, index) {
                      final {{#camelCase}}{{entity_name}}{{/camelCase}} = state.visibleData[index];

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text({{#camelCase}}{{variable}}{{/camelCase}}.name),
                      );
                    },
                  );
                case NetworkStatus.failure:
                  return Center(child: Text(state.errorMessage ?? ''));
              }
            },
          ),
        ),
      ],
    );
  }
}
