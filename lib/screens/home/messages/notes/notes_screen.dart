import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_guidelines/models/index.dart';

import 'models/models.dart';
import 'notes_bloc.dart';

export 'pages/index.dart';

class NotesScreen extends StatelessWidget implements AutoRouteWrapper {
  const NotesScreen({Key? key}) : super(key: key);

  @override
  Widget wrappedRoute(BuildContext context) {
    context.read<NotesBloc>().load();

    return this;
  }

  @override
  Widget build(BuildContext context) {
    final notesBloc = context.read<NotesBloc>();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: notesBloc.search,
          ),
        ),
        Expanded(
          child: BlocBuilder<NotesBloc, NetworkSearchableListState<Note>>(
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
                      final note = state.visibleData[index];

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(note.name),
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
